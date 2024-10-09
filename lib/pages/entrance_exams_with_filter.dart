import 'package:flutter/material.dart';
import 'package:uniconnecta/components/custom_carousel_arrastapracima.dart'
    as carousel_comp;
import 'package:uniconnecta/pages/home_screen.dart' as home_page;
import 'package:uniconnecta/pages/search_page.dart';
import 'package:uniconnecta/pages/news_screen.dart';
import 'package:uniconnecta/pages/favorites_screen.dart';
import 'package:uniconnecta/pages/profile_screen.dart';
import 'package:uniconnecta/components/back_button.dart';

class entrance_exams_with_filter extends StatefulWidget {
  final String
      filterType; // Adicionado para receber o filtro (Presencial, Online, etc.)

  entrance_exams_with_filter(
      {required this.filterType}); // Construtor modificado para aceitar o filtro

  @override
  _EntranceExamsState createState() => _EntranceExamsState();
}

class _EntranceExamsState extends State<entrance_exams_with_filter> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    home_page.HomeScreen(),
    SearchPage(),
    NewsScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  // Lista completa de vestibulares
  final List<carousel_comp.CarouselItem> allExams = [
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
      tag: 'Online',
      distance: '30Km',
    ),
    // Adicione mais vestibulares aqui...
  ];

  // Função para aplicar o filtro
  List<carousel_comp.CarouselItem> _getFilteredExams() {
    return allExams.where((exam) => exam.tag == widget.filterType).toList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Aplica o filtro na lista de vestibulares
    List<carousel_comp.CarouselItem> filteredExams = _getFilteredExams();

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
                        'Vestibulares - ${widget.filterType}', // Exibe o filtro selecionado
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
                    child: filteredExams.isNotEmpty
                        ? carousel_comp.CustomVerticalCarousel(
                            items: filteredExams,
                            isVestibulares: true,
                          )
                        : Center(
                            child: Text(
                                'Nenhum vestibular encontrado com o filtro selecionado'),
                          ),
                  ),
                ),
              ],
            )
          : _pages[
              _selectedIndex], // Exibe a página correspondente no BottomNavigation
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
