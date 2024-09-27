import 'package:flutter/material.dart';

class FiltroPage extends StatefulWidget {
  @override
  _FiltroPageState createState() => _FiltroPageState();
}

class _FiltroPageState extends State<FiltroPage> {
  // Controle do filtro ativo
  String activeFilter = 'Universidade';
  String selectedUniversidadeOption =
      'Presencial'; // Opção selecionada por padrão
  String selectedVestibularesOption = '';
  String selectedCursosOption = '';

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
                selectedVestibularesOption = '';
                selectedCursosOption = '';
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
                // Adicione a lógica para aplicar o filtro aqui
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
        // Adicione mais opções conforme necessário
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
        // Adicione mais opções conforme necessário
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
