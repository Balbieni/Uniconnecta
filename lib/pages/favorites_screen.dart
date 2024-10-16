import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniconnecta/components/favorites_model.dart';

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
            _buildUniversityList(favoritesModel),
            _buildNewsList(favoritesModel),
            _buildVestibularList(favoritesModel),
          ],
        ),
      ),
    );
  }

  Widget _buildUniversityList(FavoritesModel favoritesModel) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: favoritesModel.favoriteUniversities.length,
      itemBuilder: (context, index) {
        final universidade = favoritesModel.favoriteUniversities[index];
        return Card(
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
                      Text(
                        universidade.curso,
                        style: TextStyle(color: Colors.grey),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow[700], size: 16),
                          Icon(Icons.star, color: Colors.yellow[700], size: 16),
                          Icon(Icons.star, color: Colors.yellow[700], size: 16),
                          Icon(Icons.star, color: Colors.yellow[700], size: 16),
                          Icon(Icons.star_border, color: Colors.grey, size: 16),
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
        );
      },
    );
  }

  Widget _buildNewsList(FavoritesModel favoritesModel) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: favoritesModel.favoriteNews.length,
      itemBuilder: (context, index) {
        final noticia = favoritesModel.favoriteNews[index];
        return Card(
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
        );
      },
    );
  }

  Widget _buildVestibularList(FavoritesModel favoritesModel) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: favoritesModel.favoriteVestibulares.length,
      itemBuilder: (context, index) {
        final vestibular = favoritesModel.favoriteVestibulares[index];
        return Card(
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
                      Text(vestibular.curso,
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    favoritesModel.removeVestibularFavorite(vestibular);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
