import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pages.dart'; // Certifique-se de que esse import está correto
import 'package:uniconnecta/components/cep.dart';
import 'package:uniconnecta/components/button.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _cepController = TextEditingController();
  final _ruaController = TextEditingController();
  final _bairroController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isFetchingAddress = false; // Controle para evitar múltiplos fetches

  void _onCepChanged(String value) async {
    if (value.length == 8 && !_isFetchingAddress) {
      setState(() {
        _isFetchingAddress = true; // Sinaliza o início da busca
      });

      try {
        final address = await fetchAddressFromCep(value);
        if (address != null) {
          setState(() {
            _ruaController.text = address['rua'] ?? '';
            _bairroController.text = address['bairro'] ?? '';
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('CEP não encontrado.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao buscar o endereço.')),
        );
      } finally {
        setState(() {
          _isFetchingAddress = false; // Finaliza a busca
        });
      }
    }
  }

  Future<void> _saveLocationData() async {
    final cep = _cepController.text.trim();
    final rua = _ruaController.text.trim();
    final bairro = _bairroController.text.trim();

    try {
      if (cep.isNotEmpty || rua.isNotEmpty || bairro.isNotEmpty) {
        await _firestore.collection('locations').add({
          'cep': cep,
          'rua': rua,
          'bairro': bairro,
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Dados salvos com sucesso!')),
        );
      }

      // Certifique-se de navegar após o await
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar os dados: $e')),
      );
    }
  }

  @override
  void dispose() {
    _cepController.dispose();
    _ruaController.dispose();
    _bairroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                'Por fim, em que cidade você está atualmente?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              TextField(
                controller: _cepController,
                decoration: InputDecoration(
                  labelText: 'CEP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                maxLength: 8, // O CEP tem 8 dígitos
                onChanged:
                    _onCepChanged, // Corrigido: passa o valor corretamente
              ),
              SizedBox(height: 20),
              TextField(
                controller: _ruaController,
                decoration: InputDecoration(
                  labelText: 'Rua',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _bairroController,
                decoration: InputDecoration(
                  labelText: 'Bairro',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(height: 30),
              MyButton(
                buttonProportion: 0.8,
                marginSize: 16.0,
                label: 'Continuar',
                isPrimary: true,
                onPressedButton: _saveLocationData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
