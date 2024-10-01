import 'package:flutter/material.dart';
import 'best_rated.dart';
import 'closest.dart';
import 'entrance_exams.dart';
import 'favorites_screen.dart' as fav; // Usando prefixo para evitar conflito
import 'filter.dart'; // Importação da tela de filtro
import 'search_page_research.dart'; // Importação da tela de pesquisa

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
                'lib/assets/profile_image.png', // Placeholder image URL
              ),
            ),
            SizedBox(width: 10),
            Text(
              'Procure universidades,\nvestibulares e cursos',
              style: TextStyle(color: Colors.black87, fontSize: 16),
            ),
          ],
        ),
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
                    onTap: () {
                      // Navega para a tela de pesquisa ao clicar na barra de pesquisa
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchPageResearch()),
                      );
                    },
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    // Navega para a tela de filtro ao clicar no ícone de filtro
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => filter()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(Icons.filter_list, color: Colors.white),
                  ),
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
                  'lib/assets/Universidades.png', // Image URL
                  closest(),
                ),
                buildCategoryCard(
                  context,
                  'Melhores avaliados',
                  'lib/assets/MelhoresAvaliadas.png', // Image URL
                  best_rated(),
                ),
                buildCategoryCard(
                  context,
                  'Vestibulares',
                  'lib/assets/Vestibulares.png', // Image URL
                  entrance_exams(),
                ),
                buildCategoryCard(
                  context,
                  'Favoritos/Notícias',
                  'lib/assets/FavoritosOuNoticias.png', // Image URL
                  fav.FavoritesScreen(), // Usando o prefixo para evitar conflito
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
                errorBuilder: (context, error, stackTrace) {
                  // This handles the image load error and shows a placeholder
                  return Container(
                    height: 150,
                    color: Colors.grey[300],
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey[700],
                        size: 50,
                      ),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
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
