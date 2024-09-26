import 'package:flutter/material.dart';
import 'melhores_avalidas.dart';
import 'mais_proximos.dart';
import 'vestibulares.dart';
import 'favorites_screen.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                'https://via.placeholder.com/150', // Placeholder image URL
              ),
            ),
            SizedBox(width: 10),
            Text(
              'Procure universidades,\nvestibulares e cursos',
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(Icons.filter_list, color: Colors.white),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                buildCategoryCard(
                  context,
                  'Mais Próximos',
                  'https://example.com/Universidades.png', // Image URL
                  MaisProximosScreen(),
                ),
                buildCategoryCard(
                  context,
                  'Melhores avaliados',
                  'https://example.com/MelhoresAvaliadas.png', // Image URL
                  MelhoresAvaliadas(),
                ),
                buildCategoryCard(
                  context,
                  'Vestibulares',
                  'https://example.com/Vestibulares.png', // Image URL
                  Vestibulares(),
                ),
                buildCategoryCard(
                  context,
                  'Favoritos/Notícias',
                  'https://example.com/FavoritosOuNoticias.png', // Image URL
                  FavoritesScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryCard(
      BuildContext context, String title, String imageUrl, Widget targetPage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetPage),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
