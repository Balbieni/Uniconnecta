import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Para acessar o FavoritesModel
import 'package:url_launcher/url_launcher.dart';
import 'package:uniconnecta/components/favorites_model.dart'; // Modelo de favoritos

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Número de abas
      child: Scaffold(
        body: Column(
          children: [
            // Adicionando o título "Notícias"
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
              child: Text(
                'Notícias',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            // Criando as Tabs
            TabBar(
              labelColor: Colors.purple,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.purple,
              tabs: [
                Tab(text: 'Recentes'),
                Tab(text: 'Vestibulares'),
                Tab(text: 'Atualidades'),
                Tab(text: 'Relacionados aos favoritos'),
              ],
            ),
            Expanded(
              // Exibindo o conteúdo baseado na Tab ativa
              child: TabBarView(
                children: [
                  noticiasListView(context, 'Recentes'),
                  noticiasListView(context, 'Vestibulares'),
                  noticiasListView(context, 'Atualidades'),
                  noticiasListView(context, 'Relacionados aos favoritos'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Retorna uma lista de notícias específica para cada aba
  Widget noticiasListView(BuildContext context, String tab) {
    final favoritesModel = Provider.of<FavoritesModel>(context);
    List<Map<String, String>> noticias;

    switch (tab) {
      case 'Recentes':
        noticias = [
          {
            'title': 'Notícia 1 - Recentes',
            'date': '20/05/2024',
            'description': 'Descrição da notícia 1 da aba Recentes...',
            'url': 'https://example.com/noticia1',
            'image': 'lib/assets/unicamp_logo.png'
          },
          {
            'title': 'Notícia 2 - Recentes',
            'date': '21/05/2024',
            'description': 'Descrição da notícia 2 da aba Recentes...',
            'url': 'https://example.com/noticia2',
            'image': 'lib/assets/unicamp_logo.png'
          },
          {
            'title': 'Notícia 3 - Recentes',
            'date': '22/05/2024',
            'description': 'Descrição da notícia 3 da aba Recentes...',
            'url': 'https://example.com/noticia3',
            'image': 'lib/assets/unicamp_logo.png'
          },
        ];
        break;

      case 'Vestibulares':
        noticias = [
          {
            'title': 'Notícia 1 - Vestibulares',
            'date': '23/05/2024',
            'description': 'Descrição da notícia 1 da aba Vestibulares...',
            'url': 'https://example.com/noticia4',
            'image': 'lib/assets/unicamp_logo.png'
          },
          {
            'title': 'Notícia 2 - Vestibulares',
            'date': '24/05/2024',
            'description': 'Descrição da notícia 2 da aba Vestibulares...',
            'url': 'https://example.com/noticia5',
            'image': 'lib/assets/unicamp_logo.png'
          },
        ];
        break;

      case 'Atualidades':
        noticias = [
          {
            'title': 'Notícia 1 - Atualidades',
            'date': '26/05/2024',
            'description': 'Descrição da notícia 1 da aba Atualidades...',
            'url': 'https://example.com/noticia7',
            'image': 'lib/assets/unicamp_logo.png'
          },
        ];
        break;

      case 'Relacionados aos favoritos':
        noticias = favoritesModel.favoriteNews; // Pega as notícias favoritedas
        break;

      default:
        noticias = [];
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: noticias.map((noticia) {
          return noticiaCard(
            context,
            noticia['image']!,
            noticia['title']!,
            noticia['date']!,
            noticia['description']!,
            noticia['url']!,
          );
        }).toList(),
      ),
    );
  }

  Widget noticiaCard(BuildContext context, String imageUrl, String title,
      String date, String description, String url) {
    final favoritesModel = Provider.of<FavoritesModel>(context);

    // Criação do objeto notícia para manipulação no modelo de favoritos
    final noticia = {
      'title': title,
      'date': date,
      'description': description,
      'url': url,
      'image': imageUrl,
    };

    final isFavorited = favoritesModel.isNewsFavorite(noticia);

    return GestureDetector(
      onTap: () => _launchURL(url), // Função para abrir o link da notícia
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10),
              Text(
                date,
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(color: Colors.grey[700]),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? Colors.purple : Colors.grey,
                    ),
                    onPressed: () {
                      if (isFavorited) {
                        favoritesModel.removeNewsFavorite(noticia);
                      } else {
                        favoritesModel.addNewsFavorite(noticia);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Não foi possível abrir o link $url';
    }
  }
}
