import 'package:flutter/material.dart';
import 'package:uniconnecta/components/custom_carousel_arrastapracima.dart';
import 'package:uniconnecta/components/nav_bar.dart';

class MelhoresAvalidas extends StatelessWidget {
  final List<CarouselItem> maisProximosItems = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("melhores avaliadas"),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: const Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomVerticalCarousel(
          items: maisProximosItems,
          isVestibulares: true,
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}

class DetailPage extends StatelessWidget {
  final CarouselItem item;

  DetailPage({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Center(
        child: Text('Detalhes sobre ${item.title}'),
      ),
    );
  }
}
