import 'package:flutter/material.dart';
import 'package:uniconnecta/components/components.dart';
import 'pages.dart';

class Unicamp extends StatelessWidget {
  final ValueNotifier<bool> isFavoritedNotifier = ValueNotifier<bool>(false);

  Unicamp({Key? key}) : super(key: key);

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
                  VestibularesTab(),
                  SobreCursoTab(), // Pular esse conteúdo ao implementar
                  NotasDeCorteTab(),
                  AvaliacoesTab(),
                  OutrosCursosTab(),
                  SobreUniversidadeTab(),
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
            'Como é o curso de Medicina? \n O curso de Medicina tem como principal objetivo a restauração e a manutenção da saúde, investindo no tratamento e na prevenção de doenças. Além disso, oferece conhecimentos para que o aluno possa promover a saúde e o bem-estar dos indivíduos, desde a infância até a maturidade.\n Nos anos iniciais do curso de Medicina o aluno aprende fundamentos teóricos da área, como Anatomia, Bioquímica e Imunologia. Nos anos seguintes, o curso possui matérias que dão ênfase no estudo de doenças e como elas se manifestam no corpo humano, como Imunologia, Patologia e Fisiopatologia.\n O que faz um médico?\n O médico é o profissional responsável pela assistência à saúde das pessoas. Ele atua em diagnóstico, tratamento e prevenção de doenças e lesões. Além disso, é responsável por promover a saúde e o bem-estar dos pacientes, realizando exames, prescrevendo medicamentos e orientando sobre cuidados de saúde e prevenção de doenças. Também pode atuar em áreas de pesquisa, educação e gestão de serviços de saúde.\n Quanto tempo dura o curso de Medicina? \n O curso de Medicina é oferecido na modalidade de bacharelado e possui duração de 6 anos, sendo que 2 anos finais são destinados a residência médica. \n É um curso da área de Ciências Biológicas.\n  O que se estuda no curso de Medicina? \n O curso de Medicina, como você verá ao longo do texto, é dividido em duas grandes etapas: os ciclos básico e clínico. \n No ciclo básico, os alunos estudam disciplinas fundamentais como anatomia, fisiologia, bioquímica e farmacologia. Essa fase é essencial para construir uma base sólida de conhecimentos sobre o corpo humano e suas funções. Já no ciclo clínico, o foco se desloca para a prática médica em hospitais e clínicas, onde os estudantes têm a oportunidade de interagir diretamente com pacientes sob supervisão, aprendendo a aplicar seus conhecimentos de maneira prática e empática. Veja algumas disciplinas que compõem a grade curricular básica do curso de Medicina:Fisiologia, Neuroanatomia, Biologia Molecular e Celular, Histologia, Embriologia, Patologia Geral, Imunologia, Epidemiologia Analítica, Genética Clínica, Medicina Legal.\n  + O que se estuda em Medicina: grade curricular e disciplinas \n 1. Grade Fundamental do Curso de Medicina Nos dois primeiros anos do curso de Medicina, o aluno aprende os fundamentos teóricos da carreira de médico. Entre as principais disciplinas estudadas podemos citar: Anatomia, Bioquímica, Biologia, Biofísica, Fisiologia,Farmacologia, Imunologia, Microbiologia, Patologia, Histologia ,Embriologia, Genética Durante esta etapa do curso, a Anatomia é estudada tanto do ponto de vista teórico (livros, textos, animações 3D, figuras, etc.). Nos laboratórios de Anatomia o aluno estuda o corpo humano através da manipulação real de cadáveres e peças cirúrgicas. Também são realizados alguns experimentos químicos e biológicos com microscópio. \n 2. Etapa Pré-Clínica do Curso de Medicina Durante esta fase do curso de Medicina, o principal enfoque são as doenças e como elas se manifestam no corpo humano. A principal disciplina estudada durante esta fase é a Epidemiologia (estudo das doenças e epidemias). O aluno estuda profundamente as diversas famílias de doenças, sua evolução, os efeitos no corpo humano e também as melhores maneiras conhecidas pela Medicina de combatê-las, preveni-las e curá-las. Esta etapa do curso de medicina, que em geral, também dura 2 anos. \n 3. Etapa Clínica do Curso de Medicina Durante esta etapa do curso de Medicina, além de estudar na faculdade, o aluno passa a atuar dentro dos hospitais fazendo plantão, sempre sob a supervisão e orientação de médicos formados. Nestes plantões, os alunos ajudam no atendimento diário dos pacientes e realizam diversas tarefas de manutenção do hospital, tendo contato com especialidades clínicas como: Hematologia, Urologia, Endocrinologia, Cardiologia, Cirurgia, Traumatologia, etc.',
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

class NotasDeCorteTab extends StatelessWidget {
  const NotasDeCorteTab({Key? key}) : super(key: key);

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

class AvaliacoesTab extends StatelessWidget {
  const AvaliacoesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Avaliações serão exibidas aqui.'),
    );
  }
}

class OutrosCursosTab extends StatelessWidget {
  const OutrosCursosTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Outros cursos serão exibidos aqui.'),
    );
  }
}

class SobreUniversidadeTab extends StatelessWidget {
  const SobreUniversidadeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Sobre a universidade será exibido aqui.'),
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
