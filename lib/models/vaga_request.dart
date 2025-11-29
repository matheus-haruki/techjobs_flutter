class AdicionarVagaRequest {
  String nome;
  String cargo;
  String modelo;
  String nivelExperiencia;
  String? cep;
  String? numero;
  String descricao;
  double? salarioPrevisto;
  bool interna;

  AdicionarVagaRequest({
    required this.nome,
    required this.cargo,
    required this.modelo,
    required this.nivelExperiencia,
    required this.cep,
    required this.numero,
    required this.descricao,
    required this.salarioPrevisto,
    this.interna = false,
  });

  // Método para mapear de/para JSON, se necessário
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'cargo': cargo,
      'modelo': modelo,
      'nivelExperiencia': nivelExperiencia,
      'cep': cep,
      'numero': numero,
      'descricao': descricao,
      'salarioPrevisto': salarioPrevisto,
      'interna': interna,
    };
  }

  // Método para criar uma instância a partir de JSON
  factory AdicionarVagaRequest.fromJson(Map<String, dynamic> json) {
    return AdicionarVagaRequest(
      nome: json['nome'] ?? '',
      cargo: json['cargo'] ?? '',
      modelo: json['modelo'] ?? '',
      nivelExperiencia: json['nivelExperiencia'] ?? '',
      cep: json['cep'],
      numero: json['numero'],
      descricao: json['descricao'] ?? '',
      salarioPrevisto: json['salarioPrevisto'] != null ? json['salarioPrevisto'].toDouble() : null,
      interna: json['interna'] ?? false,
    );
  }
}
