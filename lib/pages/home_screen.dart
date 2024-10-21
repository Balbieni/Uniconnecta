import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:uniconnecta/pages/convest.dart';
import 'package:uniconnecta/pages/best_rated.dart';
import 'package:uniconnecta/pages/entrance_exams.dart'; // Corrigido o nome do arquivo
import 'package:uniconnecta/pages/enem.dart';
import 'package:uniconnecta/pages/pages.dart';
import 'package:uniconnecta/pages/search_page.dart';
import 'package:uniconnecta/pages/news_screen.dart';
import 'package:uniconnecta/pages/favorites_screen.dart';
import 'package:uniconnecta/pages/profile_screen.dart';
import 'package:uniconnecta/components/favorites_model.dart'; // Modelo de favoritos
import 'package:uniconnecta/components/class_of_model.dart';
import 'package:uniconnecta/components/university_header.dart';
import 'package:uniconnecta/components/entrance_exam_header.dart';

class CarouselItem {
  final String imagePath;
  final String title;
  final double rating;
  final String subtitle;
  final String tag;
  final String distance;
  final bool isVestibular; // Indica se é um vestibular ou universidade
  final ValueNotifier<bool> isFavorited;
  final VoidCallback? onTap;

  CarouselItem({
    required this.imagePath,
    required this.title,
    required this.rating,
    required this.subtitle,
    required this.tag,
    required this.distance,
    required this.isVestibular, // Novo parâmetro para diferenciar
    ValueNotifier<bool>? isFavorited,
    this.onTap,
  }) : isFavorited = isFavorited ?? ValueNotifier<bool>(false);
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreenContent(),
    SearchPage(),
    NewsScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
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
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  @override
  _HomeScreenContentState createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
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
  }

  String _calculateDistance(
      double destinationLatitude, double destinationLongitude) {
    if (_currentPosition == null) {
      return "Calculando...";
    }

    double distanceInMeters = Geolocator.distanceBetween(
      _currentPosition!.latitude,
      _currentPosition!.longitude,
      destinationLatitude,
      destinationLongitude,
    );

    double distanceInKm = distanceInMeters / 1000;
    return distanceInKm.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('lib/assets/profile_image.png'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Olá Vinicius',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Seja bem-vindo(a)',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(
                  'Vinicius Moraes',
                  style: TextStyle(color: Colors.black),
                ),
                accountEmail: Text(
                  'Minha conta',
                  style: TextStyle(color: Colors.black),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('lib/assets/profile_image.png'),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              buildDrawerItem(
                context,
                icon: Icons.school,
                title: 'Universidades',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Closest()),
                  );
                },
              ),
              buildDrawerItem(
                context,
                icon: Icons.edit,
                title: 'Vestibulares',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EntranceExams()), // Corrigido
                  );
                },
              ),
              buildDrawerItem(
                context,
                icon: Icons.article,
                title: 'Notícias',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewsScreen()),
                  );
                },
              ),
              buildDrawerItem(
                context,
                icon: Icons.favorite,
                title: 'Favoritos',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen()),
                  );
                },
              ),
              buildDrawerItem(
                context,
                icon: Icons.person,
                title: 'Minha conta',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
              buildDrawerItem(
                context,
                icon: Icons.exit_to_app,
                title: 'Sair da conta',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LogOutOfAccountScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            sectionHeader('Vestibulares', context, 'vestibulares'),
            buildHorizontalCarousel(context, vestibularesItems(context)),
            sectionHeader('Melhores Avaliadas', context, 'melhores_avaliadas'),
            buildHorizontalCarousel(context, melhoresAvaliadasItems(context)),
            sectionHeader('Mais Próximos', context, 'mais_proximos'),
            buildHorizontalCarousel(context, maisProximosItems(context)),
          ],
        ),
      ),
    );
  }

  List<CarouselItem> vestibularesItems(BuildContext context) {
    return [
      CarouselItem(
        imagePath: 'lib/assets/convest_logo.png',
        title: 'Convest',
        rating: 4.5,
        subtitle: '',
        tag: '',
        distance: 'N/A',
        isVestibular: true, // Identificamos como Vestibular
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
        isVestibular: true, // Identificamos como Vestibular
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
    ];
  }

  List<CarouselItem> melhoresAvaliadasItems(BuildContext context) {
    return [
      CarouselItem(
        imagePath: 'lib/assets/unicamp_logo.png',
        title: 'Unicamp',
        rating: 4.6,
        subtitle: 'Universidade renomada',
        tag: 'Ver mais',
        distance: _calculateDistance(-22.820833, -47.066476),
        isVestibular: false, // Identificamos como Universidade
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
    ];
  }

  List<CarouselItem> maisProximosItems(BuildContext context) {
    return [
      CarouselItem(
        imagePath: 'lib/assets/faculty.png',
        title: 'Faculdade Mais Próxima 1',
        rating: 4.0,
        subtitle: 'Próxima de você',
        tag: 'Ver mais',
        distance: _calculateDistance(-23.5505, -46.6333),
        isVestibular: false, // Identificamos como Universidade
      ),
      CarouselItem(
        imagePath: 'lib/assets/faculty.png',
        title: 'Faculdade Mais Próxima 2',
        rating: 3.8,
        subtitle: 'Próxima de você',
        tag: 'Ver mais',
        distance: _calculateDistance(-23.5511, -46.6345),
        isVestibular: false, // Identificamos como Universidade
      ),
    ];
  }
}

ListTile buildDrawerItem(BuildContext context,
    {required IconData icon,
    required String title,
    required GestureTapCallback onTap}) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    onTap: onTap,
  );
}

