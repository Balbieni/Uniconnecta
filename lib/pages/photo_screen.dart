import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:uniconnecta/components/components.dart'; // Certifique-se de que MyButton está nesse arquivo
import 'pages.dart';

class PhotoScreen extends StatefulWidget {
  final String userId; // Recebe o UID do usuário

  const PhotoScreen({required this.userId});

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // Função para fazer upload da imagem no Firebase Storage
  Future<void> _uploadImage() async {
    if (_image == null) return;

    try {
      // Referência para o Firebase Storage
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('user_photos/${widget.userId}.jpg');

      // Faz o upload do arquivo
      UploadTask uploadTask = ref.putFile(_image!);
      TaskSnapshot snapshot = await uploadTask;

      // Obtém o URL da imagem
      String photoUrl = await snapshot.ref.getDownloadURL();

      // Salva o link da foto no Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .update({
        'photoUrl': photoUrl,
      });

      // Navega para a tela de localização
      _navigateToLocationScreen();
    } catch (e) {
      print('Erro ao fazer upload da imagem: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Erro ao fazer upload da imagem. Tente novamente.')),
      );
    }
  }

  // Função para navegar para a tela de localização
  void _navigateToLocationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(
            userId: widget.userId), // Passa o UID para a próxima tela
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Coloque sua foto'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 32, fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                CircleAvatar(
                  radius: 180,
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : AssetImage('lib/assets/profile_image.png')
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.add_circle,
                        color: ColorStyle.RoxoP,
                        size: 50,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: _navigateToLocationScreen,
              child: Text(
                'Continue sem foto',
                style: TextStyle(
                  color: ColorStyle.RoxoP,
                ),
              ),
            ),
            SizedBox(height: 20),
            MyButton(
              buttonProportion: 0.8,
              marginSize: 16.0,
              label: 'Continuar',
              isPrimary: true,
              onPressedButton: () {
                if (_image != null) {
                  // Faz o upload da imagem e navega para a próxima tela
                  _uploadImage();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, selecione uma foto.'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
