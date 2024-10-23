import 'package:flutter/material.dart';
import 'package:uniconnecta/components/components.dart';
import 'package:uniconnecta/pages/convest.dart';
import 'package:uniconnecta/components/class_of_model.dart'; // Import para o modelo Universidade
import 'package:uniconnecta/components/university_header.dart';
import 'package:uniconnecta/components/favorites_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Unicamp extends StatelessWidget {
  final String title;
  final String subtitle;

  Unicamp({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            // Header com o botão de favorito integrado
            Consumer<FavoritesModel>(
              builder: (context, favoritesModel, child) {
                // Criamos o objeto Universidade baseado no item
                final universidade = Universidade(
                  nome: title,
                  curso: subtitle,
                  avaliacao: 4.5, // Avaliação fixa como exemplo
                  distancia: '5 Km', // Distância de exemplo
                  modalidade: "Presencial", // Exemplo de modalidade
                  logoUrl: 'lib/assets/unicamp_logo.png', // Caminho da logo
                );

                return UniversityHeader(
                  universityOrEntranceExamName: title,
                  courseName: subtitle,
                  rating: 4.5,
                  locationType: 'Presencial',
                  imagePath: 'lib/assets/unicamp_logo.png',
                  universidade: universidade, // Passa o objeto Universidade
                );
              },
            ),
            Container(
              color: Colors.white,
              child: const TabBar(
                isScrollable: true,
                indicatorColor: Colors.purple,
                labelColor: Colors.purple,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: 'Vestibulares'),
                  Tab(text: 'Sobre seu curso'),
                  Tab(text: 'Notas de corte'),
                  Tab(text: 'Avaliações'),
                  Tab(text: 'Outros Cursos'),
                  Tab(text: 'Sobre a universidade'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const VestibularesTab(),
                  const SobreCursoTab(),
                  const NotasDeCorteTab(),
                  const AvaliacoesTab(),
                  const OutrosCursosTab(),
                  SobreUniversidadeTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VestibularesTab extends StatelessWidget {
  const VestibularesTab({Key? key}) : super(key: key);

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

class SobreCursoTab extends StatelessWidget {
  const SobreCursoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sobre o curso de Medicina',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),
          _buildSection('Coordenadoria do Curso', [
            'Diretor: Dr. Ricardo Medeiros',
            'Coordenador Acadêmico: Dr. Marcos Soares',
            'Coordenadora de Estágios: Dra. Patrícia Lima',
          ]),
          const SizedBox(height: 16),
          _buildSection('Estrutura Curricular', [
            '1º ano: Ciências básicas (anatomia, bioquímica, fisiologia)',
            '2º e 3º ano: Estágios supervisionados em hospitais universitários',
            '4º a 6º ano: Residência clínica, atendimento ambulatorial e emergencial',
          ]),
          const SizedBox(height: 16),
          _buildLink(
              'Clique aqui para mais informações sobre o curso de Medicina na Unicamp',
              '#'),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items.map((item) => Text(item)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLink(String text, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class NotasDeCorteTab extends StatelessWidget {
  const NotasDeCorteTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildNotaCard(ano: '2023', vagas: 71, notaDeCorte: 726.8),
        _buildNotaCard(ano: '2022', vagas: 88, notaDeCorte: 732.2),
        _buildNotaCard(ano: '2021', vagas: 71, notaDeCorte: 720.5),
      ],
    );
  }

  Widget _buildNotaCard({
    required String ano,
    required int vagas,
    required double notaDeCorte,
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
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            Text(
              'Nota de corte: ${notaDeCorte.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {}, // Lógica de ação
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

class AvaliacoesTab extends StatelessWidget {
  const AvaliacoesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const SizedBox(height: 16),
        AverageRating(
          imagePath: 'lib/assets/unicamp_logo.png',
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(
                5,
                (index) => Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              review,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class OutrosCursosTab extends StatelessWidget {
  const OutrosCursosTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Outros cursos oferecidos pela Unicamp',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),
          _buildCourseSection('Faculdade de Ciências Médicas', [
            'Fisioterapia',
            'Odontologia',
            'Enfermagem',
          ]),
          const SizedBox(height: 16),
          _buildCourseSection('Faculdade de Engenharia', [
            'Engenharia Elétrica',
            'Engenharia de Computação',
            'Engenharia Química',
          ]),
          const SizedBox(height: 16),
          _buildCourseSection('Faculdade de Artes', [
            'Artes Visuais',
            'Música',
            'Dança',
          ]),
          const SizedBox(height: 16),
          _buildLink('Veja a lista completa de cursos da Unicamp', '#'),
        ],
      ),
    );
  }

  Widget _buildCourseSection(String title, List<String> courses) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: courses.map((course) => Text(course)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLink(String text, String url) {
    return GestureDetector(
      onTap: () => _launchURL(url),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class SobreUniversidadeTab extends StatelessWidget {
  // Método para abrir o link no Google Maps
  void _openMapLocation() async {
    const url =
        'https://www.google.com/maps/place/Universidade+Estadual+de+Campinas/@-22.8184393,-47.0672955,17z/data=!3m1!4b1!4m6!3m5!1s0x94c8c6b005d24db5:0xc6db750ecf04d796!8m2!3d-22.8184393!4d-47.0647206!16zL20vMDJrY2d5?entry=ttu&g_ep=EgoyMDI0MTAyMC4xIKXMDSoASAFQAw%3D%3D'; // Link da localização da Unicamp no Google Maps
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o mapa: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidade Estadual de Campinas (Unicamp)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Localização',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 8.0),
            GestureDetector(
              onTap:
                  _openMapLocation, // Ao clicar, o link do Google Maps é aberto
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    // Exibe a imagem do mapa (substitua pela sua própria imagem de mapa)
                    Image.asset(
                      'lib/assets/unicamp_map.png', // Certifique-se de ter essa imagem
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Universidade Estadual de Campinas (Unicamp)\nInstituição pública de ensino superior',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.location_on, color: Colors.purple),
                        SizedBox(width: 4.0),
                        Expanded(
                          child: Text(
                            'Cidade Universitária Zeferino Vaz, Barão Geraldo, Campinas - SP',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: const [
                        Icon(Icons.star, color: Colors.purple),
                        SizedBox(width: 4.0),
                        Text(
                          '4.5',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          '• 50Km de distância',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ],
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
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'A Unicamp é responsável por 8% da pesquisa acadêmica no Brasil, '
              'e oferece mais de 150 cursos de pós-graduação e mestrado. A universidade '
              'possui cerca de 34 mil alunos matriculados em 66 cursos de graduação.',
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
