import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniconnecta/components/components.dart';
import 'pages.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _loginWithEmail() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      Navigator.pushNamed(context, '/howaccess');
    } catch (e) {
      print(e);
    }
  }

  Future<void> _loginWithGoogle() async {
    try {
      User? user = await AuthService().signInWithGoogle();
      if (user != null) {
        Navigator.pushNamed(context, '/howaccess');
      } else {
        print('Login failed');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    const BackButtonComponent(
                        iconSize: 30.0), // Defina o tamanho do ícone
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Crie sua conta em alguns instantes',
                    style: TextStyle(
                      color: Colors.black, // Ajuste para a cor desejada
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Digite suas informações',
                  style: TextStyle(
                    color: ColorStyle.RoxoP,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                BoxText(
                  controller: _emailController,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  hintText: 'Nome Completo',
                  isPassword: false,
                  textColor: ColorStyle.CinzaE2,
                  textStyle:
                      const TextStyle(fontSize: 16.0, fontFamily: 'Quicksand'),
                ),
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
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 58,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: _loginWithEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          ColorStyle.RoxoP, // Defina o fundo como roxo
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Criar conta',
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
                        color: ColorStyle.RoxoP,
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
                        color: ColorStyle.RoxoP,
                        fontSize: 13.9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Divider(
                        color: ColorStyle.RoxoP,
                        thickness: 1,
                        height: 20,
                        indent: 5,
                        endIndent: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
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
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 32,
                                );
                              },
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
