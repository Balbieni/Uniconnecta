import 'package:flutter/material.dart';
import 'package:uniconnecta/components/custom_carousel_arrastapracima.dart'
    as carousel_comp;
import 'package:uniconnecta/pages/home_screen.dart';
import 'package:uniconnecta/pages/mackenzie.dart';
import 'package:uniconnecta/pages/pages.dart';
import 'package:uniconnecta/pages/search_page.dart';
import 'package:uniconnecta/pages/news_screen.dart';
import 'package:uniconnecta/pages/favorites_screen.dart';
import 'package:uniconnecta/pages/profile_screen.dart';
import 'package:uniconnecta/components/back_button.dart';
import 'package:uniconnecta/pages/unesp.dart';
import 'package:uniconnecta/pages/unimetrocamp.dart';

class Courses extends StatefulWidget {
  final String filterType; // Tipo de filtro (Presencial, Online, etc.)

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
  List<carousel_comp.CarouselItem> allCourses = [];

  @override
  void initState() {
    super.initState();
    // Inicializa a lista de universidades
    allCourses = [
      carousel_comp.CarouselItem(
        imagePath: 'lib/assets/unicamp_logo.png',
        title: 'Unicamp',
        rating: 4.6,
        subtitle: 'Universidade renomada',
        tag: 'Ver mais',
        distance: "",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Unicamp(
                title: 'Unicamp',
                subtitle: 'Inscrições abertas',
              ),
            ),
          );
        },
      ),
      carousel_comp.CarouselItem(
        imagePath: 'lib/assets/unesp.png',
        title: 'Unesp',
        rating: 4.8,
        subtitle: 'Universidade renomada',
        tag: 'Ver mais',
        distance: "",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Unesp(
                title: 'Unesp',
                subtitle: 'Inscrições abertas',
              ),
            ),
          );
        },
      ),
      carousel_comp.CarouselItem(
        imagePath: 'lib/assets/mackenzie.png',
        title: 'Mackenzie',
        rating: 4.6,
        subtitle: 'Universidade renomada',
        tag: 'Ver mais',
        distance: "",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Mackenzie(
                title: 'Mackenzie',
                subtitle: 'Inscrições abertas',
              ),
            ),
          );
        },
      ),
      carousel_comp.CarouselItem(
        imagePath: 'lib/assets/unimetrocamp.png',
        title: 'Unimetrocamp',
        rating: 4.2,
        subtitle: 'Universidade renomada',
        tag: 'Ver mais',
        distance: "",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Unimetrocamp(
                title: 'Unimetrocamp',
                subtitle: 'Inscrições abertas',
              ),
            ),
          );
        },
      ),
    ];
  }

  // Função para aplicar o filtro de cursos
  List<carousel_comp.CarouselItem> _getFilteredCourses() {
    return allCourses
        .where((course) => course.tag == widget.filterType)
        .toList();
  }

  // Atualiza o índice selecionado no BottomNavigationBar
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
                      BackButtonComponent(), // Botão de voltar
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
                            isVestibulares: false, // Define como cursos
                          )
                        : Center(
                            child: Text(
                              'Nenhum curso encontrado com o filtro selecionado',
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

// Página de detalhes do curso
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
