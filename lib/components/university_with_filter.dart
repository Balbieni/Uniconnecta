import 'package:flutter/material.dart';
import 'custom_carousel_arrastapracima.dart';

class UniversityWithFilter extends StatelessWidget {
  final String filterType;
  final List<CarouselItem> filteredItems; // Adicione esse parâmetro

  UniversityWithFilter({required this.filterType, required this.filteredItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(filterType)),
      body: ListView.builder(
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          final item = filteredItems[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text(item.subtitle),
            trailing: Text(item.distance),
          );
        },
      ),
    );
  }
}
