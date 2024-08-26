import 'package:flutter/material.dart';
import 'components.dart';

class BackButtonComponent extends StatelessWidget {
  final double iconSize; // Tamanho do ícone

  const BackButtonComponent({Key? key, this.iconSize = 24.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: ColorStyle.RoxoP,
        size: iconSize, // Define o tamanho do ícone aqui
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
