class EmpresaModel {
  // Properties matching the JSON structure
  final int id;
  final int idUsuario;
  final String nome;
  final String email;
  final String cnpj;
  final String cep;
  final String numero;

  // Constructor
  EmpresaModel({
    required this.id,
    required this.idUsuario,
    required this.nome,
    required this.email,
    required this.cnpj,
    required this.cep,
    required this.numero,
  });

  // Factory method to create an instance from a JSON Map
  factory EmpresaModel.fromJson(Map<String, dynamic> json) {
    return EmpresaModel(
      id: json['id'] as int,
      idUsuario: json['idUsuario'] as int,
      nome: json['nome'] as String,
      email: json['email'] as String,
      cnpj: json['cnpj'] as String,
      cep: json['cep'] as String,
      numero: json['numero'] as String,
    );
  }
}