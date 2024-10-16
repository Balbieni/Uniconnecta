import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniconnecta/pages/pages.dart';
import 'package:uniconnecta/pages/want_to_go_to_college.dart';
import 'package:uniconnecta/components/favorites_model.dart'; // Adicione o arquivo favorites_model.dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Notificação em segundo plano: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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

    _messaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Notificação em primeiro plano: ${message.notification?.title}');
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notificação aberta: ${message.notification?.title}');
    });

    _getToken();
  }

  Future<void> _getToken() async {
    String? token = await _messaging.getToken();
    print("Token do dispositivo: $token");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoritesModel(), // Provedor do modelo de favoritos
      child: MaterialApp(
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
      ),
    );
  }
}
