import 'package:flutter/material.dart';

class StudentReview extends StatelessWidget {
  final String name;
  final double rating;
  final String review;

  const StudentReview({
    Key? key,
    required this.name,
    required this.rating,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Avaliações dos alunos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.purple, // Alinhando com a cor principal
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nota: $rating'),
              const SizedBox(height: 4),
              Text(review),
            ],
          ),
        ),
      ],
    );
  }
}
