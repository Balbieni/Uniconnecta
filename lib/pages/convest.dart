import 'package:flutter/material.dart';
import 'package:uniconnecta/components/components.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages.dart';

class Convest extends StatelessWidget {
  final ValueNotifier<bool> isFavoritedNotifier = ValueNotifier<bool>(false);

  Convest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        body: Column(
          children: [
            UniversityHeader(
              universityName: 'Unicamp',
              courseName: 'Medicina',
              rating: 4.5,
              locationType: 'Presencial',
              distance: '50Km',
              imagePath: 'lib/assets/faculdade1.png',
              isFavorited: isFavoritedNotifier,
            ),
            const TabBar(
              isScrollable:
                  true, // Permite rolar as abas se o texto for muito longo
              indicatorColor: Colors.purple,
              labelColor: Colors.purple,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(child: Text('Vestibulares')),
                Tab(child: Text('Sobre seu curso')),
                Tab(child: Text('Notas de corte')),
                Tab(child: Text('Avaliações')),
                Tab(child: Text('Outros Cursos')),
                Tab(child: Text('Sobre a universidade')),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  InscrevaSeTab(),
                  EditalTab(),
                  ConteudosTab(),
                  ObrasLiterariasTab(),
                  ProvasAnterioresTab(),
                  SobreOVestibularTab(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: NavBar(),
      ),
    );
  }
}

class InscrevaSeTab extends StatelessWidget {
  const InscrevaSeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ExamCard(
          title: 'Convest',
          description:
              'Período de inscrições será de 27 de maio a 7 de junho. Provas serão aplicadas nos dias 3 e 10 de novembro em todo o Brasil.',
          onPressedInscrever: () {},
          onPressedPagina: () {},
        ),
        ExamCard(
          title: 'Enem',
          description:
              'Período de inscrições será de 27 de maio a 7 de junho. Provas serão aplicadas nos dias 3 e 10 de novembro em todo o Brasil.',
          onPressedInscrever: () {},
          onPressedPagina: () {},
        ),
      ],
    );
  }
}

class EditalTab extends StatelessWidget {
  const EditalTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'teste',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          const Text(
            'Confira a matéria original em: ',
            style: TextStyle(fontSize: 16),
          ),
          InkWell(
              child: const Text(
                'https://www.guiadacarreira.com.br/blog/curso-de-medicina',
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
              onTap: () {}
              // Open the URL in a web browser
              ),
        ],
      ),
    );
  }
}

class ConteudosTab extends StatelessWidget {
  const ConteudosTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildNotaCard(
          ano: '2023',
          vagas: 71,
          notaDeCorte: 726.8,
          onPressed: () {},
        ),
        _buildNotaCard(
          ano: '2022',
          vagas: 88,
          notaDeCorte: 732.2,
          onPressed: () {},
        ),
        _buildNotaCard(
          ano: '2021',
          vagas: 71,
          notaDeCorte: 720.5,
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildNotaCard({
    required String ano,
    required int vagas,
    required double notaDeCorte,
    required VoidCallback onPressed,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Medicina $ano',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Vagas: $vagas',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            Text(
              'Nota de corte: ${notaDeCorte.toStringAsFixed(1)}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.purple,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Confira no site'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ObrasLiterariasTab extends StatelessWidget {
  const ObrasLiterariasTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const SizedBox(height: 16),
        AverageRating(
          imagePath: 'lib/assets/faculdade1.png',
          rating: 4.5,
          recommendationText:
              '86.98% dos alunos que avaliaram recomendam este curso',
        ),
        const SizedBox(height: 16),
        StudentReview(
          name: 'Matheus Duarte',
          rating: 4.0,
          review: 'O curso de Medicina da Unicamp é um dos melhores do país...',
        ),
        // Adicione mais StudentReview widgets conforme necessário
      ],
    );
  }
}

class StudentReview extends StatelessWidget {
  final String name;
  final double rating;
  final String review;

  const StudentReview({
    Key? key,
    required this.name,
    required this.rating,
    required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.purple, // Alinhando com a cor principal
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '⭐ ${rating.toStringAsFixed(1)}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey, // Estilo consistente para subtítulos
              ),
            ),
            const SizedBox(height: 5),
            Text(
              review,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class ProvasAnterioresTab extends StatelessWidget {
  const ProvasAnterioresTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Outros cursos serão exibidos aqui.',
            style: TextStyle(
              color: ColorStyle.RoxoP,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'texto imenso que eu vou colocar',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class SobreOVestibularTab extends StatelessWidget {
  const SobreOVestibularTab({Key? key}) : super(key: key);

  void _launchMapsUrl(String query) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$query';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Localização',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple, // Ajuste para a cor desejada
            ),
          ),
          const SizedBox(height: 8.0),
          GestureDetector(
            onTap: () => _launchMapsUrl('Universidade Estadual de Campinas'),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple), // Borda roxa
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/university_map.png', // Coloque o caminho correto para o mapa
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Universidade Estadual de Campinas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const Text(
                          'Instituição de ensino superior',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.purple, size: 16.0),
                            const Text(' 4.5',
                                style: TextStyle(fontSize: 14.0)),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Cidade Universitária Zeferino Vaz - Barão Geraldo, Campinas - SP, 130083-970',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          const Text(
            'Sobre a Universidade',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple, // Ajuste para a cor desejada
            ),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'A Unicamp responde por 8% da pesquisa acadêmica no Brasil, 12% da pós-graduação nacional e mantém a liderança entre as universidades brasileiras no que diz respeito a patentes e ao número de artigos per capita publicados anualmente em revistas indexadas na base de dados ISI/Web of Science. A Universidade conta com aproximadamente 34 mil alunos matriculados em 66 cursos de graduação e 153 programas de pós-graduação...',
            style: TextStyle(fontSize: 14.0),
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

class ExamCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onPressedInscrever;
  final VoidCallback onPressedPagina;

  const ExamCard({
    Key? key,
    required this.title,
    required this.description,
    required this.onPressedInscrever,
    required this.onPressedPagina,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPressedInscrever,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purple, // Cor do texto do botão
                    ),
                    child: const Text('Inscreva-se'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onPressedPagina,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purple, // Cor do texto do botão
                    ),
                    child: const Text('Acessar página'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
