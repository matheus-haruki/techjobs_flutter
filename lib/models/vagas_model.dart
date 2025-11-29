class Vaga {
  final int id;
  final int idEmpresa;
  final String nome;
  final String cargo;
  final String modelo;
  final String nivelExperiencia;
  final String? cep;
  final String? numero;
  final String descricao;
  final double? salarioPrevisto;
  final bool interna;
  final DateTime dataCadastro;
  final DateTime dataFimInscricoes;
  final int? quantidadeAplicacoes;
  final String? nomeEmpresa;
  final int? situacao;

  Vaga({
    required this.id,
    required this.idEmpresa,
    required this.nome,
    required this.cargo,
    required this.modelo,
    required this.nivelExperiencia,
    this.cep,
    this.numero,
    required this.descricao,
    this.salarioPrevisto,
    required this.interna,
    required this.dataCadastro,
    required this.dataFimInscricoes,
    this.quantidadeAplicacoes = 0,
    this.nomeEmpresa = '',
    this.situacao = 0
  });

  // From JSON
  factory Vaga.fromJson(Map<String, dynamic> json) {
    return Vaga(
      id: json["id"],
      idEmpresa: json["idEmpresa"],
      nome: json["nome"] ?? "",
      cargo: json["cargo"] ?? "",
      modelo: json["modelo"] ?? "",
      nivelExperiencia: json["nivelExperiencia"] ?? "",
      cep: json["cep"],
      numero: json["numero"],
      descricao: json["descricao"] ?? "",
      salarioPrevisto: json["salarioPrevisto"] != null
          ? (json["salarioPrevisto"] as num).toDouble()
          : null,
      interna: json["interna"] ?? false,
      dataCadastro: DateTime.parse(json["dataCadastro"]),
      dataFimInscricoes: DateTime.parse(json["dataFimInscricoes"]),
      quantidadeAplicacoes: json["quantidadeAplicacoes"],
      nomeEmpresa: json["nomeEmpresa"],
      situacao: json["situacao"]
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "idEmpresa": idEmpresa,
      "nome": nome,
      "cargo": cargo,
      "modelo": modelo,
      "nivelExperiencia": nivelExperiencia,
      "cep": cep,
      "numero": numero,
      "descricao": descricao,
      "salarioPrevisto": salarioPrevisto,
      "interna": interna,
      "dataCadastro": dataCadastro.toIso8601String(),
      "dataFimInscricoes": dataFimInscricoes.toIso8601String(),
      "quantidadeAplicacoes": quantidadeAplicacoes,
    };
  }
}
