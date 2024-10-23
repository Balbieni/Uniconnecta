import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniconnecta/components/class_of_model.dart';
import 'package:uniconnecta/components/favorites_model.dart';
import 'package:uniconnecta/pages/convest.dart';
import 'package:uniconnecta/pages/enem.dart';
import 'package:uniconnecta/pages/mackenzie.dart';
import 'package:uniconnecta/pages/news_screen.dart';
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
            _navigateToUniversityDetails(context, universidade);
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
                            buildRatingStars(universidade.avaliacao),
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
                      Text("${universidade.distancia}Km",
                          style: TextStyle(color: Colors.grey)),
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

  // Função para navegação para os detalhes da universidade
  void _navigateToUniversityDetails(
      BuildContext context, Universidade universidade) {
    if (universidade.nome == "Unicamp") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Unicamp(title: "Unicamp", subtitle: "Universidade renomada"),
        ),
      );
    } else if (universidade.nome == "Unesp") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Unesp(title: "Unesp", subtitle: "Universidade renomada"),
        ),
      );
    } else if (universidade.nome == "Mackenzie") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Mackenzie(title: "Mackenzie", subtitle: "Universidade renomada"),
        ),
      );
    }
  }

// Lista de vestibulares favoritos (modificado)
  Widget _buildVestibularList(
      FavoritesModel favoritesModel, BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: favoritesModel.favoriteVestibulares.length,
      itemBuilder: (context, index) {
        final vestibular = favoritesModel.favoriteVestibulares[index];
        return GestureDetector(
          onTap: () {
            _navigateToVestibularDetails(context, vestibular);
          },
          child: Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                        buildRatingStars(vestibular.avaliacao),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite, color: Colors.purple),
                    onPressed: () {
                      favoritesModel.removeVestibularFavorite(vestibular);
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

  // Função para navegação para os detalhes do vestibular
  void _navigateToVestibularDetails(
      BuildContext context, Vestibular vestibular) {
    if (vestibular.nome == "Convest") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Convest(title: "Convest", subtitle: "Inscrições abertas"),
        ),
      );
    } else if (vestibular.nome == "Enem") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Enem(title: "Enem", subtitle: "Inscrições abertas"),
        ),
      );
    }
  }

  // Lista de notícias favoritas
  Widget _buildNewsList(FavoritesModel favoritesModel, BuildContext context) {
    // Cria uma instância de NewsScreen
    final newsScreen = NewsScreen();

    return ListView(
      padding: EdgeInsets.all(8),
      children: favoritesModel.favoriteNews.map((noticia) {
        // Usa a instância criada para chamar o método noticiaCard
        return newsScreen.noticiaCard(
          context,
          favoritesModel,
          noticia['image']!,
          noticia['title']!,
          noticia['date']!,
          noticia['description']!,
          noticia['url']!,
        );
      }).toList(),
    );
  }

  // Função para exibir estrelas de avaliação
  Widget buildRatingStars(double rating) {
    int fullStars = rating.floor();
    int halfStars = (rating - fullStars >= 0.5) ? 1 : 0;
    int emptyStars = 5 - fullStars - halfStars;

    return Row(
      children: [
        ...List.generate(fullStars,
            (index) => Icon(Icons.star, color: Colors.purple, size: 16)),
        if (halfStars > 0)
          Icon(Icons.star_half, color: Colors.purple, size: 16),
        ...List.generate(emptyStars,
            (index) => Icon(Icons.star_border, color: Colors.purple, size: 16)),
      ],
    );
  }
}
