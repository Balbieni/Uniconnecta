import 'package:flutter/material.dart';
import 'filter.dart'; // Importação da tela de filtro

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
        // Navega para a tela de filtro
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => filter()),
        );
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
  TextEditingController _searchController = TextEditingController();
  List<CarouselItem> _items = [];
  List<CarouselItem> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    // Exemplo de itens
    _items = [
      CarouselItem(
        imagePath: 'lib/assets/unicamp_logo.png',
        title: 'Unicamp',
        subtitle: 'Medicina',
        isFavorited: ValueNotifier<bool>(false),
        distance: 50,
        rating: 4.5,
        onTap: () {},
        tag: 'Presencial',
      ),
      CarouselItem(
        imagePath: 'lib/assets/unicamp_logo.png',
        title: 'USP',
        subtitle: 'Engenharia',
        isFavorited: ValueNotifier<bool>(false),
        distance: 30,
        rating: 4.8,
        onTap: () {},
        tag: 'Presencial',
      ),
      CarouselItem(
        imagePath: 'lib/assets/unicamp_logo.png',
        title: 'UFMG',
        subtitle: 'Direito',
        isFavorited: ValueNotifier<bool>(false),
        distance: 70,
        rating: 4.2,
        onTap: () {},
        tag: 'Presencial',
      ),
    ];
    _filteredItems = List.from(_items);
    _searchController.addListener(_filterItems);
  }

  void _filterItems() {
    setState(() {
      String query = _searchController.text.toLowerCase();
      _filteredItems = _items.where((item) {
        return item.title.toLowerCase().contains(query) ||
            item.subtitle.toLowerCase().contains(query);
      }).toList();
    });
  }

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
                          'lib/assets/profile_image.png', // Imagem do perfil
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
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
                          // Navega para a tela de filtro
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => filter()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24), // Espaço entre filtros e lista de cartões
                // Lista de cartões filtrada
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      return buildCarouselCard(_filteredItems[index], context);
                    },
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
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
                          style: TextStyle(
                            fontSize: 12,
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
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
                icon: Icon(
                  isFavorited ? Icons.favorite : Icons.favorite_border,
                  color: isFavorited ? Colors.purple : Colors.black,
                ),
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
