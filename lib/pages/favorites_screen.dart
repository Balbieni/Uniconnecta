import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniconnecta/components/favorites_model.dart';
import 'package:uniconnecta/pages/convest.dart';
import 'package:uniconnecta/pages/enem.dart';
import 'package:uniconnecta/pages/mackenzie.dart';
import 'package:uniconnecta/pages/news_screen.dart';
import 'package:uniconnecta/pages/pages.dart';
import 'package:uniconnecta/pages/unesp.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesModel = Provider.of<FavoritesModel>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Seus favoritos",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.purple),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: TabBar(
            labelColor: Colors.purple,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.purple,
            tabs: [
              Tab(text: "Universidades"),
              Tab(text: "Notícias"),
              Tab(text: "Vestibulares"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildUniversityList(favoritesModel, context),
            _buildNewsList(favoritesModel, context),
            _buildVestibularList(favoritesModel, context),
          ],
        ),
      ),
    );
  }

  // Lista de universidades favoritas
  Widget _buildUniversityList(
      FavoritesModel favoritesModel, BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: favoritesModel.favoriteUniversities.length,
      itemBuilder: (context, index) {
        final universidade = favoritesModel.favoriteUniversities[index];
        return GestureDetector(
          onTap: () {
            // Verifique o nome da universidade favoritada e navegue para a página correta
            if (universidade.nome == "Unicamp") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Unicamp(
                    title: "Unicamp",
                    subtitle:
                        "Universidade renomada", // Passe o subtítulo corretamente
                  ),
                ),
              );
            }
            if (universidade.nome == "Unesp") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Unesp(
                    title: "Unesp",
                    subtitle:
                        "Universidade renomada", // Passe o subtítulo corretamente
                  ),
                ),
              );
            }
            if (universidade.nome == "Mackenzie") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Mackenzie(
                    title: "Mackenzie",
                    subtitle:
                        "Universidade renomada", // Passe o subtítulo corretamente
                  ),
                ),
              );
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(universidade.logoUrl, height: 50, width: 50),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          universidade.nome,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(universidade.curso,
                            style: TextStyle(color: Colors.grey)),
                        Row(
                          children: [
                            Icon(Icons.star,
                                color: Colors.yellow[700], size: 16),
                            Icon(Icons.star,
                                color: Colors.yellow[700], size: 16),
                            Icon(Icons.star,
                                color: Colors.yellow[700], size: 16),
                            Icon(Icons.star,
                                color: Colors.yellow[700], size: 16),
                            Icon(Icons.star_border,
                                color: Colors.grey, size: 16),
                            SizedBox(width: 8),
                            Text("4.5"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite, color: Colors.purple),
                        onPressed: () {
                          favoritesModel.removeUniversityFavorite(universidade);
                        },
                      ),
                      Text("50Km", style: TextStyle(color: Colors.grey)),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Lista de vestibulares favoritos
  Widget _buildVestibularList(
      FavoritesModel favoritesModel, BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: favoritesModel.favoriteVestibulares.length,
      itemBuilder: (context, index) {
        final vestibular = favoritesModel.favoriteVestibulares[index];
        return GestureDetector(
          onTap: () {
            if (vestibular.nome == "Convest") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Convest(
                    title: "Convest",
                    subtitle: "Inscrições abertas",
                  ),
                ),
              );
            }
            if (vestibular.nome == "enem") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Enem(
                    title: "Enem",
                    subtitle: "Inscrições abertas",
                  ),
                ),
              );
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(vestibular.logoUrl, height: 50, width: 50),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vestibular.nome,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.purple, size: 16),
                            Icon(Icons.star, color: Colors.purple, size: 16),
                            Icon(Icons.star, color: Colors.purple, size: 16),
                            Icon(Icons.star, color: Colors.purple, size: 16),
                            Icon(Icons.star_half,
                                color: Colors.purple, size: 16),
                            SizedBox(width: 8),
                            Text("4.5"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite, color: Colors.purple),
                        onPressed: () {
                          favoritesModel.removeVestibularFavorite(vestibular);
                        },
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Ação de inscrição
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text("Inscrições abertas"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Lista de notícias favoritas
  Widget _buildNewsList(FavoritesModel favoritesModel, BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: favoritesModel.favoriteNews.length,
      itemBuilder: (context, index) {
        final noticia = favoritesModel.favoriteNews[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsScreen(),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 3,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(noticia['image']!, height: 50, width: 50),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          noticia['title']!,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(noticia['date']!,
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      favoritesModel.removeNewsFavorite(noticia);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
