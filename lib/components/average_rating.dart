import 'package:flutter/material.dart';

class AverageRating extends StatelessWidget {
  final String imagePath;
  final double rating;
  final String recommendationText;

  const AverageRating({
    Key? key,
    required this.imagePath,
    required this.rating,
    required this.recommendationText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Avaliação média',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.purple, // Alinhando com a cor principal
          ),
        ),
        const SizedBox(height: 10),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: Image.asset(imagePath), // Dynamic path
            title: Text(
              rating.toString(),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              recommendationText,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }
}
