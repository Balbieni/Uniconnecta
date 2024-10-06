import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uniconnecta/pages/pages.dart';
import 'package:uniconnecta/pages/want_to_go_to_college.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Esse código é executado quando uma notificação é recebida enquanto o app está em segundo plano
  print('Notificação em segundo plano: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configurando o Firebase Messaging para notificações em segundo plano
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(uniconnecta());
}

class uniconnecta extends StatefulWidget {
  const uniconnecta({Key? key}) : super(key: key);

  @override
  _uniconnectaState createState() => _uniconnectaState();
}

class _uniconnectaState extends State<uniconnecta> {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();

    // Solicita permissões para notificações no iOS
    _messaging.requestPermission();

    // Inicializa o Firebase Messaging para lidar com mensagens em primeiro plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Notificação em primeiro plano: ${message.notification?.title}');
      // Aqui você pode exibir um alerta ou atualizar o estado da UI
    });

    // Lida com notificações que abriram o aplicativo
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notificação aberta: ${message.notification?.title}');
      // Aqui você pode redirecionar o usuário para uma página específica, se necessário
    });

    // Obtém e exibe o token do dispositivo
    _getToken();
  }

  Future<void> _getToken() async {
    String? token = await _messaging.getToken();
    print("Token do dispositivo: $token");
    // Salve esse token no Firestore ou backend para enviar notificações específicas ao dispositivo
  }

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
        'want_to_go_to_college': (context) => const want_to_go_to_college(),
      },
    );
  }
}
