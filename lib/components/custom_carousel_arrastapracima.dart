import 'package:flutter/material.dart';

// Modelo para o item do carrossel
class CarouselItem {
  final String imagePath;
  final String title;
  final double rating;
  final String subtitle;
  final String tag;
  final String distance;

  CarouselItem({
    required this.imagePath,
    required this.title,
    required this.rating,
    required this.subtitle,
    required this.tag,
    required this.distance,
    required Null Function() onTap,
  });
}

// Widget CustomVerticalCarousel
class CustomVerticalCarousel extends StatelessWidget {
  final List<CarouselItem> items;
  final bool isVestibulares;
  final Function(CarouselItem) onItemTap;

  CustomVerticalCarousel({
    required this.items,
    this.isVestibulares = false,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return CarouselCard(
              item: items[index],
              isVestibulares: isVestibulares,
              onTap: () => onItemTap(items[index]), // Ação ao clicar no item
            );
          },
        ),
      ),
    );
  }
}

// Widget para exibir cada card individual no carrossel
class CarouselCard extends StatelessWidget {
  final CarouselItem item;
  final bool isVestibulares;
  final VoidCallback onTap; // Função para tratar o clique no item

  CarouselCard({
    required this.item,
    this.isVestibulares = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 205,
      margin: EdgeInsets.only(bottom: 10.0),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: InkWell(
          onTap: onTap, // Ação ao tocar na caixa
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(item.imagePath, height: 50), // Imagem
                    FavoriteButton(), // Botão de favorito
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  item.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                if (isVestibulares)
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                if (!isVestibulares) SizedBox(height: 18),
                SizedBox(height: 26),
                // Estrelas de avaliação
                Row(
                  children: List.generate(5, (i) {
                    if (i < item.rating.floor()) {
                      return Icon(
                        Icons.star,
                        color: Colors.purple,
                        size: 16,
                      );
                    } else if (i == item.rating.floor() &&
                        item.rating - item.rating.floor() >= 0.5) {
                      return Icon(
                        Icons.star_half,
                        color: Colors.purple,
                        size: 16,
                      );
                    } else {
                      return Icon(
                        Icons.star_border,
                        color: Colors.purple,
                        size: 16,
                      );
                    }
                  }),
                ),
                SizedBox(height: 8),
                // Tag e distância (condicional)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          item.tag,
                          style: TextStyle(
                            color: Colors.purple,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    if (!isVestibulares)
                      Flexible(
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.grey,
                            ),
                            Flexible(
                              child: Text(
                                item.distance,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Botão de favorito como estado separado
class FavoriteButton extends StatefulWidget {
  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorited ? Icons.favorite : Icons.favorite_border,
        color: isFavorited ? Colors.purple : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          isFavorited = !isFavorited;
        });
      },
    );
  }
}
