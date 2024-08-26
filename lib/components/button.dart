import 'package:flutter/material.dart';
import 'color_style.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    required double buttonProportion,
    required double marginSize,
    required String label,
    required bool isPrimary,
    required VoidCallback? onPressedButton,
  })  : _buttonProportion = buttonProportion,
        _marginSize = marginSize,
        _label = label,
        _isPrimary = isPrimary,
        _onPressedButton = onPressedButton;

  final double _buttonProportion;
  final double _marginSize;
  final String _label;
  final bool _isPrimary;
  final VoidCallback? _onPressedButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          MediaQuery.of(context).size.width * _buttonProportion - _marginSize,
      height: 58,
      child: OutlinedButton(
        onPressed: _onPressedButton,
        style: OutlinedButton.styleFrom(
            backgroundColor: _isPrimary ? ColorStyle.RoxoP : ColorStyle.CinzaC5,
            side: const BorderSide(
              color: ColorStyle.RoxoP,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            )),
        child: Text(_label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: _isPrimary ? ColorStyle.CinzaC5 : ColorStyle.CinzaP,
            )),
      ),
    );
  }
}

/*
MyButton(
              buttonProportion: 0.5,
              marginSize: 24.0,
              label:'Acessar',
              isPrimary: false,
              onPressedButton: () {
                Navigator.pushNamed(context, '/howaccess');
              },
            ),
*/
