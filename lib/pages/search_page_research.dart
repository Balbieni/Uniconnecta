import 'package:flutter/material.dart';
import 'filtro.dart'; // Importação da tela de filtro

// Classe para o item do Carousel
class CarouselItem {
  final String imagePath;
  final String title;
  final String subtitle;
  final ValueNotifier<bool> isFavorited;
  final double distance;
  final VoidCallback? onTap;
  final String tag;
  final double rating;

  CarouselItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.isFavorited,
    required this.distance,
    required this.onTap,
    required this.tag,
    required this.rating,
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

class SearchPageResearch extends StatefulWidget {
  @override
  _SearchPageResearchState createState() => _SearchPageResearchState();
}

class _SearchPageResearchState extends State<SearchPageResearch> {
  int _selectedIndex =
      1; // Indica que a tela de busca está ativa na barra inferior

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _selectedIndex == 1
          ? Column(
              children: [
                // Cabeçalho personalizado com botão de retorno
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context); // Volta para a tela anterior
                        },
                      ),
                      SizedBox(width: 10),
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150', // Imagem do perfil
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText:
                                'Procure universidades, vestibulares e cursos',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.filter_list, color: Colors.purple),
                        onPressed: () {
                          // Ação ao clicar no botão de filtro
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8), // Espaço entre cabeçalho e filtros
                // Filtros
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilterButton(label: 'Presencial'),
                      FilterButton(label: 'Melhor avaliado'),
                      FilterButton(label: 'Mais próximos'),
                    ],
                  ),
                ),
                SizedBox(height: 16), // Espaço entre filtros e lista de cartões
                // Lista de cartões
                Expanded(
                  child: ListView.builder(
                    itemCount: 4, // Quantidade de itens de exemplo
                    itemBuilder: (context, index) {
                      // Criando itens de exemplo para o CarouselItem
                      CarouselItem item = CarouselItem(
                        imagePath: 'lib/assets/LogoUnicamp.png',
                        title: 'Unicamp',
                        subtitle: 'Medicina',
                        isFavorited: ValueNotifier<bool>(false),
                        distance: 50,
                        rating: 4.5,
                        onTap: () {
                          // Ação ao tocar no cartão
                        },
                        tag: 'Presencial',
                      );

                      // Usando a função buildCarouselCard já existente
                      return buildCarouselCard(item, context);
                    },
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}

// Função para construir o cartão do Carousel
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
          Image.asset(item.imagePath, height: 80, width: 80, fit: BoxFit.cover),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text(item.subtitle,
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: item.onTap,
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
          ValueListenableBuilder<bool>(
            valueListenable: item.isFavorited,
            builder: (context, isFavorited, _) {
              return IconButton(
                icon:
                    Icon(isFavorited ? Icons.favorite : Icons.favorite_border),
                onPressed: () {
                  item.isFavorited.value = !isFavorited;
                },
              );
            },
          ),
        ],
      ),
    ),
  );
}
