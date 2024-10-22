import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uniconnecta/components/components.dart';
import 'package:uniconnecta/pages/register_page.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'package:uniconnecta/auth_service.dart'; // Certifique-se que este arquivo está configurado corretamente

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Função de login com email e senha
  Future<void> _loginWithEmail() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Recupera o UID do usuário autenticado
      User? user = userCredential.user;
      if (user != null) {
        // Verifica se o documento do usuário existe no Firestore
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          // Navega para a HomeScreen (ou qualquer outra tela de destino)
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          // Se o usuário não tem dados no Firestore, redireciona para a tela de edição de perfil
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EditProfileScreen()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'O endereço de email está mal formatado.';
          break;
        case 'user-not-found':
          errorMessage = 'Nenhum usuário encontrado com este email.';
          break;
        case 'wrong-password':
          errorMessage = 'Senha incorreta. Tente novamente.';
          break;
        default:
          errorMessage = 'Ocorreu um erro. Por favor, tente novamente.';
      }
      _showErrorDialog('Erro no login com email', errorMessage);
    } catch (e) {
      _showErrorDialog('Erro no login', e.toString());
    }
  }

  // Função de login com Google
  Future<void> _loginWithGoogle() async {
    try {
      User? user = await AuthService().signInWithGoogle();
      if (user != null) {
        // Verifica se o documento do usuário existe no Firestore
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          // Navega para a HomeScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          // Se o usuário é novo, navega para a tela de edição de perfil
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EditProfileScreen()),
          );
        }
      } else {
        _showErrorDialog(
            'Falha no login', 'Não foi possível realizar o login com Google.');
      }
    } catch (e) {
      _showErrorDialog('Erro no login com Google', e.toString());
    }
  }

  // Função de redefinir senha
  void _resetPassword() {
    if (_emailController.text.isNotEmpty) {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text)
          .then((value) => _showInfoDialog(
              'Redefinição de senha', 'Email de redefinição de senha enviado.'))
          .catchError((error) => _showErrorDialog(
              'Erro', 'Erro ao enviar email de redefinição: $error'));
    } else {
      _showErrorDialog('Erro', 'Por favor, insira seu email.');
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Ok'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const BackButtonComponent(iconSize: 30.0),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 30),
              Image.asset('lib/assets/uniconnecta_roxo.png',
                  width: 331, height: 52),
              const SizedBox(height: 40),
              const Text('Conecte-se',
                  style: TextStyle(color: ColorStyle.RoxoP, fontSize: 20.0)),
              const SizedBox(height: 20),
              BoxText(
                controller: _emailController,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                hintText: 'Email',
                isPassword: false,
                textColor: ColorStyle.CinzaE2,
                textStyle:
                    const TextStyle(fontSize: 16.0, fontFamily: 'Quicksand'),
              ),
              const SizedBox(height: 20),
              BoxText(
                controller: _passwordController,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                hintText: 'Senha',
                isPassword: true,
                textColor: ColorStyle.CinzaE2,
                textStyle:
                    const TextStyle(fontSize: 16.0, fontFamily: 'Quicksand'),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: _resetPassword,
                  child: const Text(
                    'Esqueci minha senha',
                    style: TextStyle(
                        color: ColorStyle.RoxoP, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width - 58,
                height: 58,
                child: ElevatedButton(
                  onPressed: _loginWithEmail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorStyle.RoxoP,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: const Text('Login',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(color: ColorStyle.CinzaC2, thickness: 1),
                  ),
                  SizedBox(width: 5),
                  Text('ou',
                      style: TextStyle(
                          color: ColorStyle.CinzaE1,
                          fontSize: 13.9,
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 5),
                  Expanded(
                    child: Divider(color: ColorStyle.CinzaC2, thickness: 1),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width - 58,
                height: 58,
                child: OutlinedButton(
                  onPressed: _loginWithGoogle,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: ColorStyle.CinzaC2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/assets/google.png',
                          width: 32, height: 32),
                      const SizedBox(width: 10),
                      const Text('Continuar com Google',
                          style: TextStyle(
                              color: ColorStyle.CinzaP,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Não tem uma conta?',
                      style: TextStyle(
                          color: ColorStyle.CinzaP,
                          fontSize: 13.9,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    child: const Text(
                      'Cadastre-se.',
                      style: TextStyle(
                          color: ColorStyle.RoxoP,
                          fontSize: 13.9,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
