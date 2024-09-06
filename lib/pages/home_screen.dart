import 'package:flutter/material.dart';
import 'vestibulares.dart';
import 'mais_proximos.dart';
import 'melhores_avalidas.dart';
import 'package:uniconnecta/components/components.dart';
import 'pages.dart';
import 'convest.dart';

class HomeScreen extends StatelessWidget {
  final List<CarouselItem> vestibularesItems = [
    CarouselItem(
      imagePath: 'lib/assets/faculdade1.png',
      title: 'Enem',
      rating: 4.5,
      subtitle: '',
      tag: 'Inscrições abertas',
      distance: '',
    ),
    CarouselItem(
      imagePath: 'lib/assets/faculdade1.png',
      title: 'Convest',
      rating: 4.0,
      subtitle: '',
      tag: 'Inscrições abertas',
      distance: '',
    ),
    CarouselItem(
      imagePath: 'lib/assets/faculdade1.png',
      title: 'Enem2',
      rating: 3.5,
      subtitle: '',
      tag: 'Inscrições abertas',
      distance: '',
    ),
  ];

  final List<CarouselItem> melhoresAvaliadasItems = [
    CarouselItem(
      imagePath: 'lib/assets/faculdade1.png',
      title: 'Unicamp',
      rating: 4.9,
      subtitle: 'Medicina',
      tag: 'Presencial',
      distance: '10Km',
    ),
    CarouselItem(
      imagePath: 'lib/assets/faculdade1.png',
      title: 'Facamp',
      rating: 4.8,
      subtitle: 'Facamp',
      tag: 'Presencial',
      distance: '30Km',
    ),
  ];

  final List<CarouselItem> maisProximosItems = [
    CarouselItem(
      imagePath: 'lib/assets/faculdade1.png',
      title: 'Faculdade 3',
      rating: 4.9,
      subtitle: 'Direito',
      tag: 'Presencial',
      distance: '10Km',
    ),
    CarouselItem(
      imagePath: 'lib/assets/faculdade1.png',
      title: 'Anhanguera',
      rating: 2.3,
      subtitle: 'Administração',
      tag: 'EAD',
      distance: '',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Olá Vinicius\nSeja bem-vindo(a)'),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.black),
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
          children: <Widget>[
            SizedBox(height: 20),
            buildSection(context, 'Vestibulares', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Vestibulares()),
              );
            }),
            CustomCarousel(
              items: vestibularesItems,
              isVestibulares: true,
            ),
            SizedBox(height: 20),
            buildSection(context, 'Melhores Avaliadas', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MelhoresAvaliadasScreen(),
                ),
              );
            }),
            Builder(
              builder: (context) => CustomCarousel(
                items: melhoresAvaliadasItems.map((item) {
                  return CarouselItem(
                    imagePath: item.imagePath,
                    title: item.title,
                    rating: item.rating,
                    subtitle: item.subtitle,
                    tag: item.tag,
                    distance: item.distance,
                    onTap: () {
                      if (item.title == 'Unicamp') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Unicamp(),
                          ),
                        );
                      } else if (item.title == 'Convest') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Convest(),
                          ),
                        );
                      }
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 20),
            buildSection(context, 'Mais Próximos', () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MaisProximosScreen()),
              );
            }),
            CustomCarousel(items: maisProximosItems),
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

  Widget buildSection(BuildContext context, String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            'Ver tudo >',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
