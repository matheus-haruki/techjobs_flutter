import 'dart:convert';

import 'package:TechJobs/services/api_services.dart';

class UserModel {
  final String nomeUsuario;
  final String email;
  final Perfil perfil;

  UserModel({required this.nomeUsuario, required this.email, required this.perfil});

  // Converte objeto para Map (para salvar)
  Map<String, dynamic> toMap() {
    return {
      'nomeUsuario': nomeUsuario,
      'perfil': perfil.index,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      nomeUsuario: map['nomeUsuario'] ?? '',
      perfil: obterPerfil(map['perfil']),
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));
}