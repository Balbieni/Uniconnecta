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

class Unimetrocamp extends StatelessWidget {
  final String title;
  final String subtitle;

  Unimetrocamp({Key? key, required this.title, required this.subtitle})
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
                  avaliacao: 4.8, // Avaliação fixa como exemplo
                  distancia: '2 Km', // Distância de exemplo
                  modalidade: "Presencial", // Exemplo de modalidade
                  logoUrl: 'lib/assets/Unimetrocamp.png', // Caminho da logo
                );

                return UniversityHeader(
                  universityOrEntranceExamName: title,
                  courseName: subtitle,
                  rating: 4.8,
                  locationType: 'Presencial',
                  imagePath: 'lib/assets/Unimetrocamp.png',
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
            const Expanded(
              child: TabBarView(
                children: [
                  VestibularesTab(),
                  SobreCursoTab(),
                  NotasDeCorteTab(),
                  AvaliacoesTab(),
                  OutrosCursosTab(),
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
          title: 'Unimetrocamp',
          description:
              'Inscrições até 20 de setembro. Prova aplicada em dezembro.',
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
            'Sobre o curso de Design Gráfico',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),
          _buildSection('Coordenação e Corpo Docente', [
            'Coordenadora: Profa. Dra. Alice Martins',
            'Docente: Prof. André Lopes',
            'Docente: Dra. Silvia Ramos',
          ]),
          const SizedBox(height: 16),
          _buildSection('Disciplinas e Projetos', [
            '1º e 2º anos: Fundamentos de design, tipografia e teoria das cores',
            '3º e 4º anos: Design editorial, identidade visual e web design',
            'Atividades práticas: Desenvolvimento de portfólio e estágio supervisionado',
          ]),
          const SizedBox(height: 16),
          _buildLink(
              'Clique aqui para saber mais sobre o curso de Design Gráfico na UniMetrocamp',
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
        _buildNotaCard(ano: '2023', vagas: 80, notaDeCorte: 680.0),
        _buildNotaCard(ano: '2022', vagas: 85, notaDeCorte: 670.2),
        _buildNotaCard(ano: '2021', vagas: 80, notaDeCorte: 665.8),
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
              'Design gráfico $ano',
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
          imagePath: 'lib/assets/Unimetrocamp.png',
          rating: 4.8,
          recommendationText:
              '91% dos alunos que avaliaram recomendam este curso',
        ),
        const SizedBox(height: 16),
        StudentReview(
          name: 'Carlos Almeida',
          rating: 4.7,
          review: 'Excelente curso com foco em empreendedorismo e gestão...',
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
            'Outros cursos oferecidos pela UniMetrocamp',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),
          _buildCourseSection('Faculdade de Comunicação e Artes', [
            'Publicidade e Propaganda',
            'Jornalismo',
            'Relações Públicas',
          ]),
          const SizedBox(height: 16),
          _buildCourseSection('Faculdade de Engenharia', [
            'Engenharia de Produção',
            'Engenharia Mecânica',
            'Engenharia Civil',
          ]),
          const SizedBox(height: 16),
          _buildCourseSection('Faculdade de Saúde', [
            'Fisioterapia',
            'Biomedicina',
            'Psicologia',
          ]),
          const SizedBox(height: 16),
          _buildLink('Veja a lista completa de cursos da UniMetrocamp', '#'),
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
  const SobreUniversidadeTab({Key? key}) : super(key: key);

  // Método para abrir o link no Google Maps
  void _openMapLocation() async {
    const url =
        'https://www.google.com/maps/place/Centro+Universitário+UniMetrocamp+-+Wyden/@-22.9085664,-47.078484,17z/data=!4m10!1m2!2m1!1sunimetrocamp!3m6!1s0x94c8cf4d86d44237:0xa0fc793d797a7e34!8m2!3d-22.90879!4d-47.075944!15sCgx1bmltZXRyb2NhbXCSARJwcml2YXRlX3VuaXZlcnNpdHngAQA!16s%2Fg%2F121y0gtq?entry=ttu&g_ep=EgoyMDI0MTAyMC4xIKXMDSoASAFQAw%3D%3D'; // Link da localização da Unimetrocamp no Google Maps
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
        title: const Text('Faculdade Unimetrocamp Wyden'),
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
                    Image.asset(
                      'lib/assets/Unimetrocamp_map.png', // Certifique-se de ter essa imagem
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Universidade Presbiteriana Unimetrocamp\nInstituição de ensino superior privada',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(Icons.location_on, color: Colors.purple),
                        SizedBox(width: 4.0),
                        Expanded(
                          child: Text(
                            'Rua Dr. Sales de Oliveira, 1661 - Vila Industrial, Campinas - SP',
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
                          '• 10Km de distância',
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
              'A Faculdade Unimetrocamp Wyden faz parte da rede de ensino Wyden, '
              'oferecendo cursos de graduação e pós-graduação em diversas áreas, como '
              'saúde, tecnologia, negócios e muito mais. A faculdade é conhecida por '
              'sua infraestrutura moderna e parcerias que promovem a integração entre '
              'teoria e prática no mercado de trabalho.',
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
