import 'package:flutter/material.dart';
import 'package:uniconnecta/components/custom_carousel_arrastapracima.dart'
    as carousel_comp;
import 'package:uniconnecta/pages/home_screen.dart' as home_page;
import 'package:uniconnecta/pages/mackenzie.dart';
import 'package:uniconnecta/pages/pages.dart';
import 'package:uniconnecta/pages/search_page.dart';
import 'package:uniconnecta/pages/news_screen.dart';
import 'package:uniconnecta/pages/favorites_screen.dart';
import 'package:uniconnecta/pages/profile_screen.dart';
import 'package:uniconnecta/components/back_button.dart';
import 'package:geolocator/geolocator.dart'; // Pacote para geolocalização
import 'package:uniconnecta/pages/unesp.dart';
import 'dart:math';

import 'package:uniconnecta/pages/unimetrocamp.dart'; // Para cálculo da distância

class Closest extends StatefulWidget {
  @override
  _ClosestState createState() => _ClosestState();
}

class _ClosestState extends State<Closest> {
  int _selectedIndex = 0;
  Position? _currentPosition; // Para armazenar a posição atual do usuário
  bool _isLoading = true; // Indicador de carregamento de dados

  // Definindo as páginas de navegação do BottomNavigationBar
  final List<Widget> _pages = [
    home_page.HomeScreen(),
    SearchPage(),
    NewsScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Função para obter a localização atual do usuário
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Serviço de localização está desabilitado
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissão negada
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissão negada permanentemente
      return;
    }

    // Obtém a posição atual
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
      _isLoading = false; // Para de carregar após obter os dados
    });
  }

  // Função para calcular a distância entre dois pontos (em Km)
  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // Raio da Terra em quilômetros

    double dLat = _degreesToRadians(lat2 - lat1);
    double dLon = _degreesToRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double distance = earthRadius * c;

    return distance;
  }

  // Função auxiliar para converter graus para radianos
  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  // Função para formatar a distância como String
  String _formatDistance(double distance) {
    return distance.toStringAsFixed(2) + ' Km';
  }

  // Função para retornar os itens mais próximos ordenados pela distância
  List<carousel_comp.CarouselItem> maisProximosItems(BuildContext context) {
    if (_currentPosition == null) {
      // Enquanto a posição do usuário ainda não foi obtida
      return [];
    }

    List<carousel_comp.CarouselItem> items = [
      carousel_comp.CarouselItem(
        imagePath: 'lib/assets/unicamp_logo.png',
        title: 'Unicamp',
        rating: 4.6,
        subtitle: 'Universidade renomada',
        tag: 'Ver mais',
        distance: _formatDistance(_calculateDistance(-22.820833, -47.066476,
            _currentPosition!.latitude, _currentPosition!.longitude)),
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
        distance: _formatDistance(_calculateDistance(
            -23.524279776770072,
            -46.66545861539335,
            _currentPosition!.latitude,
            _currentPosition!.longitude)),
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
        distance: _formatDistance(_calculateDistance(
            -22.885506617749286,
            -47.06840751013286,
            _currentPosition!.latitude,
            _currentPosition!.longitude)),
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
        distance: _formatDistance(_calculateDistance(
            -22.9086257044818,
            -47.07593050657596,
            _currentPosition!.latitude,
            _currentPosition!.longitude)),
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

    // Ordena os itens pela distância em ordem crescente
    items.sort((a, b) => a.distance.compareTo(b.distance));

    return items;
  }

  // Função para alterar a página no BottomNavigationBar
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
          ? _isLoading // Exibe indicador de carregamento enquanto a localização é obtida
              ? Center(child: CircularProgressIndicator())
              : Column(
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
                            'Mais Próximos',
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
                          items: maisProximosItems(context),
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

// Página de detalhes para cada universidade
class DetailPage extends StatelessWidget {
  final carousel_comp.CarouselItem item;

  DetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: Colors.purple[700],
      ),
      body: Center(
        child: Text('Detalhes sobre ${item.title}'),
      ),
    );
  }
}
