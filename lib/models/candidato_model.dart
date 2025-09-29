class Candidato {
  final String? id; // O ID pode ser nulo ao criar, pois é gerado pelo servidor
  final String nome;
  final String email;
  final String senha;

  Candidato({this.id, required this.nome, required this.email, required this.senha});

  // Um método auxiliar para converter nosso objeto Candidato em um Map,
  // que depois será convertido para JSON para enviar à API.
  // Note que não incluímos o ID aqui, pois ele não é enviado no cadastro.
  Map<String, dynamic> toJson() {
    return {'nome': nome, 'email': email, 'senha': senha};
  }
}
