import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150'), // Imagem do perfil
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Procure universidades, vestibulares e cursos',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {},
            )
          ],
        ),
      ),
      body: Column(
        children: [
          // Filtros
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilterButton(label: 'Presencial'),
                FilterButton(label: 'Melhor avaliado'),
                FilterButton(label: 'Mais próximos'),
              ],
            ),
          ),
          // Lista de cartões
          Expanded(
            child: ListView.builder(
              itemCount: 4, // Quantidade de itens de exemplo
              itemBuilder: (context, index) {
                return buildCarouselCard(
                  CarouselItem(
                    imagePath: 'assets/unicamp_logo.png', // Exemplo de imagem
                    title: 'Unicamp',
                    subtitle: 'Medicina',
                    isFavorited: false,
                    distance: 50,
                    onTap: () {
                      // Ação ao tocar no cartão
                    },
                    tag: 'Presencial',
                  ),
                  context,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Página atual "Busca"
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Busca'),
          BottomNavigationBarItem(
              icon: Icon(Icons.newspaper), label: 'Notícias'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  Widget buildCarouselCard(CarouselItem item, BuildContext context) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Image.asset(item.imagePath,
                height: 80, width: 80, fit: BoxFit.cover),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(item.subtitle,
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: Text(
                            item.tag,
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Spacer(),
                        Text('${item.distance} Km',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                  item.isFavorited ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                // Toggle favorito
              },
            )
          ],
        ),
      ),
    );
  }
}

// Classe para o item do Carousel
class CarouselItem {
  final String imagePath;
  final String title;
  final String subtitle;
  final bool isFavorited;
  final double distance;
  final VoidCallback? onTap;
  final String tag;

  CarouselItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.isFavorited,
    required this.distance,
    required this.onTap,
    required this.tag,
  });
}

// Botão de filtro personalizado
class FilterButton extends StatelessWidget {
  final String label;

  const FilterButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Lógica do filtro
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(label),
    );
  }
}
