import 'package:flutter/material.dart';
import 'package:uniconnecta/components/components.dart';
import 'package:uniconnecta/components/custom_carousel.dart';
import 'package:uniconnecta/pages/convest.dart';
import 'package:uniconnecta/pages/melhores_avalidas.dart';
import 'package:uniconnecta/pages/pages.dart';
import 'package:uniconnecta/pages/vestibulares.dart';

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

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                  backgroundImage: AssetImage('lib/assets/faculdade1.png'),
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
      bottomNavigationBar: NavBar(),
    );
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
                    builder: (context) => Vestibulares(),
                  ),
                );
              } else if (section == 'melhores_avaliadas') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MelhoresAvalidas(),
                  ),
                );
              } else if (section == 'mais_proximos') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MaisProximosScreen(),
                  ),
                );
              }
            },
            child: Text(
              'Ver tudo',
              style: TextStyle(
                fontSize: 14,
                color: Colors.purple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHorizontalCarousel(
      BuildContext context, List<CarouselItem> items) {
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
                  SizedBox(height: 10),
                  Row(
                    children: [
                      FavoriteButton(isFavorited: item.isFavorited),
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
                      item.tag,
                      style: TextStyle(fontSize: 12),
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
        title: 'Unicamp',
        rating: 4.0,
        subtitle: '',
        tag: 'Inscrições abertas',
        distance: '',
        isFavorited: ValueNotifier<bool>(false),
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

  List<CarouselItem> melhoresAvaliadasItems(BuildContext context) {
    return [
      CarouselItem(
        imagePath: 'lib/assets/unicamp.png',
        title: 'enem',
        rating: 4.9,
        subtitle: '',
        tag: '',
        distance: '50Km',
        isFavorited: ValueNotifier<bool>(false),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Unicamp(
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
        imagePath: 'lib/assets/unicamp.png',
        title: 'Unicamp',
        rating: 4.5,
        subtitle: 'Computação',
        tag: 'Inscrições Abertas',
        distance: '10Km',
        isFavorited: ValueNotifier<bool>(false),
        onTap: () {
          // Implementar navegação para detalhes de Computação
        },
      ),
    ];
  }
}
