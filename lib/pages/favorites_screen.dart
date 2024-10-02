import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Universidade> universidades = [
    Universidade(
        nome: "Unicamp",
        curso: "Medicina",
        avaliacao: 4.5,
        distancia: "50Km",
        modalidade: "Presencial",
        logoUrl: "lib/assets/unicamp_logo.png"),
    // Outras universidades podem ser adicionadas aqui
  ];

  final List<Map<String, String>> noticias = [
    {
      'title': 'Notícia 1 - Recentes',
      'date': '20/05/2024',
      'description': 'Descrição da notícia 1 da aba Recentes...',
      'url': 'https://example.com/noticia1',
      'image': 'lib/assets/unicamp_logo.png',
    },
    // Outras notícias podem ser adicionadas aqui
  ];

  final List<Vestibular> vestibulares = [
    Vestibular(
        nome: "Unicamp",
        curso: "Medicina",
        avaliacao: 4.5,
        distancia: "50Km",
        modalidade: "Presencial",
        logoUrl: "lib/assets/unicamp_logo.png"),
    // Outros vestibulares podem ser adicionados aqui
  ];

  @override
  Widget build(BuildContext context) {
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
            // Lista de Universidades
            ListView.builder(
              itemCount: universidades.length,
              itemBuilder: (context, index) {
                final universidade = universidades[index];
                return FavoritoCard(universidade: universidade);
              },
            ),
            // Lista de Notícias
            ListView.builder(
              itemCount: noticias.length,
              itemBuilder: (context, index) {
                final noticia = noticias[index];
                return noticiaCard(
                  noticia['image']!,
                  noticia['title']!,
                  noticia['date']!,
                  noticia['description']!,
                  noticia['url']!,
                );
              },
            ),
            // Lista de Vestibulares
            ListView.builder(
              itemCount: vestibulares.length,
              itemBuilder: (context, index) {
                final vestibular = vestibulares[index];
                return VestibularCard(vestibular: vestibular);
              },
            ),
          ],
        ),
      ),
    );
  }

  // Função para abrir a URL
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir $url';
    }
  }

  // Widget para exibir cada notícia
  Widget noticiaCard(String imageUrl, String title, String date,
      String description, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
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
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, color: Colors.red);
                  },
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
              Align(
                alignment: Alignment.centerRight,
                child: FavoriteIcon(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget para o card de vestibulares
class VestibularCard extends StatefulWidget {
  final Vestibular vestibular;

  const VestibularCard({Key? key, required this.vestibular}) : super(key: key);

  @override
  _VestibularCardState createState() => _VestibularCardState();
}

class _VestibularCardState extends State<VestibularCard> {
  bool isFavorited = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.vestibular.logoUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, color: Colors.red);
              },
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.vestibular.nome,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  SizedBox(height: 4),
                  Text(widget.vestibular.curso,
                      style: TextStyle(fontSize: 14, color: Colors.black54)),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.purple, size: 16),
                      Icon(Icons.star, color: Colors.purple, size: 16),
                      Icon(Icons.star, color: Colors.purple, size: 16),
                      Icon(Icons.star, color: Colors.purple, size: 16),
                      Icon(Icons.star_border, color: Colors.purple, size: 16),
                      SizedBox(width: 8),
                      Text(widget.vestibular.avaliacao.toString(),
                          style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(16)),
                        child: Text(widget.vestibular.modalidade,
                            style:
                                TextStyle(fontSize: 12, color: Colors.purple)),
                      ),
                      SizedBox(width: 16),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey, size: 16),
                          SizedBox(width: 4),
                          Text(widget.vestibular.distancia,
                              style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorited ? Icons.favorite : Icons.favorite_border,
                color: isFavorited ? Colors.purple : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isFavorited = !isFavorited;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Vestibular {
  final String nome;

  final String logoUrl;
  final String curso;
  final double avaliacao;
  final String distancia;
  final String modalidade;

  Vestibular({
    required this.nome,
    required this.logoUrl,
    required this.curso,
    required this.avaliacao,
    required this.distancia,
    required this.modalidade,
  });
}

// Componente com estado para o ícone do coração
class FavoriteIcon extends StatefulWidget {
  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool isFavorited = true;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorited ? Icons.favorite : Icons.favorite_border,
        color: isFavorited ? Colors.purple : Colors.grey,
      ),
      onPressed: () {
        setState(() {
          isFavorited = !isFavorited;
        });
      },
    );
  }
}

class FavoritoCard extends StatefulWidget {
  final Universidade universidade;

  const FavoritoCard({Key? key, required this.universidade}) : super(key: key);

  @override
  _FavoritoCardState createState() => _FavoritoCardState();
}

class _FavoritoCardState extends State<FavoritoCard> {
  bool isFavorited = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.universidade.logoUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, color: Colors.red);
              },
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.universidade.nome,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  SizedBox(height: 4),
                  Text(widget.universidade.curso,
                      style: TextStyle(fontSize: 14, color: Colors.black54)),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.purple, size: 16),
                      Icon(Icons.star, color: Colors.purple, size: 16),
                      Icon(Icons.star, color: Colors.purple, size: 16),
                      Icon(Icons.star, color: Colors.purple, size: 16),
                      Icon(Icons.star_border, color: Colors.purple, size: 16),
                      SizedBox(width: 8),
                      Text(widget.universidade.avaliacao.toString(),
                          style: TextStyle(color: Colors.black54)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.purple[100],
                            borderRadius: BorderRadius.circular(16)),
                        child: Text(widget.universidade.modalidade,
                            style:
                                TextStyle(fontSize: 12, color: Colors.purple)),
                      ),
                      SizedBox(width: 16),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey, size: 16),
                          SizedBox(width: 4),
                          Text(widget.universidade.distancia,
                              style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                isFavorited ? Icons.favorite : Icons.favorite_border,
                color: isFavorited ? Colors.purple : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  isFavorited = !isFavorited;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Universidade {
  final String nome;
  final String curso;
  final double avaliacao;
  final String distancia;
  final String modalidade;
  final String logoUrl;

  Universidade({
    required this.nome,
    required this.curso,
    required this.avaliacao,
    required this.distancia,
    required this.modalidade,
    required this.logoUrl,
  });
}
