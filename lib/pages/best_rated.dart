import 'package:flutter/material.dart';
import 'package:uniconnecta/components/custom_carousel_arrastapracima.dart'
    as carousel_comp;
import 'package:uniconnecta/pages/home_screen.dart';
import 'package:uniconnecta/pages/search_page.dart';
import 'package:uniconnecta/pages/news_screen.dart';
import 'package:uniconnecta/pages/favorites_screen.dart';
import 'package:uniconnecta/pages/profile_screen.dart';
import 'package:uniconnecta/components/back_button.dart';

class BestRated extends StatefulWidget {
  @override
  _BestRatedState createState() => _BestRatedState();
}

class _BestRatedState extends State<BestRated> {
  int _selectedIndex = 0;

  // Páginas do BottomNavigationBar
  final List<Widget> _pages = [
    HomeScreen(),
    SearchPage(),
    NewsScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  // Itens de universidades mais bem avaliadas
  final List<carousel_comp.CarouselItem> bestRatedItems = [
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
    // Adicione mais itens conforme necessário
  ];

  // Atualiza o índice selecionado no BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      BackButtonComponent(), // Botão de voltar adicionado
                      SizedBox(width: 8), // Espaço entre o botão e o texto
                      Text(
                        'Melhores Avaliadas',
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
                    child: carousel_comp.CustomVerticalCarousel(
                      items: bestRatedItems,
                      isVestibulares: true,
                      onItemTap: (carousel_comp.CarouselItem item) {
                        // Navegação para a página de detalhes
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(item: item),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
          : _pages[
              _selectedIndex], // Exibe a página correspondente no BottomNavigationBar
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
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text('Detalhes sobre ${item.title}'),
      ),
    );
  }
}
