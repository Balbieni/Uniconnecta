import 'package:flutter/material.dart';

class UniversityHeader extends StatefulWidget {
  final String universityName;
  final String courseName;
  final double rating;
  final String locationType; // Ex: "Presencial"
  final String distance;
  final String imagePath;

  UniversityHeader({
    required this.universityName,
    required this.courseName,
    required this.rating,
    required this.locationType,
    required this.distance,
    required this.imagePath,
    required ValueNotifier<bool> isFavorited,
  });

  @override
  _UniversityHeaderState createState() => _UniversityHeaderState();
}

class _UniversityHeaderState extends State<UniversityHeader> {
  final ValueNotifier<bool> isFavorited = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Imagem de fundo
        Image.asset(
          widget.imagePath, // Usa o caminho da imagem fornecido
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
        // Botão de fechar
        Positioned(
          top: 16,
          right: 8,
          child: IconButton(
            icon: Icon(Icons.close, color: Colors.white),
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
                  widget.universityName, // Usa o nome da universidade fornecido
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.courseName, // Usa o nome do curso fornecido
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
                          color: index < widget.rating.round()
                              ? Colors.purple
                              : Colors
                                  .grey, // Mostra as estrelas de acordo com a classificação
                          size: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      widget.rating
                          .toString(), // Mostra a classificação fornecida
                      style: TextStyle(color: Colors.white),
                    ),
                    Spacer(),
                    Text(
                      widget.distance, // Usa a distância fornecida
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
                      child: Text(
                        widget.locationType, // Usa o tipo de local fornecido
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    Spacer(),
                    ValueListenableBuilder<bool>(
                      valueListenable: isFavorited,
                      builder: (context, isFavoritedValue, child) {
                        return IconButton(
                          icon: Icon(
                            isFavoritedValue
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                isFavoritedValue ? Colors.purple : Colors.white,
                          ),
                          onPressed: () {
                            isFavorited.value = !isFavoritedValue;
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
