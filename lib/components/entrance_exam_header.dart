import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniconnecta/components/favorites_model.dart';
import 'package:uniconnecta/components/class_of_model.dart'; // Modelo de Vestibular

class VestibularHeader extends StatelessWidget {
  final String vestibularName;
  final String courseName;
  final double rating;
  final String imagePath;
  final Vestibular vestibular; // O objeto Vestibular para salvar nos favoritos

  VestibularHeader({
    required this.vestibularName,
    required this.courseName,
    required this.rating,
    required this.imagePath,
    required this.vestibular, // Passa o objeto Vestibular
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Imagem de fundo
        Image.asset(
          imagePath, // Usa o caminho da imagem fornecido
          width: double.infinity,
          height: 200,
          fit: BoxFit.cover,
        ),
        // Botão de voltar
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
        // Conteúdo na parte inferior
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
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vestibularName, // Usa o nome do vestibular fornecido
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  courseName, // Usa o nome do curso fornecido
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
                          color: index < rating.round()
                              ? Colors.purple
                              : Colors
                                  .grey, // Mostra as estrelas de acordo com a classificação
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      rating.toString(), // Mostra a classificação fornecida
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    Spacer(),
                    // Botão de favorito usando o FavoritesModel
                    Consumer<FavoritesModel>(
                      builder: (context, favoritesModel, child) {
                        // Verifica se o vestibular já está nos favoritos
                        final isFavorited =
                            favoritesModel.isVestibularFavorite(vestibular);

                        return IconButton(
                          icon: Icon(
                            isFavorited
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorited ? Colors.purple : Colors.white,
                          ),
                          onPressed: () {
                            if (isFavorited) {
                              favoritesModel
                                  .removeVestibularFavorite(vestibular);
                            } else {
                              favoritesModel.addVestibularFavorite(vestibular);
                            }
                          },
                        );
                      },
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
