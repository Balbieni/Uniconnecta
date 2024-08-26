import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uniconnecta/components/components.dart';
import 'package:uniconnecta/pages/pages.dart';
import 'package:uniconnecta/pages/quer_entrar_na_faculdade.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const uniconnecta());
}

class uniconnecta extends StatelessWidget {
  const uniconnecta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        'QuerEntrarNaFaculdade': (context) =>
            const QuerEntrarNaFaculdade(), // Use o nome correto do widget
      },
    );
  }
}
