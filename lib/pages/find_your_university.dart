import 'package:flutter/material.dart';
import 'package:uniconnecta/components/components.dart';
import 'pages.dart';

class find_your_university extends StatelessWidget {
  const find_your_university({Key? key}) : super(key: key);

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
                'lib/assets/find_your_university.png',
                height: 291,
                width: 330,
              ),
              const SizedBox(height: 30),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Encontre sua universidade',
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
                  'Ache a melhor universidade para você',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const Spacer(), // Mantenha um Spacer para empurrar os botões para baixo
              MyButton(
                buttonProportion: 0.5,
                marginSize: 24.0,
                label: 'Vamos lá!',
                isPrimary: true,
                onPressedButton: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => create_account_or_log_in(),
                    ),
                  );
                },
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
        DotIndicator(isActive: false),
        DotIndicator(isActive: true),
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
