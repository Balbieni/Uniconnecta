import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uniconnecta/pages/pages.dart';

class _LocationScreenState extends State<LocationScreen> {
  final _cepController = TextEditingController();
  final _ruaController = TextEditingController();
  final _bairroController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _saveLocationData() async {
    final cep = _cepController.text;
    final rua = _ruaController.text;
    final bairro = _bairroController.text;

    if (cep.isNotEmpty && rua.isNotEmpty && bairro.isNotEmpty) {
      try {
        await _firestore.collection('locations').add({
          'cep': cep,
          'rua': rua,
          'bairro': bairro,
          'timestamp': FieldValue.serverTimestamp(),
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar os dados: $e'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
