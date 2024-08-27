import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<Map<String, String>> fetchAddressFromCep(String cep) async {
  final response =
      await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data.containsKey('erro') && data['erro'] == true) {
      throw Exception('CEP não encontrado');
    }
    return {
      'rua': data['logradouro'] ?? '',
      'bairro': data['bairro'] ?? '',
    };
  } else {
    throw Exception('Erro ao buscar o CEP');
  }
}
