class CandidatoVagaDTO {
  final String nome;
  final String email;
  final int id;

  CandidatoVagaDTO({
    required this.nome,
    required this.email,
    required this.id
  });

  factory CandidatoVagaDTO.fromJson(Map<String, dynamic> json) {
    return CandidatoVagaDTO(
      nome: json["nome"] ?? "",
      email: json["email"] ?? "",
      id: json['id']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "nome": nome,
      "email": email,
      "id": id
    };
  }
}

