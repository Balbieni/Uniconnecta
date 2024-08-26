import 'package:flutter/material.dart';
import 'package:uniconnecta/components/components.dart';
import 'package:uniconnecta/pages/se_mantenha_atualizado.dart';
import 'pages.dart';

class QuerEntrarNaFaculdade extends StatelessWidget {
  const QuerEntrarNaFaculdade({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 35.29),
              IndicatorDots(),
              const SizedBox(height: 241),
              Image.asset(
                'lib/assets/uniconnectaRoxo.png',
                height: 291,
                width: 330,
              ),
              const SizedBox(height: 28),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Quer entrar em uma universidade?',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Aqui você tem informações relevantes sobre vestibulares, universidades e seu curso dos sonhos',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CriarOuLogin(),
                        ),
                      );
                    },
                    child: const Text(
                      'Pular',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorStyle.RoxoP,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeMantenhaAtualizado(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorStyle.RoxoP,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Bordas arredondadas
                      ),
                      minimumSize: const Size(70, 70), // Botão quadrado
                      padding: const EdgeInsets.all(14),
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30), // Espaçamento na parte inferior
            ],
          ),
        ),
      ),
    );
  }
}

class IndicatorDots extends StatelessWidget {
  const IndicatorDots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DotIndicator(isActive: true),
        DotIndicator(isActive: false),
        DotIndicator(isActive: false),
      ],
    );
  }
}

class DotIndicator extends StatelessWidget {
  final bool isActive;

  const DotIndicator({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: isActive ? 10.0 : 8.0,
      height: isActive ? 10.0 : 8.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? ColorStyle.RoxoP
            : ColorStyle.RoxoC4, // Utiliza as cores do ColorStyle
      ),
    );
  }
}
