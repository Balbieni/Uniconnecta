import 'package:flutter/material.dart';
import 'package:uniconnecta/components/components.dart';
import 'package:uniconnecta/pages/convest.dart';
import 'package:uniconnecta/components/class_of_model.dart'; // Import para o modelo Universidade
import 'package:uniconnecta/components/university_header.dart';
import 'package:uniconnecta/components/favorites_model.dart';
import 'package:provider/provider.dart';

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
            onTap: () {}, // Implementar lógica de abrir URL
          ),
        ],
      ),
    );
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
    return Center(
      child: Column(
        children: const [
          Text(
            'Outros cursos serão exibidos aqui.',
            style: TextStyle(fontSize: 16.0, color: Colors.purple),
          ),
          SizedBox(height: 20),
          Text(
            'texto imenso que eu vou colocar',
            style: TextStyle(fontSize: 14.0, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class SobreUniversidadeTab extends StatelessWidget {
  const SobreUniversidadeTab({Key? key}) : super(key: key);

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
                color: Colors.purple),
          ),
          const SizedBox(height: 8.0),
          GestureDetector(
            onTap: () {}, // Implementar lógica de abrir mapas
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/unicamp_map.png',
                    fit: BoxFit.cover,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Universidade Estadual de Campinas\nInstituição de ensino superior',
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
                color: Colors.purple),
          ),
          const SizedBox(height: 8.0),
          const Text(
            'A Unicamp responde por 8% da pesquisa acadêmica no Brasil, 12% da pós-graduação nacional...',
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
