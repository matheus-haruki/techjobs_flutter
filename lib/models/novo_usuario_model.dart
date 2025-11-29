class NovoUsuarioRequest {
  String senha;
  String login;
  int perfil;
  String documento;
  String nome;
  String? cep;
  String? numero;

  NovoUsuarioRequest({
    required this.senha,
    required this.login,
    required this.perfil,
    required this.documento,
    required this.nome,
    this.cep = '',
    this.numero = '',
  });

  factory NovoUsuarioRequest.fromJson(Map<String, dynamic> json) {
    return NovoUsuarioRequest(
      senha: json['senha'] ?? '',
      login: json['login'] ?? '',
      perfil: json['perfil'] ?? 0,
      documento: json['documento'] ?? '',
      nome: json['nome'] ?? '',
      cep: json['cep'] ?? '',
      numero: json['numero'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senha': senha,
      'login': login,
      'perfil': perfil,
      'documento': documento,
      'nome': nome,
      'cep': cep,
      'numero': numero,
    };
  }
}
