import 'package:flutter/material.dart';
import 'package:uniconnecta/pages/convest.dart';
import 'package:uniconnecta/pages/closest.dart';
import 'package:uniconnecta/pages/best_rated.dart';
import 'package:uniconnecta/pages/entrance_exams.dart';
import 'package:uniconnecta/pages/enem.dart';
import 'package:uniconnecta/pages/search_page.dart';
import 'package:uniconnecta/pages/news_screen.dart';
import 'package:uniconnecta/pages/favorites_screen.dart';
import 'package:uniconnecta/pages/profile_screen.dart';

class CarouselItem {
  final String imagePath;
  final String title;
  final double rating;
  final String subtitle;
  final String tag;
  final String distance;
  final ValueNotifier<bool> isFavorited;
  final VoidCallback? onTap;

  CarouselItem({
    required this.imagePath,
    required this.title,
    required this.rating,
    required this.subtitle,
    required this.tag,
    required this.distance,
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

// Conteúdo da tela Home com a AppBar incluída
class HomeScreenContent extends StatelessWidget {
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
                onTap: () => Navigator.pop(context),
              ),
              buildDrawerItem(
                context,
                icon: Icons.edit,
                title: 'Vestibulares',
                onTap: () => Navigator.pop(context),
              ),
              buildDrawerItem(
                context,
                icon: Icons.article,
                title: 'Notícias',
                onTap: () => Navigator.pop(context),
              ),
              buildDrawerItem(
                context,
                icon: Icons.favorite,
                title: 'Favoritos',
                onTap: () => Navigator.pop(context),
              ),
              buildDrawerItem(
                context,
                icon: Icons.person,
                title: 'Minha conta',
                onTap: () => Navigator.pop(context),
              ),
              buildDrawerItem(
                context,
                icon: Icons.exit_to_app,
                title: 'Sair da conta',
                onTap: () => Navigator.pop(context),
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
                  builder: (context) => entrance_exams(),
                ),
              );
            } else if (section == 'melhores_avaliadas') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => best_rated(),
                ),
              );
            } else if (section == 'mais_proximos') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => closest(),
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
                Text(item.title,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(item.subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
                SizedBox(height: 5),
                Row(
                  children: [
                    buildRatingStars(item.rating),
                    Spacer(),
                    Text('${item.distance} Km',
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
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

List<CarouselItem> vestibularesItems(BuildContext context) {
  return [
    CarouselItem(
      imagePath: 'lib/assets/faculdade1.png',
      title: 'Convest',
      rating: 4.5,
      subtitle: '',
      tag: '',
      distance: '',
      isFavorited: ValueNotifier<bool>(false),
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
      imagePath: 'lib/assets/faculdade1.png',
      title: 'enem',
      rating: 4.0,
      subtitle: '',
      tag: 'Inscrições abertas',
      distance: '',
      isFavorited: ValueNotifier<bool>(false),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Enem(
              title: 'enem',
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
      imagePath: 'lib/assets/LogoUnicamp.png',
      title: 'Unicamp',
      rating: 4.6,
      subtitle: 'Universidade renomada',
      tag: 'Ver mais',
      distance: '15',
      isFavorited: ValueNotifier<bool>(true),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Enem(
              title: 'enem',
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
      imagePath: 'lib/assets/faculdade3.png',
      title: 'Faculdade Mais Próxima 1',
      rating: 4.0,
      subtitle: 'Próxima de você',
      tag: 'Ver mais',
      distance: '2',
      isFavorited: ValueNotifier<bool>(false),
    ),
  ];
}
