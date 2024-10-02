import 'package:flutter/material.dart';
import 'package:uniconnecta/pages/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// arrumar o google-service

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(uniconnecta());
}
