import 'package:flutter/material.dart';
import 'package:uniconnecta/components/components.dart';
import 'package:uniconnecta/pages/convest.dart';
import 'package:uniconnecta/components/class_of_model.dart'; // Import para o modelo Universidade
import 'package:uniconnecta/components/university_header.dart';
import 'package:uniconnecta/components/favorites_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

class Mackenzie extends StatelessWidget {
  final String title;
  final String subtitle;

  Mackenzie({Key? key, required this.title, required this.subtitle})
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
                  logoUrl: 'lib/assets/mackenzie.png', // Caminho da logo
                );

                return UniversityHeader(
                  universityOrEntranceExamName: title,
                  courseName: subtitle,
                  rating: 4.8,
                  locationType: 'Presencial',
                  imagePath: 'lib/assets/mackenzie.png',
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
          title: 'Vestibular Mackenzie',
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
            'Sobre o curso de Administração',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),
          _buildSection('Coordenação e Professores', [
            'Coordenador: Prof. Dr. Eduardo Nascimento',
            'Professora: Dra. Camila Tavares',
            'Professor: Dr. Carlos Silva',
          ]),
          const SizedBox(height: 16),
          _buildSection('Estrutura do Curso', [
            '1º e 2º anos: Fundamentos de economia, marketing e finanças',
            '3º e 4º anos: Gestão empresarial, estratégia e empreendedorismo',
            'Atividades práticas: Simulações de negócios e projetos integradores',
          ]),
          const SizedBox(height: 16),
          _buildLink(
              'Mais detalhes sobre o curso de Administração na Mackenzie', '#'),
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
              'Administração $ano',
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
          imagePath: 'lib/assets/mackenzie.png',
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
            'Outros cursos oferecidos pela Mackenzie',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),
          _buildCourseSection('Faculdade de Ciências Sociais Aplicadas', [
            'Direito',
            'Ciências Contábeis',
            'Economia',
          ]),
          const SizedBox(height: 16),
          _buildCourseSection('Faculdade de Arquitetura e Urbanismo', [
            'Arquitetura',
            'Design de Interiores',
            'Urbanismo',
          ]),
          const SizedBox(height: 16),
          _buildCourseSection('Faculdade de Engenharia', [
            'Engenharia Civil',
            'Engenharia Elétrica',
            'Engenharia de Produção',
          ]),
          const SizedBox(height: 16),
          _buildLink('Veja a lista completa de cursos da Mackenzie', '#'),
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

  // Método para abrir o link do Google Maps
  void _openMapLocation() async {
    const url =
        'https://www.google.com/maps/place/Universidade+Presbiteriana+Mackenzie,+Campus+Campinas/@-22.9085651,-47.0965086,14z/data=!4m10!1m2!2m1!1smackenzie!3m6!1s0x94c8c6052e176699:0x9c79272dff8f8874!8m2!3d-22.8855527!4d-47.0685064!15sCgltYWNrZW56aWWSAQp1bml2ZXJzaXR54AEA!16s%2Fg%2F1tp097g6?entry=ttu&g_ep=EgoyMDI0MTAyMC4xIKXMDSoASAFQAw%3D%3D'; // Link da localização da Mackenzie no Google Maps
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
        title: const Text('Universidade Presbiteriana Mackenzie'),
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
                      'lib/assets/mackenzie_map.png', // Certifique-se de ter essa imagem
                      fit: BoxFit.cover,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Universidade Presbiteriana Mackenzie\nInstituição de ensino superior privada',
                        style: TextStyle(fontSize: 14.0),
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
                color: Colors.purple,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'A Universidade Presbiteriana Mackenzie é uma das mais tradicionais do Brasil, com forte atuação nas áreas de direito, engenharia e administração, além de diversos outros cursos de graduação e pós-graduação.',
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
      ),
    );
  }
}
