import 'package:flutter/material.dart';
import 'package:uniconnecta/components/custom_carousel_arrastapracima.dart'
    as carousel_comp;
import 'package:uniconnecta/pages/home_screen.dart' as home_page;
import 'package:uniconnecta/pages/search_page.dart';
import 'package:uniconnecta/pages/news_screen.dart';
import 'package:uniconnecta/pages/favorites_screen.dart';
import 'package:uniconnecta/pages/profile_screen.dart';
import 'package:uniconnecta/components/back_button.dart';

class EntranceExamsWithFilter extends StatefulWidget {
  final String filterType;

  EntranceExamsWithFilter({required this.filterType});

  @override
  _EntranceExamsWithFilterState createState() =>
      _EntranceExamsWithFilterState();
}

class _EntranceExamsWithFilterState extends State<EntranceExamsWithFilter> {
  int _selectedIndex = 0;

  // Definindo as páginas de navegação do BottomNavigationBar
  final List<Widget> _pages = [
    home_page.HomeScreen(),
    SearchPage(),
    NewsScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  // Lista completa de vestibulares
  List<carousel_comp.CarouselItem> allExams = [];
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

  // Função para filtrar vestibulares com base no tipo
  List<carousel_comp.CarouselItem> _getFilteredExams() {
    return allExams.where((exam) => exam.tag == widget.filterType).toList();
  }

  // Atualiza o índice selecionado no BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filtra a lista de vestibulares com base no filtro selecionado
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
                      BackButtonComponent(), // Botão de voltar
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
              _selectedIndex], // Exibe a página selecionada no BottomNavigationBar
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

// Página de detalhes para cada item de vestibular
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
