import 'package:flutter/material.dart';
import 'color_style.dart';

class BoxText extends StatefulWidget {
  const BoxText({
    required TextEditingController controller,
    required Color fillColor,
    required String hintText,
    required bool isPassword,
    required Color textColor,
    required TextStyle textStyle, // Novo parâmetro para a fonte
    double boxHeight = 58.0,
  })  : _controller = controller,
        _fillColor = fillColor,
        _hintText = hintText,
        _isPassword = isPassword,
        _textStyle = textStyle, // Atribuindo o parâmetro à variável interna
        _boxHeight = boxHeight;

  final TextEditingController _controller;
  final Color _fillColor;
  final String _hintText;
  final bool _isPassword;
  final TextStyle _textStyle; // Variável que armazena o estilo de texto
  final double _boxHeight;

  @override
  State<BoxText> createState() => _BoxTextState();
}

class _BoxTextState extends State<BoxText> {
  late bool _toObscure;

  @override
  void initState() {
    super.initState();
    _toObscure = true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget._boxHeight,
      child: TextFormField(
        controller: widget._controller,
        obscureText: _toObscure && widget._isPassword,
        style: widget._textStyle, // Definindo o estilo de texto
        decoration: InputDecoration(
          labelText: widget._hintText,
          filled: true,
          fillColor: widget._fillColor,
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorStyle.CinzaC2,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorStyle.RoxoP,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          suffixIcon: widget._isPassword
              ? IconButton(
                  icon: _toObscure
                      ? const Icon(Icons.visibility_off_outlined)
                      : const Icon(Icons.visibility_outlined),
                  onPressed: () => {
                    setState(() {
                      _toObscure = !_toObscure;
                    })
                  },
                )
              : null,
        ),
      ),
    );
  }
}
