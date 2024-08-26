import 'package:flutter/material.dart';
import 'package:uniconnecta/components/components.dart';
import 'pages.dart';

class SeMantenhaAtualizado extends StatelessWidget {
  const SeMantenhaAtualizado({Key? key}) : super(key: key);

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
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Se mantenha atualizado',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Receba datas de vestibulares próximos, e notícias da atualidade',
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
                      // Navegar para a tela "encontre_sua_universidade"
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EncontreSuaUniversidade(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorStyle.RoxoP,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      minimumSize: const Size(70, 70),
                      padding: const EdgeInsets.all(14),
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
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
        DotIndicator(isActive: false),
        DotIndicator(isActive: true),
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
        color: isActive ? ColorStyle.RoxoP : ColorStyle.RoxoC4,
      ),
    );
  }
}
