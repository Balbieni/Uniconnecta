import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uniconnecta/components/components.dart'; // Certifique-se de que MyButton está nesse arquivo
import 'pages.dart';
import 'dart:io';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  void _navigateToLocationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationScreen(),
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
                      : AssetImage('assets/default_avatar.png')
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
                  _navigateToLocationScreen();
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
