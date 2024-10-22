import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocalizacaoEInfoTab extends StatefulWidget {
  const LocalizacaoEInfoTab({Key? key}) : super(key: key);

  @override
  _LocalizacaoEInfoTabState createState() => _LocalizacaoEInfoTabState();
}

class _LocalizacaoEInfoTabState extends State<LocalizacaoEInfoTab> {
  final LatLng _universityLatLng =
      const LatLng(-22.814, -47.064); // Coordenadas da Unicamp
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Seção de Localização
          const Text(
            'Localização',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _universityLatLng,
                  zoom: 15,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('unicamp'),
                    position: _universityLatLng,
                    infoWindow: const InfoWindow(
                      title: 'Universidade Estadual de Campinas',
                      snippet: 'Instituição de ensino superior',
                    ),
                  ),
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Universidade Estadual de Campinas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Instituição de ensino superior',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Icon(Icons.star, color: Colors.purple, size: 16),
                      Icon(Icons.star, color: Colors.purple, size: 16),
                      Icon(Icons.star, color: Colors.purple, size: 16),
                      Icon(Icons.star, color: Colors.purple, size: 16),
                      Icon(Icons.star_half, color: Colors.purple, size: 16),
                      SizedBox(width: 8),
                      Text(
                        '4.5',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Cidade Universitária Zeferino Vaz - Barão Geraldo, Campinas - SP, 13083-970',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Seção de Informações sobre as Faculdades
          const Text(
            'Sobre a Universidade',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'A Unicamp responde por 8% da pesquisa acadêmica no Brasil, 12% da pós-graduação nacional e mantém a liderança entre as universidades brasileiras no que diz respeito a patentes e ao número de artigos por capita publicados anualmente em revistas indexadas na base de dados ISI/WoS. A Universidade conta com aproximadamente 34 mil alunos matriculados em 66 cursos de graduação e 153 programas de pós-graduação.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          const Text(
            'Faculdades no espaço físico:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 8),
          _buildFaculdadeInfo(
              'Faculdade de Engenharia Elétrica e de Computação'),
          _buildFaculdadeInfo('Faculdade de Ciências Médicas'),
          _buildFaculdadeInfo('Instituto de Física'),
          _buildFaculdadeInfo('Faculdade de Educação Física'),
          // Adicione mais faculdades conforme necessário
        ],
      ),
    );
  }

  Widget _buildFaculdadeInfo(String faculdade) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.purple, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              faculdade,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
