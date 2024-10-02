import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Minha Conta', style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(
              'lib/assets/profile_image.png', // Corrigido para AssetImage
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Vinicius Moraes',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 32),
          _buildMenuItem(
            icon: Icons.edit,
            text: 'Editar perfil',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.notifications_outlined,
            text: 'Notificações',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationProfileScreen()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.lock_outline,
            text: 'Alterar senha',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.exit_to_app,
            text: 'Sair da conta',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LogOutOfAccountScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.black),
        title: Text(text),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        tileColor: Colors.grey[200],
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final ImagePicker _picker = ImagePicker(); // Instância do ImagePicker
  File? _selectedImage; // Arquivo de imagem selecionada

  String _name = "";
  String _email = "";
  String _password = "";
  bool _toObscure = true;

  Future<void> _updateUserProfile() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        User? user = _auth.currentUser;

        if (user != null) {
          DocumentReference userDocRef =
              _firestore.collection('users').doc(user.uid);

          DocumentSnapshot docSnapshot = await userDocRef.get();

          if (docSnapshot.exists) {
            await user.updateEmail(_email);
            await user.updatePassword(_password);
            await userDocRef.update({
              'name': _name,
              'email': _email,
            });

            if (_selectedImage != null) {
              // Upload da imagem no Firebase Storage (opcional)
              String imageUrl =
                  await _uploadProfileImage(user.uid, _selectedImage!);
              await userDocRef.update({
                'profileImage':
                    imageUrl, // Atualiza a URL da imagem no Firestore
              });
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Dados atualizados com sucesso!')),
            );
          } else {
            await userDocRef.set({
              'name': _name,
              'email': _email,
              'createdAt': FieldValue.serverTimestamp(),
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Dados salvos com sucesso!')),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar dados: $e')),
        );
      }
    }
  }

  Future<String> _uploadProfileImage(String userId, File image) async {
    try {
      // Referência para o local onde a imagem será salva no Firebase Storage
      Reference storageRef =
          FirebaseStorage.instance.ref().child('profile_images/$userId.jpg');

      // Faz o upload da imagem
      UploadTask uploadTask = storageRef.putFile(image);

      // Aguarda a conclusão do upload
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});

      // Pega a URL pública da imagem
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Erro ao fazer upload da imagem: $e');
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // Você pode trocar por ImageSource.camera
      imageQuality: 50, // Qualidade da imagem (0-100)
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Editar Perfil', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _selectedImage != null
                              ? FileImage(_selectedImage!) as ImageProvider
                              : NetworkImage('lib/assets/profile_image.png'),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap:
                                _pickImage, // Chama a função de selecionar imagem
                            child: CircleAvatar(
                              backgroundColor: Colors.purple,
                              radius: 18,
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(
                  labelText: 'Nome completo',
                  labelStyle: TextStyle(color: Colors.purple),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.purple),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                obscureText: _toObscure,
                initialValue: _password,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: Colors.purple),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: _toObscure
                        ? Icon(Icons.visibility_off_outlined)
                        : Icon(Icons.visibility_outlined),
                    onPressed: () {
                      setState(() {
                        _toObscure = !_toObscure;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a senha';
                  } else if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  _updateUserProfile();
                },
                child: Text(
                  'Salvar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notificações'),
      ),
      body: Center(child: Text('Tela de Notificações')),
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alterar Senha'),
      ),
      body: Center(child: Text('Tela de Alterar Senha')),
    );
  }
}

class LogOutOfAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sair da Conta'),
      ),
      body: Center(child: Text('Tela de Sair da Conta')),
    );
  }
}
