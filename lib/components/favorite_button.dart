import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final ValueNotifier<bool> isFavorited;

  FavoriteButton({required this.isFavorited});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isFavorited,
      builder: (context, value, child) {
        return IconButton(
          icon: Icon(
            value ? Icons.favorite : Icons.favorite_border,
            color: value ? Colors.red : Colors.grey,
          ),
          onPressed: () {
            isFavorited.value = !isFavorited.value;
          },
        );
      },
    );
  }
}
