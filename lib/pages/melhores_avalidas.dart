import 'package:flutter/material.dart';
import 'package:uniconnecta/components/custom_carousel_arrastapracima.dart';
import 'package:uniconnecta/components/nav_bar.dart';
import 'pages.dart';

class MelhoresAvaliadasScreen extends StatelessWidget {
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
    // Adicione mais itens conforme necessário...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Melhores Avaliadas"),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomVerticalCarousel(
          items: melhoresAvaliadasItems,
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
        backgroundColor: Colors.purple[700],
      ),
      body: Center(
        child: Text('Detalhes sobre ${item.title}'),
      ),
    );
  }
}
