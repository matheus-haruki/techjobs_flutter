import 'package:TechJobs/services/api_services.dart';

class LogarUsuarioResponse {
  final String token;
  final String nomeUsuario;
  final String email;
  final Perfil perfil;

  LogarUsuarioResponse({
    required this.token,
    required this.nomeUsuario,
    required this.email,
    required this.perfil
  });


  factory LogarUsuarioResponse.fromJson(Map<String, dynamic> json) {
    return LogarUsuarioResponse(
      token: json['token'] ?? '',
      nomeUsuario: json['nomeUsuario'] ?? '',
      email: json['email'] ?? '',
      perfil: Perfil.values[json['perfil'] as int]
    );
  }
}
