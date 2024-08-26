import 'package:flutter/material.dart';
import 'package:uniconnecta/components/components.dart';
import 'pages.dart';

class HowAccess extends StatefulWidget {
  const HowAccess({Key? key}) : super(key: key);

  @override
  State<HowAccess> createState() => _HowAccessState();
}

class _HowAccessState extends State<HowAccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.CinzaC5,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Image.asset(
              'lib/assets/uniconnectaRoxo.png',
              width: MediaQuery.of(context).size.width,
              height: 339,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Seja Bem-vindo',
              style: TextStyle(
                color: ColorStyle.CinzaE4,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(
            'Como deseja acessar?',
            style: TextStyle(
              color: ColorStyle.CinzaP,
              fontSize: 16,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 58,
              height: 58,
              child: OutlinedButton(
                onPressed: () => {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: ColorStyle.CinzaC2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Row(
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
          ),
        ],
      ),
    );
  }
}