Widget sectionHeader(String title, BuildContext context, String section) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        GestureDetector(
          onTap: () {
            if (section == 'vestibulares') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EntranceExams(), // Corrigido
                ),
              );
            } else if (section == 'melhores_avaliadas') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BestRated(),
                ),
              );
            } else if (section == 'mais_proximos') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Closest(),
                ),
              );
            }
          },
          child: Text(
            'Ver tudo',
            style: TextStyle(
              fontSize: 14,
              color: const Color.fromARGB(255, 95, 95, 95),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildHorizontalCarousel(BuildContext context, List<CarouselItem> items) {
  return SizedBox(
    height: 235,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return buildCarouselCard(items[index], context);
      },
    ),
  );
}

Widget buildCarouselCard(CarouselItem item, BuildContext context) {
  return GestureDetector(
    onTap: item.onTap,
    child: Container(
      width: 260,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(item.imagePath, height: 80, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Consumer<FavoritesModel>(
                      builder: (context, favoritesModel, child) {
                        if (item.isVestibular) {
                          // Lógica de favoritar Vestibulares
                          final vestibular = Vestibular(
                            nome: item.title,
                            curso: item.subtitle,
                            avaliacao: item.rating,
                            modalidade: "Presencial",
                            logoUrl: item.imagePath,
                          );

                          final isFavorited =
                              favoritesModel.isVestibularFavorite(vestibular);

                          return IconButton(
                            icon: Icon(
                              isFavorited
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorited ? Colors.purple : Colors.grey,
                            ),
                            onPressed: () {
                              if (isFavorited) {
                                favoritesModel
                                    .removeVestibularFavorite(vestibular);
                              } else {
                                favoritesModel
                                    .addVestibularFavorite(vestibular);
                              }
                            },
                          );
                        } else {
                          // Lógica de favoritar Universidades
                          final universidade = Universidade(
                            nome: item.title,
                            curso: item.subtitle,
                            avaliacao: item.rating,
                            distancia: item.distance,
                            modalidade: "Presencial",
                            logoUrl: item.imagePath,
                          );

                          final isFavorited =
                              favoritesModel.isUniversityFavorite(universidade);

                          return IconButton(
                            icon: Icon(
                              isFavorited
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorited ? Colors.purple : Colors.grey,
                            ),
                            onPressed: () {
                              if (isFavorited) {
                                favoritesModel
                                    .removeUniversityFavorite(universidade);
                              } else {
                                favoritesModel
                                    .addUniversityFavorite(universidade);
                              }
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  item.subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    buildRatingStars(item.rating),
                    Spacer(),
                    Text(
                      item.distance == 'N/A'
                          ? item.distance
                          : '${item.distance} Km',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    item.onTap?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    item.tag.isEmpty ? 'Ver mais' : item.tag,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildRatingStars(double rating) {
  int fullStars = rating.floor();
  int halfStars = (rating - fullStars >= 0.5) ? 1 : 0;
  int emptyStars = 5 - fullStars - halfStars;

  return Row(
    children: [
      ...List.generate(fullStars,
          (index) => Icon(Icons.star, color: Colors.purple, size: 16)),
      if (halfStars > 0) Icon(Icons.star_half, color: Colors.purple, size: 16),
      ...List.generate(emptyStars,
          (index) => Icon(Icons.star_border, color: Colors.purple, size: 16)),
    ],
  );
}
