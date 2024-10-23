import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uniconnecta/pages/convest.dart';
import 'package:uniconnecta/pages/enem.dart';
import 'package:uniconnecta/pages/filter.dart';
import 'package:uniconnecta/pages/mackenzie.dart';
import 'package:uniconnecta/pages/pages.dart';
import 'package:uniconnecta/pages/unesp.dart';
import 'dart:math';
import 'package:uniconnecta/pages/unimetrocamp.dart';

// Classe para o item do Carousel
class CarouselItem {
  final String imagePath;
  final String title;
  final String subtitle;
  final ValueNotifier<bool> isFavorited;
  final String distance; // Mudado para String
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
          MaterialPageRoute(
              builder: (context) =>
                  filter()), // Certifique-se de que FilterScreen está definido
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
  int _selectedIndex = 1;
  TextEditingController _searchController = TextEditingController();
  List<CarouselItem> _items = [];
  List<CarouselItem> _filteredItems = [];
  Position? _currentPosition; // Adicionado

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _initializeItems(); // Método separado para inicializar os itens
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
    });
    if (_currentPosition == null) {
      // Se a posição atual ainda é null, você pode querer mostrar uma mensagem ou um indicador de carregamento
      // Por exemplo, você pode usar um SnackBar ou um diálogo para informar o usuário.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível obter a localização.')),
      );
    }
  }

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371;

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

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  void _initializeItems() {
    _items = [
      CarouselItem(
        imagePath: 'lib/assets/convest_logo.png',
        title: 'Convest',
        rating: 4.5,
        subtitle: '',
        tag: '',
        distance: 'N/A', // Distância padrão
        isFavorited: ValueNotifier(false),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Convest(
                title: 'Convest',
                subtitle: 'Inscrições abertas',
              ),
            ),
          );
        },
      ),
      CarouselItem(
        imagePath: 'lib/assets/enem.png',
        title: 'Enem',
        rating: 4.0,
        subtitle: '',
        tag: 'Inscrições abertas',
        distance: 'N/A',
        isFavorited: ValueNotifier(false),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Enem(
                title: 'Enem',
                subtitle: 'Inscrições abertas',
              ),
            ),
          );
        },
      ),
      CarouselItem(
        imagePath: 'lib/assets/unicamp_logo.png',
        title: 'Unicamp',
        rating: 4.6,
        subtitle: 'Universidade renomada',
        tag: 'Ver mais',
        distance: _currentPosition != null
            ? _formatDistance(_calculateDistance(-22.820833, -47.066476,
                _currentPosition!.latitude, _currentPosition!.longitude))
            : 'N/A', // Verifica se _currentPosition não é nulo
        isFavorited: ValueNotifier(false),
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
      CarouselItem(
        imagePath: 'lib/assets/unesp.png',
        title: 'Unesp',
        rating: 4.8,
        subtitle: 'Universidade renomada',
        tag: 'Ver mais',
        distance: _currentPosition != null
            ? _formatDistance(_calculateDistance(
                -23.524279776770072,
                -46.66545861539335,
                _currentPosition!.latitude,
                _currentPosition!.longitude))
            : 'N/A',
        isFavorited: ValueNotifier(false),
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
      CarouselItem(
        imagePath: 'lib/assets/mackenzie.png',
        title: 'Mackenzie',
        rating: 4.6,
        subtitle: 'Universidade renomada',
        tag: 'Ver mais',
        distance: _currentPosition != null
            ? _formatDistance(_calculateDistance(
                -22.885506617749286,
                -47.06840751013286,
                _currentPosition!.latitude,
                _currentPosition!.longitude))
            : 'N/A',
        isFavorited: ValueNotifier(false),
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
      CarouselItem(
        imagePath: 'lib/assets/unimetrocamp.png',
        title: 'Unimetrocamp',
        rating: 4.2,
        subtitle: 'Universidade renomada',
        tag: 'Ver mais',
        distance: _currentPosition != null
            ? _formatDistance(_calculateDistance(
                -22.9086257044818,
                -47.07593050657596,
                _currentPosition!.latitude,
                _currentPosition!.longitude))
            : 'N/A',
        isFavorited: ValueNotifier(false),
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

    _filteredItems = List.from(_items);
    _searchController.addListener(_filterItems);
  }

  String _formatDistance(double distance) {
    return distance.toStringAsFixed(2); // Formata a distância
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: 10),
                      CircleAvatar(
                        backgroundImage: AssetImage(
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
                        icon: Icon(Icons.filter_list, color: Colors.black),
                        onPressed: () {
                          // Navegação para a tela de filtro
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    filter()), // Corrija aqui se necessário
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return GestureDetector(
                        onTap: item.onTap,
                        child: Card(
                          elevation: 4,
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: ListTile(
                            leading: Image.asset(item.imagePath),
                            title: Text(item.title),
                            subtitle: Text(item.subtitle),
                            trailing: IconButton(
                              icon: ValueListenableBuilder<bool>(
                                valueListenable: item.isFavorited,
                                builder: (context, isFavorited, _) {
                                  return Icon(
                                    isFavorited
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorited ? Colors.red : null,
                                  );
                                },
                              ),
                              onPressed: () {
                                item.isFavorited.value =
                                    !item.isFavorited.value; // Alterna o estado
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
