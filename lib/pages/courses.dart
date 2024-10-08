import 'package:flutter/material.dart';
import 'package:uniconnecta/components/custom_carousel_arrastapracima.dart'
    as carousel_comp;
import 'package:uniconnecta/pages/home_screen.dart';
import 'package:uniconnecta/pages/search_page.dart';
import 'package:uniconnecta/pages/news_screen.dart';
import 'package:uniconnecta/pages/favorites_screen.dart';
import 'package:uniconnecta/pages/profile_screen.dart';
import 'package:uniconnecta/components/back_button.dart';

class Courses extends StatefulWidget {
  final String
      filterType; // Receber o tipo de filtro (Presencial, Online, etc.)

  Courses({required this.filterType});

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    SearchPage(),
    NewsScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  // Lista completa de cursos
  final List<carousel_comp.CarouselItem> allCourses = [
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
      imagePath: 'lib/assets/online_course.png',
      title: 'Engenharia da Computação',
      rating: 4.7,
      subtitle: 'Online - EAD',
      tag: 'Online',
      distance: '0Km',
    ),
    // Outros itens podem ser adicionados...
  ];

  // Função para aplicar o filtro
  List<carousel_comp.CarouselItem> _getFilteredCourses() {
    return allCourses
        .where((course) => course.tag == widget.filterType)
        .toList();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filtra os cursos com base no filtro recebido
    List<carousel_comp.CarouselItem> filteredCourses = _getFilteredCourses();

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
                        'Cursos - ${widget.filterType}', // Exibe o tipo de filtro
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
                    child: filteredCourses.isNotEmpty
                        ? carousel_comp.CustomVerticalCarousel(
                            items: filteredCourses,
                            isVestibulares:
                                false, // Aqui pode definir se é vestibular ou curso
                          )
                        : Center(
                            child: Text(
                                'Nenhum curso encontrado com o filtro selecionado'),
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
      body: Center(
        child: Text('Detalhes sobre ${item.title}'),
      ),
    );
  }
}
