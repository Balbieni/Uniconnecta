import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniconnecta/components/components.dart';
import 'pages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _loginWithEmail() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileScreen()),
      ); // Navega para a ProfileScreen após login bem-sucedido
    } catch (e) {
      print(e);
    }
  }

  Future<void> _loginWithGoogle() async {
    try {
      User? user = await AuthService().signInWithGoogle();
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        ); // Navega para a ProfileScreen após login bem-sucedido
      } else {
        print('Login failed');
      }
    } catch (e) {
      print(e);
    }
  }

  void _resetPassword() {
    // Adicione aqui o código para redefinir a senha
    if (_emailController.text.isNotEmpty) {
      FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text)
          .then((value) => print("Email de redefinição de senha enviado"))
          .catchError((error) => print("Erro: $error"));
    } else {
      print("Por favor, insira seu email");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromRGBO(255, 255, 255, 1),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const BackButtonComponent(
                          iconSize: 30.0), // Defina o tamanho do ícone
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Image.asset(
                    'lib/assets/uniconnectaRoxo.png',
                    width: 331,
                    height: 52,
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Conecte-se',
                    style: TextStyle(
                      color: ColorStyle.RoxoP,
                      fontSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  BoxText(
                    controller: _emailController,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'Email',
                    isPassword: false,
                    textColor: ColorStyle.CinzaE2,
                    textStyle: const TextStyle(
                        fontSize: 16.0, fontFamily: 'Quicksand'),
                  ),
                  const SizedBox(height: 20),
                  BoxText(
                    controller: _passwordController,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    hintText: 'Senha',
                    isPassword: true,
                    textColor: ColorStyle.CinzaE2,
                    textStyle: const TextStyle(
                        fontSize: 16.0, fontFamily: 'Quicksand'),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: _resetPassword,
                      child: const Text(
                        'Esqueci minha senha',
                        style: TextStyle(
                          color: ColorStyle.RoxoP,
                          fontWeight: FontWeight.bold,
                        ),
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
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: ColorStyle.CinzaC2,
                          thickness: 1,
                          height: 20,
                          indent: 1,
                          endIndent: 5,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        'ou',
                        style: TextStyle(
                          color: ColorStyle.CinzaE1,
                          fontSize: 13.9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Divider(
                          color: ColorStyle.CinzaC2,
                          thickness: 1,
                          height: 20,
                          indent: 5,
                          endIndent: 1,
                        ),
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
                        side: const BorderSide(
                          color: ColorStyle.CinzaC2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'lib/assets/Google.png',
                            width: 32,
                            height: 32,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Continuar com Google',
                            style: TextStyle(
                              color: ColorStyle.CinzaP,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Não tem uma conta?',
                        style: TextStyle(
                          color: ColorStyle.CinzaP,
                          fontSize: 13.9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CadastroPage(),
                            ),
                          );
                        },
                        child: const Text(
                          'Cadastre-se.',
                          style: TextStyle(
                            color: ColorStyle.RoxoP,
                            fontSize: 13.9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
