import 'package:flutter/material.dart';
import 'package:uniconnecta/components/custom_carousel_arrastapracima.dart'
    as carousel_comp;
import 'package:uniconnecta/pages/home_screen.dart';
import 'package:uniconnecta/pages/search_page.dart';
import 'package:uniconnecta/pages/news_screen.dart';
import 'package:uniconnecta/pages/favorites_screen.dart';
import 'package:uniconnecta/pages/profile_screen.dart';
import 'package:uniconnecta/components/back_button.dart';

class UniversityWithFilter extends StatefulWidget {
  final String filterType; // Recebe o tipo de filtro (Presencial, Online, etc.)

  UniversityWithFilter({required this.filterType});

  @override
  _UniversityWithFilterState createState() => _UniversityWithFilterState();
}

class _UniversityWithFilterState extends State<UniversityWithFilter> {
  int _selectedIndex = 0;

  // Lista de páginas do BottomNavigationBar
  final List<Widget> _pages = [
    HomeScreen(),
    SearchPage(),
    NewsScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  // Lista completa de universidades
  final List<carousel_comp.CarouselItem> allUniversities = [
    carousel_comp.CarouselItem(
      imagePath: 'lib/assets/unicamp_logo.png',
      title: 'Unicamp',
      rating: 4.9,
      subtitle: 'Medicina',
      tag: 'Presencial',
      distance: '10Km',
    ),
    carousel_comp.CarouselItem(
      imagePath: 'lib/assets/faculty.png',
      title: 'Facamp',
      rating: 4.8,
      subtitle: 'Administração',
      tag: 'Presencial',
      distance: '30Km',
    ),
    carousel_comp.CarouselItem(
      imagePath: 'lib/assets/online_university.png',
      title: 'UniOnline',
      rating: 4.7,
      subtitle: 'Engenharia da Computação',
      tag: 'Online',
      distance: '0Km',
    ),
    // Outros itens podem ser adicionados aqui...
  ];

  // Função para aplicar o filtro nas universidades
  List<carousel_comp.CarouselItem> _getFilteredUniversities() {
    return allUniversities
        .where((university) => university.tag == widget.filterType)
        .toList(); // Filtra com base no tipo de filtro (tag)
  }

  // Função para gerenciar a navegação no BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filtra as universidades com base no filtro recebido
    List<carousel_comp.CarouselItem> filteredUniversities =
        _getFilteredUniversities();

    return Scaffold(
      backgroundColor: Colors.white,
      body: _selectedIndex == 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 16.0),
                  child: Row(
                    children: [
                      BackButtonComponent(), // Botão de voltar
                      SizedBox(width: 8), // Espaço entre o botão e o texto
                      Text(
                        'Universidades - ${widget.filterType}', // Exibe o tipo de filtro
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    // Exibe as universidades filtradas no carrossel
                    child: filteredUniversities.isNotEmpty
                        ? carousel_comp.CustomVerticalCarousel(
                            items: filteredUniversities,
                            isVestibulares: true, // Configura como vestibular
                            onItemTap: (carousel_comp.CarouselItem item) {
                              // Navegação para página de detalhes
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(item: item),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              'Nenhuma universidade encontrada com o filtro selecionado',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                  ),
                ),
              ],
            )
          : _pages[_selectedIndex], // Exibe a página correspondente
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Notícias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Página de detalhes para cada universidade
class DetailPage extends StatelessWidget {
  final carousel_comp.CarouselItem item;

  DetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text('Detalhes sobre ${item.title}'),
      ),
    );
  }
}
