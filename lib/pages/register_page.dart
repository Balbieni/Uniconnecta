import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uniconnecta/components/components.dart';
import 'pages.dart';

class register_page extends StatefulWidget {
  const register_page({Key? key}) : super(key: key);

  @override
  State<register_page> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<register_page> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  Future<void> _createAccount() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Aqui você pode salvar o nome do usuário no perfil do Firebase ou no Firestore
      await userCredential.user?.updateDisplayName(_nameController.text);

      // Navegar para a próxima tela após o cadastro
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PhotoScreen()),
      );
    } catch (e) {
      // Mostrar um erro para o usuário
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
                    const BackButtonComponent(iconSize: 30.0),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Crie sua conta em alguns instantes',
                    style: TextStyle(
                      color: Colors.black,
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
                  controller: _nameController,
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
                    onPressed: _createAccount,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorStyle.RoxoP,
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
                          side: const BorderSide(color: ColorStyle.CinzaC2),
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
