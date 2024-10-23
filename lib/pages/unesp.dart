import 'package:flutter/material.dart';
import 'package:uniconnecta/components/components.dart';
import 'package:uniconnecta/pages/convest.dart';
import 'package:uniconnecta/components/class_of_model.dart'; // Import para o modelo Universidade
import 'package:uniconnecta/components/university_header.dart';
import 'package:uniconnecta/components/favorites_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: onPressedInscrever,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white, // Texto branco
                  ),
                  child: const Text('Inscrever-se'),
                ),
                const SizedBox(width: 16),
                OutlinedButton(
                  onPressed: onPressedPagina,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Colors.purple), // Borda azul UNESP
                    foregroundColor: Colors.purple, // Texto azul UNESP
                  ),
                  child: const Text('Ir para a página'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Unesp extends StatelessWidget {
  final String title;
  final String subtitle;

  Unesp({Key? key, required this.title, required this.subtitle})
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
                final universidade = Universidade(
                  nome: title,
                  curso: subtitle,
                  avaliacao: 4.2, // Avaliação fixa como exemplo
                  distancia: '10 Km', // Distância de exemplo
                  modalidade: "Presencial", // Exemplo de modalidade
                  logoUrl: 'lib/assets/unesp.png', // Caminho da logo
                );

                return UniversityHeader(
                  universityOrEntranceExamName: title,
                  courseName: subtitle,
                  rating: 4.2,
                  locationType: 'Presencial',
                  imagePath: 'lib/assets/unesp.png',
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
          title: 'Vunesp',
          description:
              'Inscrições de 1º de agosto a 15 de setembro. Prova aplicada em novembro.',
          onPressedInscrever: () {},
          onPressedPagina: () {},
        ),
        ExamCard(
          title: 'Enem',
          description:
              'Período de inscrições será de 27 de maio a 7 de junho. Provas em novembro.',
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
            'Sobre o curso de Nutrição',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),
          _buildSection('Coordenação e Corpo Docente', [
            'Coordenadora: Dra. Ana Paula Ribeiro',
            'Docente: Prof. Dr. João Mendes',
            'Docente: Dra. Cláudia Pereira',
          ]),
          const SizedBox(height: 16),
          _buildSection('Grade Curricular', [
            '1º e 2º anos: Fundamentos de nutrição e saúde pública',
            '3º e 4º anos: Nutrição clínica, esportiva e comunitária',
            'Estágio supervisionado: 500 horas em instituições de saúde',
          ]),
          const SizedBox(height: 16),
          _buildLink('Saiba mais sobre o curso de Nutrição na Unesp', '#'),
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
          color: Colors.purple,
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
        _buildNotaCard(ano: '2023', vagas: 60, notaDeCorte: 670.5),
        _buildNotaCard(ano: '2022', vagas: 65, notaDeCorte: 662.0),
        _buildNotaCard(ano: '2021', vagas: 60, notaDeCorte: 660.8),
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
              'Nutrição $ano',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Vagas: $vagas',
                style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            Text('Nota de corte: ${notaDeCorte.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 16, color: Colors.grey[600])),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
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
          imagePath: 'lib/assets/unesp.png',
          rating: 4.2,
          recommendationText:
              '89.5% dos alunos que avaliaram recomendam este curso',
        ),
        const SizedBox(height: 16),
        StudentReview(
          name: 'Joana Silva',
          rating: 4.5,
          review: 'Curso excelente, com foco em diversas áreas de atuação...',
        ),
      ],
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
            'Outros cursos oferecidos pela Unesp',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),
          _buildCourseSection('Faculdade de Ciências Biológicas', [
            'Biomedicina',
            'Ciências Biológicas',
            'Ecologia',
          ]),
          const SizedBox(height: 16),
          _buildCourseSection('Faculdade de Engenharia', [
            'Engenharia Civil',
            'Engenharia Mecânica',
            'Engenharia de Produção',
          ]),
          const SizedBox(height: 16),
          _buildCourseSection('Faculdade de Humanidades', [
            'Filosofia',
            'História',
            'Geografia',
          ]),
          const SizedBox(height: 16),
          _buildLink('Veja a lista completa de cursos da Unesp', '#'),
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
          color: Colors.purple,
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
        'https://www.google.com/maps/place/Instituto+de+Artes+da+Universidade+Estadual+Paulista+-+IA%2FUNESP+(Câmpus+de+São+Paulo+-+Unesp)/@-23.524152,-46.6712248,17z/data=!4m10!1m2!2m1!1sunesp!3m6!1s0x94ce5800fd7f4c0d:0x84518d70a9844bcf!8m2!3d-23.524152!4d-46.6664612!15sCgV1bmVzcCIDiAEBkgERcHVibGljX3VuaXZlcnNpdHngAQA!16s%2Fg%2F1t_khnx0?entry=ttu&g_ep=EgoyMDI0MTAyMC4xIKXMDSoASAFQAw%3D%3D'; // Link da localização da Unesp no Google Maps
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
        title: const Text('Universidade Estadual Paulista Unesp (UNESP)'),
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
                      'lib/assets/unesp_map.png', // Certifique-se de ter essa imagem
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Universidade Estadual Paulista Unesp (UNESP)\nInstituição pública de ensino superior',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.location_on, color: Colors.purple),
                        SizedBox(width: 4.0),
                        Expanded(
                          child: Text(
                            'Instituto de Artes da Universidade Estadual Paulista - IA/UNESP, São Paulo - SP',
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
              'A Universidade Estadual Paulista (Unesp) é uma das maiores e mais '
              'importantes instituições de ensino superior do Brasil, com diversos '
              'campi espalhados pelo estado de São Paulo. Oferece cursos em variadas '
              'áreas do conhecimento, como artes, ciências exatas, humanas e biológicas.',
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
