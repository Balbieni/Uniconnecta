import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uniconnecta/pages/pages.dart';
import 'package:uniconnecta/pages/want_to_go_to_college.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(uniconnecta());
}

class uniconnecta extends StatelessWidget {
  const uniconnecta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white),
        colorScheme:
            ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(
          secondary: Colors.white,
          surface: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        'QuerEntrarNaFaculdade': (context) =>
            const want_to_go_to_college(), // Use o nome correto do widget
      },
    );
  }
}
