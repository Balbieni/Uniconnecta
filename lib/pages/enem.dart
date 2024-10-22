import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uniconnecta/components/favorites_model.dart';
import 'package:uniconnecta/components/class_of_model.dart';
import 'package:uniconnecta/pages/home_screen.dart';
import 'package:uniconnecta/pages/search_page.dart';
import 'package:uniconnecta/pages/news_screen.dart';
import 'package:uniconnecta/pages/favorites_screen.dart';
import 'package:uniconnecta/pages/profile_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uniconnecta/components/entrance_exam_header.dart';

class Enem extends StatefulWidget {
  final String title;
  final String subtitle;

  Enem({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  _EnemState createState() => _EnemState();
}

class _EnemState extends State<Enem> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    SearchPage(),
    NewsScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        body: _selectedIndex == 0
            ? Column(
                children: [
                  // Usando o Consumer para atualizar o estado de favoritos
                  Consumer<FavoritesModel>(
                    builder: (context, favoritesModel, child) {
                      // Criar o objeto Vestibular com as informações do Enem
                      final enem = Vestibular(
                        nome: widget.title,
                        curso: widget.subtitle,
                        avaliacao: 4.5, // Avaliação fixa como exemplo
                        modalidade: 'Presencial',
                        logoUrl: 'lib/assets/enem.png', // Logo do Enem
                      );

                      // Verifica se o Enem está nos favoritos
                      final isFavorited =
                          favoritesModel.isVestibularFavorite(enem);

                      return VestibularHeader(
                        vestibularName: widget.title,
                        courseName: widget.subtitle,
                        rating: 4.5,
                        imagePath: 'lib/assets/enem.png', // Caminho da imagem
                        vestibular: enem, // Passa o objeto Enem
                        isFavorited: isFavorited,
                        onFavoritePressed: () {
                          if (isFavorited) {
                            favoritesModel.removeVestibularFavorite(enem);
                          } else {
                            favoritesModel.addVestibularFavorite(enem);
                          }
                        },
                      );
                    },
                  ),
                  const TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.purple,
                    labelColor: Colors.purple,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(child: Text('Vestibulares')),
                      Tab(child: Text('Edital')),
                      Tab(child: Text('Conteudos')),
                      Tab(child: Text('Avaliações')),
                      Tab(child: Text('Provas Anteriores')),
                      Tab(child: Text('Sobre o vestibular')),
                    ],
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        InscrevaSeTab(), // Abas personalizadas para o Enem
                        EditalTab(),
                        ConteudosTab(),
                        ObrasLiterariasTab(),
                        ProvasAnterioresTab(),
                        SobreOVestibularTab(),
                      ],
                    ),
                  ),
                ],
              )
            : _pages[
                _selectedIndex], // Mostra a página selecionada fora do TabBarView
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Início',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Buscar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'Notícias',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favoritos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

