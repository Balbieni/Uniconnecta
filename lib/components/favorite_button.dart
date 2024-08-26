import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  final ValueNotifier<bool> isFavorited;

  FavoriteButton({required this.isFavorited});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isFavorited,
      builder: (context, isFavorited, child) {
        return IconButton(
          icon: Icon(
            isFavorited ? Icons.favorite : Icons.favorite_border,
            color: isFavorited ? Colors.purple : Colors.grey,
          ),
          onPressed: () {
            this.isFavorited.value = !isFavorited;
          },
        );
      },
    );
  }
}
