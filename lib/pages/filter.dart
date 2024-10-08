import 'package:flutter/material.dart';
import 'university.dart';
import 'courses.dart';
import 'entrance_exams.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  // Controle do filtro ativo
  String activeFilter = 'Universidade';
  String selectedUniversidadeOption =
      'Presencial'; // Opção selecionada por padrão
  String selectedVestibularesOption = 'Opção Vestibular 1';
  String selectedCursosOption = 'Opção Curso 1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.purple),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Filtro',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.purple),
            onPressed: () {
              // Ação para resetar os filtros
              setState(() {
                selectedUniversidadeOption = 'Presencial';
                selectedVestibularesOption = 'Opção Vestibular 1';
                selectedCursosOption = 'Opção Curso 1';
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Opção de filtro Universidade
            buildFilterOption('Universidade', activeFilter == 'Universidade'),
            if (activeFilter == 'Universidade') buildUniversidadeOptions(),

            // Opção de filtro Vestibulares
            buildFilterOption('Vestibulares', activeFilter == 'Vestibulares'),
            if (activeFilter == 'Vestibulares') buildVestibularesOptions(),

            // Opção de filtro Cursos
            buildFilterOption('Cursos', activeFilter == 'Cursos'),
            if (activeFilter == 'Cursos') buildCursosOptions(),

            Spacer(),
            // Botão de aplicar
            ElevatedButton(
              onPressed: () {
                // Ação do botão Aplicar
                if (activeFilter == 'Universidade') {
                  // Redireciona para a página de universidades
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => universty(
                        filterType: selectedUniversidadeOption,
                      ),
                    ),
                  );
                } else if (activeFilter == 'Vestibulares') {
                  // Redireciona para a página de vestibulares
                  // Adicione aqui a lógica para vestibulares
                } else if (activeFilter == 'Cursos') {
                  // Redireciona para a página de cursos
                  // Adicione aqui a lógica para cursos
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Aplicar',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir a opção de filtro principal
  Widget buildFilterOption(String title, bool isActive) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isActive ? Colors.black : Colors.black54,
        ),
      ),
      trailing: Icon(
        isActive ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        color: Colors.black54,
      ),
      onTap: () {
        setState(() {
          activeFilter = title; // Define o filtro ativo
        });
      },
    );
  }

  // Opções de filtro para Universidade
  Widget buildUniversidadeOptions() {
    return Column(
      children: [
        buildRadioOption('Presencial', selectedUniversidadeOption, (value) {
          setState(() {
            selectedUniversidadeOption = value!;
          });
        }),
        buildRadioOption('Online', selectedUniversidadeOption, (value) {
          setState(() {
            selectedUniversidadeOption = value!;
          });
        }),
        buildRadioOption('Mais próximas', selectedUniversidadeOption, (value) {
          setState(() {
            selectedUniversidadeOption = value!;
          });
        }),
        buildRadioOption('Melhores avaliadas', selectedUniversidadeOption,
            (value) {
          setState(() {
            selectedUniversidadeOption = value!;
          });
        }),
      ],
    );
  }

  // Opções de filtro para Vestibulares
  Widget buildVestibularesOptions() {
    return Column(
      children: [
        buildRadioOption('Opção Vestibular 1', selectedVestibularesOption,
            (value) {
          setState(() {
            selectedVestibularesOption = value!;
          });
        }),
        buildRadioOption('Opção Vestibular 2', selectedVestibularesOption,
            (value) {
          setState(() {
            selectedVestibularesOption = value!;
          });
        }),
        buildRadioOption('Opção Vestibular 3', selectedVestibularesOption,
            (value) {
          setState(() {
            selectedVestibularesOption = value!;
          });
        }),
      ],
    );
  }

  // Opções de filtro para Cursos
  Widget buildCursosOptions() {
    return Column(
      children: [
        buildRadioOption('Opção Curso 1', selectedCursosOption, (value) {
          setState(() {
            selectedCursosOption = value!;
          });
        }),
        buildRadioOption('Opção Curso 2', selectedCursosOption, (value) {
          setState(() {
            selectedCursosOption = value!;
          });
        }),
        buildRadioOption('Opção Curso 3', selectedCursosOption, (value) {
          setState(() {
            selectedCursosOption = value!;
          });
        }),
      ],
    );
  }

  // Widget para construir opções de radio
  Widget buildRadioOption(
      String title, String groupValue, ValueChanged<String?> onChanged) {
    return RadioListTile<String>(
      title: Text(title),
      value: title,
      groupValue: groupValue,
      activeColor: Colors.purple,
      onChanged: onChanged,
    );
  }
}
