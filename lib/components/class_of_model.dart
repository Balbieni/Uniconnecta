class Universidade {
  final String nome;
  final String curso;
  final double avaliacao;
  final String distancia;
  final String modalidade;
  final String logoUrl;

  Universidade({
    required this.nome,
    required this.curso,
    required this.avaliacao,
    required this.distancia,
    required this.modalidade,
    required this.logoUrl,
  });

  // Sobrescrever o operador == para garantir comparação entre os campos relevantes
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Universidade &&
        other.nome == nome &&
        other.curso == curso &&
        other.avaliacao == avaliacao &&
        other.distancia == distancia &&
        other.modalidade == modalidade &&
        other.logoUrl == logoUrl;
  }

  // Sobrescrever o hashCode para usar uma combinação única de todos os campos
  @override
  int get hashCode {
    return nome.hashCode ^
        curso.hashCode ^
        avaliacao.hashCode ^
        distancia.hashCode ^
        modalidade.hashCode ^
        logoUrl.hashCode;
  }
}

class Vestibular {
  final String nome;
  final String logoUrl;
  final String curso;
  final double avaliacao;
  final String modalidade;

  Vestibular({
    required this.nome,
    required this.logoUrl,
    required this.curso,
    required this.avaliacao,
    required this.modalidade,
  });

  // Sobrescrevendo o operador == para garantir comparação correta
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Vestibular &&
        other.nome == nome &&
        other.logoUrl == logoUrl &&
        other.curso == curso &&
        other.avaliacao == avaliacao &&
        other.modalidade == modalidade;
  }

  // Sobrescrever o hashCode para garantir que objetos iguais tenham o mesmo hashCode
  @override
  int get hashCode {
    return nome.hashCode ^
        logoUrl.hashCode ^
        curso.hashCode ^
        avaliacao.hashCode ^
        modalidade.hashCode;
  }
}
