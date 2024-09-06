import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uniconnecta/components/components.dart';
import 'pages.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final _cepController = TextEditingController();
  final _ruaController = TextEditingController();
  final _bairroController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> _onCepChanged() async {
    final cep = _cepController.text;
    if (cep.length == 8) {
      try {
        final address = await fetchAddressFromCep(cep);
        setState(() {
          _ruaController.text = address['rua'] ?? '';
          _bairroController.text = address['bairro'] ?? '';
        });
      } catch (e) {
        print(e); // Imprime o erro no console
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('CEP não encontrado.')),
        );
      }
    }
  }

  Future<void> _saveLocationData() async {
    final cep = _cepController.text.trim();
    final rua = _ruaController.text.trim();
    final bairro = _bairroController.text.trim();

    try {
      // Salva os dados se houver algum dado preenchido
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

      // Navega para a próxima tela independentemente dos dados preenchidos
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print(e); // Imprime o erro no console
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
        title: Text('Localização', style: TextStyle(color: Colors.black)),
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
              SizedBox(height: 20),
              Text(
                'é para colocar apenas numeros',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
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
                maxLength: 9,
                onChanged: (value) => _onCepChanged(),
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