class InscrevaSeTab extends StatelessWidget {
  const InscrevaSeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildExamCard(
            title: 'Enem',
            description:
                'Período de inscrições será de 27 de maio a 7 de junho. Provas serão aplicadas nos dias 3 e 10 de novembro em todo o Brasil.',
            onPressedInscrever: () {
              // Ação ao clicar no link Inscrever-se
            },
            onPressedPagina: () {
              // Ação ao clicar no link Página
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExamCard({
    required String title,
    required String description,
    required VoidCallback onPressedInscrever,
    required VoidCallback onPressedPagina,
  }) {
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
            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onPressedInscrever,
                  child: const Text(
                    'Inscrever-se',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onPressedPagina,
                  child: const Text(
                    'Página',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
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

class EditalTab extends StatelessWidget {
  const EditalTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card para download do edital ENEM
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
                    'Edital ENEM 2024',
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
                        // Ação de download do edital do ENEM
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: Colors.purple, // Cor tema do ENEM
                      ),
                      child: const Text(
                        'Baixar Edital',
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
            'Edital simplificado do ENEM',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple, // Cor tema do ENEM
            ),
          ),
          const SizedBox(height: 16),

          // Conteúdo do edital simplificado
          const Text(
            'Informações Gerais:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildListItem('Datas das provas do ENEM: 3 e 10 de novembro.'),
          _buildListItem(
              'Locais de prova disponíveis no cartão de confirmação.'),
          _buildListItem('Horários de abertura e fechamento dos portões.'),

          const SizedBox(height: 16),
          const Text(
            'Requisitos de Inscrição:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildListItem('Documentação necessária para inscrição.'),
          _buildListItem('Prazo de inscrição: de 27 de maio a 7 de junho.'),
          _buildListItem('Procedimentos para inscrição online.'),
          _buildListItem('Taxa de inscrição e possíveis isenções para o ENEM.'),

          const SizedBox(height: 16),
          const Text(
            'Etapas do Processo Seletivo:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildListItem(
              'Provas (linguagens, matemática, ciências da natureza, redação).'),
          _buildListItem('Formatos das provas (objetivas e redação).'),
          _buildListItem('Critérios de correção e avaliação no ENEM.'),

          const SizedBox(height: 16),
          const Text(
            'Conteúdo Programático:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildListItem('Matérias abordadas em cada área de conhecimento.'),
          _buildListItem('Bibliografia sugerida para o ENEM.'),

          const SizedBox(height: 16),
          const Text(
            'Política de Cotas e Ações Afirmativas:',
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
          _buildListItem(
              'Data prevista para divulgação dos resultados do ENEM.'),
          _buildListItem(
              'Formas de acesso aos resultados (online, presencial).'),

          const SizedBox(height: 16),
          const Text(
            'Matrícula e Documentação:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildListItem('Documentação necessária para matrícula.'),
          _buildListItem('Prazo para realização da matrícula após o ENEM.'),
          _buildListItem('Procedimentos para matrícula online.'),

          const SizedBox(height: 16),
          const Text(
            'Disposições Gerais:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildListItem(
              'Informações adicionais importantes para os candidatos.'),
          _buildListItem(
              'Recomendações e orientações para o dia da prova do ENEM.'),
          _buildListItem('Canais de contato para dúvidas sobre o ENEM.'),
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
          const Text(
            'O que estudar para o ENEM?',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple, // Cor temática do ENEM
            ),
          ),
          const SizedBox(height: 20),

          // Introdução
          _buildSectionTitle('Estrutura da prova do ENEM'),
          _buildParagraph(
              'O ENEM é composto por quatro áreas de conhecimento: Ciências da Natureza, Ciências Humanas, Linguagens e Matemática. Além disso, há a redação, que exige a produção de um texto dissertativo-argumentativo.'),
          _buildParagraph(
              'A prova valoriza a capacidade de interpretação, resolução de problemas práticos e aplicação do conhecimento em situações do dia a dia.'),

          const SizedBox(height: 20),

          // Seção de Ciências da Natureza
          _buildSectionTitle('Ciências da Natureza'),
          _buildParagraph(
              'Nesta área, são abordados temas de biologia, química e física, com questões que integram essas disciplinas para avaliar a compreensão dos fenômenos naturais e suas aplicações.'),
          _buildBulletList([
            'Física: Leis de Newton, eletricidade, óptica e termodinâmica.',
            'Química: Tabela periódica, reações químicas, equilíbrio químico e eletroquímica.',
            'Biologia: Ecologia, genética, evolução e biotecnologia.'
          ]),

          const SizedBox(height: 20),

          // Seção de Ciências Humanas
          _buildSectionTitle('Ciências Humanas'),
          _buildParagraph(
              'A área de Ciências Humanas engloba história, geografia, filosofia e sociologia. O enfoque é a interpretação de documentos, mapas e textos relacionados a aspectos sociais e políticos.'),
          _buildBulletList([
            'História: Brasil Colônia, ditadura militar, revoluções e conflitos mundiais.',
            'Geografia: Meio ambiente, urbanização, globalização e geopolítica.',
            'Filosofia: Ética, democracia e teorias sociais.',
            'Sociologia: Estratificação social, movimentos sociais e cidadania.'
          ]),

          const SizedBox(height: 20),

          // Seção de Linguagens
          _buildSectionTitle('Linguagens'),
          _buildParagraph(
              'Esta área avalia a capacidade de interpretação de textos, incluindo análise de obras literárias, gêneros textuais e questões relacionadas à gramática.'),
          _buildBulletList([
            'Interpretação de textos verbais e não-verbais.',
            'Conceitos gramaticais como sintaxe e morfologia.',
            'Gêneros discursivos e variações linguísticas.',
            'Literatura: Obras clássicas e contemporâneas da literatura brasileira.'
          ]),

          const SizedBox(height: 20),

          // Seção de Matemática
          _buildSectionTitle('Matemática'),
          _buildParagraph(
              'A prova de Matemática no ENEM exige raciocínio lógico e resolução de problemas práticos do cotidiano, com foco em áreas como álgebra, geometria e estatística.'),
          _buildBulletList([
            'Números e operações (frações, porcentagens, potências).',
            'Álgebra: Funções, equações e inequações.',
            'Geometria: Áreas, volumes e trigonometria.',
            'Probabilidade e estatística: Gráficos, tabelas e análise de dados.'
          ]),

          const SizedBox(height: 20),

          // Seção de Redação
          _buildSectionTitle('Redação'),
          _buildParagraph(
              'A redação do ENEM avalia a capacidade de organizar e expor ideias de forma clara, além de propor intervenções para resolver o problema discutido. O texto deve ser dissertativo-argumentativo e seguir as normas gramaticais.'),

          const SizedBox(height: 20),

          // Seção sobre isenção da taxa de inscrição
          _buildSectionTitle('Como solicitar a isenção da taxa de inscrição?'),
          _buildParagraph(
              'Para solicitar a isenção da taxa de inscrição do ENEM, o candidato deve atender aos requisitos como estar inscrito no CadÚnico ou ter concluído o Ensino Médio em escola pública.'),
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
        color: Colors.purple, // Cor temática do ENEM
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
            'Obras literárias cobradas no ENEM',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple, // Cor temática do ENEM
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'O ENEM avalia, entre outros conhecimentos, a capacidade de interpretação de obras literárias e de relacioná-las com aspectos culturais, sociais e históricos. '
            'Não há uma lista oficial de livros obrigatórios para o ENEM, como em alguns vestibulares, mas é importante ter conhecimento de obras clássicas e contemporâneas da literatura brasileira e suas contribuições para a formação da identidade cultural do país.\n',
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
          const Text(
            'Aqui estão algumas obras clássicas que frequentemente aparecem em questões do ENEM:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildBulletList([
            '“O Cortiço”, de Aluísio Azevedo',
            '“Memórias Póstumas de Brás Cubas”, de Machado de Assis',
            '“Vidas Secas”, de Graciliano Ramos',
            '“Capitães da Areia”, de Jorge Amado',
            '“Iracema”, de José de Alencar',
            '“A Moreninha”, de Joaquim Manuel de Macedo',
            '“Macunaíma”, de Mário de Andrade',
            '“Senhora”, de José de Alencar',
            '“A Hora da Estrela”, de Clarice Lispector',
            '“Dom Casmurro”, de Machado de Assis',
            '“O Auto da Compadecida”, de Ariano Suassuna',
          ]),
          const SizedBox(height: 20),
          const Text(
            'Saiba mais sobre a importância da literatura no ENEM em:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _launchURL(
              'https://www.todamateria.com.br/livros-enem/',
            ),
            child: const Text(
              'https://www.todamateria.com.br/livros-enem/',
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
            'Provas do ENEM',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple, // Cor temática do ENEM
            ),
          ),
          const SizedBox(height: 16),

          // Seção das provas de Ciências da Natureza
          _buildSection(
            title: 'Ciências da Natureza e suas Tecnologias',
            links: [
              LinkItem(text: 'Prova de 2023', url: '#'),
              LinkItem(text: 'Prova de 2022', url: '#'),
              LinkItem(text: 'Prova de 2021', url: '#'),
              LinkItem(text: 'Prova de 2020', url: '#'),
            ],
          ),
          const SizedBox(height: 16),

          // Seção das provas de Matemática
          _buildSection(
            title: 'Matemática e suas Tecnologias',
            links: [
              LinkItem(text: 'Prova de 2023', url: '#'),
              LinkItem(text: 'Prova de 2022', url: '#'),
              LinkItem(text: 'Prova de 2021', url: '#'),
              LinkItem(text: 'Prova de 2020', url: '#'),
            ],
          ),
          const SizedBox(height: 16),

          // Seção das provas de Linguagens
          _buildSection(
            title: 'Linguagens, Códigos e suas Tecnologias',
            links: [
              LinkItem(text: 'Prova de 2023', url: '#'),
              LinkItem(text: 'Prova de 2022', url: '#'),
              LinkItem(text: 'Prova de 2021', url: '#'),
              LinkItem(text: 'Prova de 2020', url: '#'),
            ],
          ),
          const SizedBox(height: 16),

          // Seção das provas de Ciências Humanas
          _buildSection(
            title: 'Ciências Humanas e suas Tecnologias',
            links: [
              LinkItem(text: 'Prova de 2023', url: '#'),
              LinkItem(text: 'Prova de 2022', url: '#'),
              LinkItem(text: 'Prova de 2021', url: '#'),
              LinkItem(text: 'Prova de 2020', url: '#'),
            ],
          ),
          const SizedBox(height: 16),

          // Seção da Redação
          _buildSection(
            title: 'Redação',
            links: [
              LinkItem(text: 'Tema da Redação de 2023', url: '#'),
              LinkItem(text: 'Tema da Redação de 2022', url: '#'),
              LinkItem(text: 'Tema da Redação de 2021', url: '#'),
              LinkItem(text: 'Tema da Redação de 2020', url: '#'),
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
                color: Colors.purple, // Cor temática do ENEM
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
        mainAxisAlignment: MainAxisAlignment.center, // Centralizar o conteúdo
        children: [
          const Text(
            'Provas anteriores do ENEM serão exibidas aqui.',
            style: TextStyle(
              color: Colors.purple, // Cor temática do ENEM
              fontSize: 16.0,
              fontWeight: FontWeight.bold, // Destacar o texto principal
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Você poderá acessar as provas e gabaritos dos últimos anos do ENEM para praticar e se familiarizar com o formato da avaliação. '
            'As provas incluem questões de Ciências da Natureza, Ciências Humanas, Matemática, Linguagens e Redação. Confira a lista completa em breve.',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black, // Cor de contraste para o texto descritivo
            ),
            textAlign: TextAlign.center, // Centralizar o texto
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
            'Sobre o ENEM',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple, // Cor temática do ENEM
            ),
          ),
          const SizedBox(height: 16),
          _buildSection(
            'O que é o ENEM?',
            [
              'O Exame Nacional do Ensino Médio (ENEM) é uma avaliação criada pelo Ministério da Educação (MEC) e aplicada pelo Instituto Nacional de Estudos e Pesquisas Educacionais Anísio Teixeira (INEP).',
              'O exame é utilizado para medir o desempenho dos estudantes ao final da educação básica e serve como porta de entrada para diversas universidades públicas e privadas do Brasil, além de possibilitar o acesso a programas como o Sisu, Prouni e Fies.',
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            'Estrutura do ENEM',
            [
              'O ENEM é composto por quatro áreas de conhecimento e uma redação, aplicada em dois dias de provas.',
              'As áreas de conhecimento são:',
              '- Ciências da Natureza e suas Tecnologias (Química, Física e Biologia)',
              '- Ciências Humanas e suas Tecnologias (História, Geografia, Filosofia e Sociologia)',
              '- Linguagens, Códigos e suas Tecnologias (Língua Portuguesa, Literatura, Língua Estrangeira, Artes, Educação Física e Tecnologias da Informação e Comunicação)',
              '- Matemática e suas Tecnologias (Matemática)',
              'Além disso, a redação exige a produção de um texto dissertativo-argumentativo.',
            ],
          ),
          const SizedBox(height: 16),
          _buildLink(
            'Acesse aqui o edital do ENEM 2024',
            '#',
          ),
          const SizedBox(height: 16),
          _buildSection(
            'Instituições que utilizam o ENEM',
            [
              'O ENEM é utilizado por universidades públicas e privadas em todo o país como parte do processo seletivo para ingresso nos cursos de graduação.',
              'Os principais programas de acesso que utilizam a nota do ENEM são:',
              '- Sistema de Seleção Unificada (Sisu)',
              '- Programa Universidade para Todos (Prouni)',
              '- Fundo de Financiamento Estudantil (Fies)',
              '- Universidades fora do Brasil também utilizam o ENEM como parte do processo seletivo.',
            ],
          ),
          const SizedBox(height: 16),
          _buildLink(
            'Veja aqui as universidades que aceitam o ENEM',
            '#',
          ),
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
                color: Colors.purple, // Cor temática do ENEM
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
            Text(
              description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onPressedInscrever,
                  child: const Text(
                    'Inscrever-se',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onPressedPagina,
                  child: const Text(
                    'Página',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
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
