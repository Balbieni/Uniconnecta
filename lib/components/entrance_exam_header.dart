import 'package:flutter/material.dart';
import 'package:uniconnecta/components/class_of_model.dart'; // Modelo de Vestibular

class VestibularHeader extends StatelessWidget {
  final String vestibularName;
  final String courseName;
  final double rating;
  final String imagePath;
  final Vestibular vestibular;
  final bool isFavorited; // Indica se é favoritado
  final VoidCallback
      onFavoritePressed; // Callback para mudar o estado de favorito

  VestibularHeader({
    required this.vestibularName,
    required this.courseName,
    required this.rating,
    required this.imagePath,
    required this.vestibular,
    required this.isFavorited,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          imagePath,
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 16,
          left: 8,
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vestibularName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  courseName,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star,
                          color: index < rating ? Colors.purple : Colors.grey,
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? Colors.purple : Colors.white,
                      ),
                      onPressed:
                          onFavoritePressed, // Chama o callback ao clicar
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
