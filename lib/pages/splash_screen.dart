import 'package:flutter/material.dart';
import 'want_to_go_to_college.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Navigator.pushReplacementNamed(context, 'want_to_go_to_college');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(101, 60, 173, 1),
      body: Center(
        child: Image.asset(
          'lib/assets/uniconnecta_white.png',
          width: 331,
          height: 52,
        ),
      ),
    );
  }
}
