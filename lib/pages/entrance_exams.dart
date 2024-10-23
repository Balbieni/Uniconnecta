import 'package:flutter/material.dart';
import 'package:uniconnecta/components/custom_carousel_arrastapracima.dart'
    as carousel_comp;
import 'package:uniconnecta/pages/convest.dart';
import 'package:uniconnecta/pages/enem.dart';
import 'package:uniconnecta/pages/home_screen.dart' as home_page;
import 'package:uniconnecta/pages/search_page.dart';
import 'package:uniconnecta/pages/news_screen.dart';
import 'package:uniconnecta/pages/favorites_screen.dart';
import 'package:uniconnecta/pages/profile_screen.dart';
import 'package:uniconnecta/components/back_button.dart';

class EntranceExams extends StatefulWidget {
  @override
  _EntranceExamsState createState() => _EntranceExamsState();
}

class _EntranceExamsState extends State<EntranceExams> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    home_page.HomeScreen(),
    SearchPage(),
    NewsScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  List<carousel_comp.CarouselItem> maisProximosItems = [];

  @override
  void initState() {
    super.initState();
    // Inicializa a lista de universidades
    maisProximosItems = [
      carousel_comp.CarouselItem(
        imagePath: 'lib/assets/Convest.png',
        title: 'Convest',
        rating: 4.0,
        subtitle: '',
        tag: 'Inscrições abertas',
        distance: 'N/A',
        onTap: () {
          Navigator.pushNamed(context, '/convest'); // Usando rotas nomeadas
        },
      ),
      carousel_comp.CarouselItem(
        imagePath: 'lib/assets/enem.png',
        title: 'Enem',
        rating: 4.0,
        subtitle: '',
        tag: 'Inscrições abertas',
        distance: 'N/A',
        onTap: () {
          Navigator.pushNamed(context, '/enem'); // Usando rotas nomeadas
        },
      ),
    ];
  }

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
                      BackButtonComponent(),
                      SizedBox(width: 8),
                      Text(
                        'Vestibulares',
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
                      items: maisProximosItems,
                      isVestibulares: true,
                    ),
                  ),
                ),
              ],
            )
          : _pages[_selectedIndex],
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
