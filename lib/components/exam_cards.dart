import 'package:flutter/material.dart';

// Define a classe CarouselItem
class CarouselItem {
  final String imagePath;
  final String title;
  final double rating;
  final String subtitle;
  final String tag;
  final String distance;
  final ValueNotifier<bool> isFavorited; // Inclui ValueNotifier
  final VoidCallback? onTap;

  CarouselItem({
    required this.imagePath,
    required this.title,
    required this.rating,
    required this.subtitle,
    required this.tag,
    required this.distance,
    required this.isFavorited, // Inicialize o estado de favoritado
    this.onTap,
  });
}

// Define o botão de favorito
class FavoriteButton extends StatelessWidget {
  final ValueNotifier<bool> isFavorited;

  FavoriteButton({required this.isFavorited});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isFavorited,
      builder: (context, isFavoritedValue, child) {
        return IconButton(
          icon: Icon(
            isFavoritedValue ? Icons.favorite : Icons.favorite_border,
            color: isFavoritedValue ? Colors.purple : Colors.grey,
          ),
          onPressed: () {
            isFavorited.value =
                !isFavoritedValue; // Alterna o estado de favoritado
          },
        );
      },
    );
  }
}

// Define o carrossel personalizado
class CustomCarousel extends StatelessWidget {
  final List<CarouselItem> items;
  final bool isVestibulares;

  CustomCarousel({required this.items, this.isVestibulares = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return CarouselCard(
            item: items[index],
            isVestibulares: isVestibulares,
          );
        },
      ),
    );
  }
}

// Define o cartão do carrossel
class CarouselCard extends StatelessWidget {
  final CarouselItem item;
  final bool isVestibulares;

  CarouselCard({required this.item, this.isVestibulares = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      margin: EdgeInsets.only(right: 10.0),
      child: Card(
        child: InkWell(
          onTap: item.onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(item.imagePath, height: 50),
                    FavoriteButton(isFavorited: item.isFavorited),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  item.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                if (isVestibulares)
                  Text(
                    item.subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                SizedBox(height: 10),
                _buildRatingStars(item.rating),
                SizedBox(height: 10),
                _buildTagAndDistance(item.tag, item.distance, isVestibulares),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Método para construir estrelas de avaliação
  Widget _buildRatingStars(double rating) {
    return Row(
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, color: Colors.purple, size: 16);
        } else if (index == rating.floor() && rating - rating.floor() >= 0.5) {
          return Icon(Icons.star_half, color: Colors.purple, size: 16);
        } else {
          return Icon(Icons.star_border, color: Colors.purple, size: 16);
        }
      }),
    );
  }

  // Método para construir tag e distância
  Widget _buildTagAndDistance(
      String tag, String distance, bool isVestibulares) {
    return Row(
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
              tag,
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
                Icon(Icons.location_on, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    distance,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
