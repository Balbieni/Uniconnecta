import 'package:flutter/material.dart';
import 'package:uniconnecta/components/components.dart';
import 'package:url_launcher/url_launcher.dart';
import 'pages.dart';

class Enem extends StatelessWidget {
  final ValueNotifier<bool> isFavoritedNotifier = ValueNotifier<bool>(false);

  final String title;
  final String subtitle;

  Enem({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        body: Column(
          children: [
            UniversityHeader(
              universityOrEntranceExamName: 'Unicamp',
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
          // Card para download do edital
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Edital Convest 2024',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Ação de download do edital
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.purple,
                      ),
                      child: const Text(
                        'Baixar',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Seção de Edital Simplificado
          const Text(
            'Edital simplificado',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),

          // Conteúdo do edital simplificado
          const Text(
            'Informações Gerais:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildListItem('Data de realização do exame.'),
          _buildListItem('Locais de prova.'),
          _buildListItem('Horário de abertura e fechamento dos portões.'),

          const SizedBox(height: 16),
          const Text(
            'Requisitos de Inscrição:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildListItem('Documentação necessária.'),
          _buildListItem('Prazo de inscrição.'),
          _buildListItem('Procedimentos para inscrição online ou presencial.'),
          _buildListItem('Taxa de inscrição e possíveis isenções.'),

          const SizedBox(height: 16),
          const Text(
            'Etapas do Processo Seletivo:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildListItem('Provas (datas, horários, disciplinas).'),
          _buildListItem(
              'Formatos das provas (objetivas, dissertativas, redação).'),
          _buildListItem('Critérios de correção e avaliação.'),
          _buildListItem('Possíveis etapas eliminatórias.'),

          const SizedBox(height: 16),
          const Text(
            'Conteúdo Programático:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildListItem('Matérias abordadas em cada disciplina.'),
          _buildListItem('Bibliografia recomendada.'),

          const SizedBox(height: 16),
          const Text(
            'Política de Cotas e Ações Afirmativas (se aplicável):',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildListItem('Percentual de vagas reservadas para cotistas.'),
          _buildListItem('Documentação necessária para comprovação de cotas.'),

          const SizedBox(height: 16),
          const Text(
            'Divulgação de Resultados:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildListItem('Data prevista para divulgação dos resultados.'),
          _buildListItem(
              'Formas de acesso aos resultados (online, presencial).'),

          const SizedBox(height: 16),
          const Text(
            'Matrícula e Documentação:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildListItem('Documentação necessária para matrícula.'),
          _buildListItem('Prazo para realização da matrícula.'),
          _buildListItem('Procedimentos para matrícula presencial ou online.'),

          const SizedBox(height: 16),
          const Text(
            'Disposições Gerais:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildListItem('Informações adicionais importantes.'),
          _buildListItem('Recomendações aos candidatos.'),
          _buildListItem('Canais de contato para esclarecimento de dúvidas.'),
        ],
      ),
    );
  }

  // Método auxiliar para criar itens de lista
  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card para download do edital
          const Text(
            'O que estudar para a Convest?',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 20),
          // Seção de introdução
          _buildSectionTitle('A estrutura da prova da Unicamp'),
          _buildParagraph(
              'Para iniciar os estudos, é preciso ter em mente que o vestibular da Unicamp avalia a capacidade do candidato de fazer conexões entre as matérias, a chamada interdisciplinaridade.'),
          _buildParagraph(
              'Uma dica importante para encarar desafios como esse é pensar macro e fazer ligações entre as informações de várias matérias sobre um mesmo assunto.'),

          // Exemplo interdisciplinaridade
          _buildParagraph(
              'Por exemplo, a questão da violência no Brasil pode ser pensada de forma histórica, sociológica e até matemática. Se você pensar de forma abrangente o assunto, terá mais chances de ir bem.'),

          const SizedBox(height: 20),

          // Seção de disciplinas
          _buildSectionTitle('As disciplinas do vestibular da Unicamp'),
          _buildParagraph(
              'O vestibular da Unicamp aborda temas de conhecimentos gerais que são estudados no Ensino Médio. Você deverá estar preparado para lidar com questões de matemática, português, física, biologia, química, geografia, história, filosofia e sociologia.'),

          _buildParagraph('Vamos ver algumas dicas de cada disciplina!'),

          const SizedBox(height: 20),

          // Seção de Matemática
          _buildSectionTitle('Matemática'),
          _buildParagraph(
              'Na prova de matemática você precisa mostrar que é capaz de identificar um conhecimento crítico e integrado da disciplina. Deve estar atento às leituras dos enunciados, elaborar cálculos, usar corretamente os conceitos e as unidades matemáticas.'),
          _buildParagraph(
              'A prova exige que o candidato saiba resolver problemas matemáticos relacionados ao dia-a-dia. Para isso, as questões cobram conhecimentos em:'),
          _buildBulletList([
            'Conjuntos numéricos (números reais, naturais e sequências numéricas)',
            'Funções e gráficos (função linear, inversa, equações, etc.)',
            'Probabilidade (princípios de contagem, binômio de Newton)',
            'Geometria plana e espacial (congruências, quadriláteros notáveis)',
            'Trigonometria (medida de ângulos, lei dos senos e cossenos)',
            'Logaritmos e exponenciais (potências, função logarítmica)'
          ]),

          const SizedBox(height: 20),

          // Seção de Português
          _buildSectionTitle('Português'),
          _buildParagraph(
              'Na prova de português e literatura, você precisa interpretar textos, formular hipóteses e estabelecer relações, analisar estruturas linguísticas e estar atento às regras gramaticais.'),
          _buildParagraph(
              'O aluno deve estudar assuntos como gêneros discursivos, variações linguísticas, sintaxe e morfologia da língua portuguesa.'),
          _buildParagraph(
              'Nas questões de literatura, espera-se que o candidato tenha domínio de interpretação textual e conhecimento da cultura expressa nos livros indicados no edital.'),

          const SizedBox(height: 20),

          // Seção de Física
          _buildSectionTitle('Física'),
          _buildParagraph(
              'Para ter um bom resultado na prova de física, o candidato precisa demonstrar sua capacidade de raciocínio matemático e conhecimento dos conceitos básicos de física.'),
          _buildBulletList([
            'Fundamentos da física',
            'Mecânica (leis de Newton, força de atrito)',
            'Calorimetria e termodinâmica',
            'Óptica e ondas (espelhos, lentes, ondas sonoras)',
            'Eletricidade e magnetismo (forças eletromagnéticas)',
            'Noções de física moderna (átomos, partículas elementares)'
          ]),

          const SizedBox(height: 20),

          // Seção de Biologia
          _buildSectionTitle('Biologia'),
          _buildParagraph(
              'O exame de biologia exige conhecimento do conteúdo ensinado no Ensino Médio. É preciso atenção para interpretar os enunciados, gráficos e imagens das questões.'),
          _buildBulletList([
            'Bases moleculares (componentes bioquímicos das células)',
            'Hereditariedade (código genético, manipulação do DNA)',
            'Origem e evolução da vida',
            'Saúde humana e meio ambiente',
            'Diversidade e função biológica'
          ]),

          const SizedBox(height: 20),

          // Seção de Química
          _buildSectionTitle('Química'),
          _buildParagraph(
              'Em química, o estudante deve demonstrar sua capacidade de observar e descrever fenômenos químicos, conhecer informações sobre transformações e desenvolvimento científico.'),
          _buildBulletList([
            'Materiais (massas atômicas, fórmulas)',
            'Gases (leis de Boyle, misturas gasosas)',
            'Líquidos e sólidos (modelo iônico, covalente)',
            'Eletroquímica (oxidação, eletrólise)',
            'Química de compostos orgânicos'
          ]),

          const SizedBox(height: 20),

          // Seção de Geografia, História, Sociologia e Filosofia
          _buildSectionTitle('Geografia, história, sociologia e filosofia'),
          _buildParagraph(
              'A prova da Unicamp aborda temas dessas disciplinas integrados a questões de história e geografia, exigindo uma visão global da realidade e interpretação de gráficos, mapas e tabelas.'),
          _buildBulletList([
            'Fusos horários, projeção cartográfica',
            'Questão ambiental no Brasil',
            'Geopolítica, globalização, economia regional',
            'História do Brasil e do mundo contemporâneo',
            'Períodos históricos como antiguidade, idade média, modernidade'
          ]),

          const SizedBox(height: 20),

          // Seção de Redação
          _buildSectionTitle('Unicamp: redação'),
          _buildParagraph(
              'A segunda fase do vestibular inclui uma redação, que visa conhecer as habilidades discursivas dos candidatos. A avaliação considera pertinência ao tema, qualidade de leitura e aplicação correta das regras gramaticais.'),

          const SizedBox(height: 20),

          // Seção de Livros da Unicamp
          _buildSectionTitle('Livros da Unicamp'),
          _buildParagraph(
              'A prova de literatura exige a leitura de livros indicados no edital. Os gêneros variam entre poesia, teatro, conto e romance. Aqui estão os livros indicados:'),
          _buildBulletList([
            '“Sonetos”, de Luís de Camões',
            '“Poemas Negros”, de Jorge de Lima',
            '“A teus pés”, de Ana Cristina Cesar',
            '“O Bem-amado”, de Dias Gomes',
            '“Coração, Cabeça e Estômago”, de Camilo Castelo Branco',
            '“História do Cerco de Lisboa”, de José Saramago'
          ]),

          const SizedBox(height: 20),

          // Seção sobre isenção da taxa de inscrição
          _buildSectionTitle('Como solicitar a isenção da taxa de inscrição?'),
          _buildParagraph(
              'Para solicitar a isenção, o candidato deve atender aos requisitos da Unicamp. A isenção é oferecida para alunos de baixa renda, funcionários da Unicamp e candidatos de licenciatura noturna.'),
        ],
      ),
    );
  }

  // Método auxiliar para criar títulos de seção
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.purple,
      ),
    );
  }

  // Método auxiliar para criar parágrafos de texto
  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.justify,
      ),
    );
  }

  // Método auxiliar para criar listas com bullets
  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => _buildListItem(item)).toList(),
    );
  }

  // Método para um item de lista
  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class ObrasLiterariasTab extends StatelessWidget {
  const ObrasLiterariasTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Obras literárias',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Livros da Unicamp\n'
            'Como vimos nos tópicos anteriores, a prova de literatura da Unicamp exige a leitura de alguns livros pré-selecionados e informados no edital. '
            'Os gêneros textuais desses livros podem ser diferentes, como poesia, teatro, conto, romance, etc.\n',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
          const Text(
            'Os livros e contos escolhidos para o vestibular da Unicamp são:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildBulletList([
            '“Sonetos”, de Luís de Camões',
            '“Poemas Negros”, de Jorge de Lima',
            '“A teus pés”, de Ana Cristina Cesar',
            '“O Bem-amado”, de Dias Gomes',
            '“Coração, Cabeça e Estômago”, de Camilo Castelo Branco',
            '“Caminhos Cruzados”, de Érico Veríssimo',
            '“História do Cerco de Lisboa”, de José Saramago',
            '“Quarto de Despejo”, de Carolina Maria de Jesus',
            '“Sermões”, do Padre Antônio Vieira',
            '“O Espelho”, de Machado de Assis',
            '“Amor”, do livro Laços de Família, de Clarice Lispector',
            '“A Hora e a Vez de Augusto Matraga”, do livro Sagarana, de Guimarães Rosa',
          ]),
          const SizedBox(height: 20),
          const Text(
            'Confira a matéria original em:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _launchURL(
              'https://blog.stoodi.com.br/blog/vestibular/unicamp/#::text=Como%20já%20vimos,%20o%20vestibular,%20história,%20filosofia%20e%20sociologia.',
            ),
            child: const Text(
              'https://blog.stoodi.com.br/blog/vestibular/unicamp/',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Método auxiliar para abrir o link no navegador
  static void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Método auxiliar para criar listas com bullets
  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => _buildListItem(item)).toList(),
    );
  }

  // Método para um item de lista
  Widget _buildListItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class ProvasTab extends StatelessWidget {
  const ProvasTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Provas',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),
          _buildSection(
            title: 'Primeira fase',
            links: [
              LinkItem(text: 'Provas O e Z', url: '#'),
              LinkItem(text: 'Provas R e Y', url: '#'),
              LinkItem(text: 'Provas S e X', url: '#'),
              LinkItem(text: 'Provas T e W', url: '#'),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            title: 'Segunda fase',
            links: [
              LinkItem(
                  text: 'Prova da área de Ciências Exatas / Tecnológicos',
                  url: '#'),
              LinkItem(
                  text: 'Prova da área de Ciências Biológicas / Saúde',
                  url: '#'),
              LinkItem(
                  text: 'Prova da área de Ciências Humanas / Artes', url: '#'),
              LinkItem(
                  text:
                      'Prova de Redação, Língua Portuguesa e de Literaturas de Língua Portuguesa, Interdisciplinares com Língua Inglesa e Interdisciplinares de Ciências da Natureza',
                  url: '#'),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            title: 'Habilidades específicas',
            links: [
              LinkItem(text: 'Arquitetura e Urbanismo – parte 1', url: '#'),
              LinkItem(
                  text: 'Arquitetura e Urbanismo – partes 2 e 3', url: '#'),
              LinkItem(text: 'Artes Cênicas', url: '#'),
              LinkItem(text: 'Artes Visuais – História da arte', url: '#'),
              LinkItem(text: 'Artes Visuais – Expressão plástica', url: '#'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required List<LinkItem> links}) {
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
              children: links.map((link) => _buildLink(link)).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLink(LinkItem linkItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: GestureDetector(
        onTap: () => _launchURL(linkItem.url),
        child: Text(
          linkItem.text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  // Método auxiliar para abrir o link no navegador
  static void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class LinkItem {
  final String text;
  final String url;

  LinkItem({required this.text, required this.url});
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Conheça a Equipe Comvest',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),
          _buildSection(
              'Coordenadoria Executiva dos Vestibulares e de Programas Educacionais',
              [
                'Diretor: José Alves de Freitas Neto',
                'Diretora Adjunta: Ana Maria Fonseca de Almeida',
                'Coordenadora Acadêmica: Márcia Rodrigues de Souza Mendonça',
                'Coordenador de Logística: Kleber Roberto Pirota',
                'Coordenador de Pesquisa: Rafael Pimentel Maia',
              ]),
          const SizedBox(height: 16),
          _buildSection('Câmara Deliberativa do Vestibular', [
            'Presidente: Ivan Felizardo Contrera Toro',
            'Diretor da Comvest: José Alves de Freitas Neto',
          ]),
          const SizedBox(height: 16),
          _buildLink(
              'Veja aqui o calendário de reuniões da Câmara Deliberativa 2024',
              '#'),
          const SizedBox(height: 16),
          _buildSection('Representantes de Cursos', [
            'Administração: Luiz Eduardo Gaio',
            'Administração Pública: André Luiz Sica de Campos',
            'Arquitetura e Urbanismo: Sidney Piochi Bernardini',
            'Artes Cênicas: Wanderley Martins',
            'Artes Visuais: Edson do Prado Pfützenreuter',
            'Ciência da Computação: Rafael Crivellari Saliba Schouery',
            'Ciências Biológicas: Aline Mara dos Santos',
            'Ciências Econômicas: Antonio Carlos Diegues Júnior',
            'Ciências do Esporte: Eliana de Toledo Ishibashi',
            'Ciências Sociais: Christiano Key Tambascia',
            'Comunicação Social – Midialogia: Noel dos Santos Carvalho',
            'Dança: Daniela Gatti',
            'Educação Física: Laurita Marconi Schiavon',
            'Enfermagem: Débora de Souza Santos',
            'Engenharia Agrícola: Rafael Augustus de Oliveira',
            'Engenharia Civil: Paulo Albuquerque',
            'Engenharia de Alimentos: Luiz Henrique Fasolin',
            'Engenharia de Computação: Lucas Francisco Wanner',
            'Engenharia de Controle e Automação: Rogério Gonçalves dos Santos',
            'Engenharia de Manufatura: Ricardo Floriano',
            'Engenharia de Produção: Paulo Sérgio de Arruda Ignácio',
            'Engenharia Elétrica: Daniel Dotta',
            'Engenharia Física: Felippe Alexandre Silva Barbosa',
            'Engenharia Mecânica: Caio Rufino',
            'Engenharia Química: Lucimara Gaziola de La Torre',
            'Estatística: Guilherme Vieira Nunes Ludwig',
            'Estudos Literários: Mário Luiz Frungillo',
            'Faculdade de Ciências Aplicadas: Sandra Francisca Bezerra Gemma',
            'Faculdade de Tecnologia: Felippe Benavente Canteras',
            'Farmácia: Paulo Cesar Pires Rosa',
            'Filosofia: Taisa Helena Pascale Palhares',
            'Física: Sandro Guedes de Oliveira',
            'Fonoaudiologia: Thiago Oliveira da Motta Sampaio',
            'Geografia: Aline Pascoalino',
            'Geologia: Wagner da Silva Amaral',
            'História: Rui Luis Rodrigues',
            'Letras: Karin Camolesi Vivanco',
            'Licenciaturas: André Luiz Correia Gonçalves de Oliveira',
            'Linguística: Ana Cláudia Fernandes Ferreira',
            'Matemática: Gabriel Ponce',
            'Matemática Aplicada e Computacional: Roberto Andreani',
            'Medicina: Simone Appenzeller',
            'Música: Carlos Fernando Fiorini',
            'Nutrição: Rosangela Maria Neves Bezerra',
            'Odontologia: Carolina Steiner Oliveira Alarcon',
            'Pedagogia: Lilian Cristine Ribeiro Nascimento',
            'Química: Raphael Nagao de Sousa',
          ]),
          const SizedBox(height: 16),
          _buildLink('TABELA EM PDF', '#'),
          const SizedBox(height: 16),
          _buildSection('Representantes do Ensino Secundário', [
            'Colégio Técnico de Campinas: Célia Regina Duarte',
            'Colégio Técnico de Limeira: Wellington de Oliveira',
          ]),
          const SizedBox(height: 16),
          _buildSection('Representantes da Comvest', [
            'Ana Maria Fonseca de Almeida',
            'Kleber Roberto Pirota',
            'Márcia Mendonça',
            'Rafael Pimentel Maia',
          ]),
          const SizedBox(height: 16),
          _buildSection('Representante da Reitoria', [
            'Elinton Adami Chaim',
          ]),
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

  // Função para abrir links no navegador
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
