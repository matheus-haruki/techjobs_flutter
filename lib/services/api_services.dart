import 'dart:convert';
import 'dart:io';
import 'package:TechJobs/models/dashboard_candidado_model.dart';
import 'package:TechJobs/models/dashboard_empresa_model.dart';
import 'package:TechJobs/models/logar_usuario_response.dart';
import 'package:TechJobs/models/novo_usuario_model.dart';
import 'package:TechJobs/models/vaga_empresa.dart';
import 'package:TechJobs/models/vaga_request.dart';
import 'package:TechJobs/models/vaga_todas_request.dart';
import 'package:TechJobs/models/vagas_model.dart';
import 'package:TechJobs/screens/candidato/candidate_main_page.dart';
import 'package:TechJobs/screens/empresa/empresa_screen.dart';
import 'package:TechJobs/services/auth.dart';
import 'package:TechJobs/services/storage_manager.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/candidato_model.dart';

enum Perfil { Admin, Candidato, Empresa }

Perfil obterPerfil(int perfil) {
  switch (perfil) {
    case 0:
      return Perfil.Admin;
    case 1:
      return Perfil.Candidato;
    case 2:
      return Perfil.Empresa;
  }

  throw new Exception("Perfil não encontrado");
}

extension PerfilAction on Perfil {
  Future<void> Acao(BuildContext context) async {
    switch (this) {
      case Perfil.Candidato:
        await Navigator.pushReplacementNamed(context, CandidateMainPage.id);
      case Perfil.Empresa:
        await Navigator.pushReplacementNamed(context, EmpresaScreen.id);
      case Perfil.Admin:
    }
  }
}

class ApiService {
  final Dio _dio = AuthInterceptor.dio;

  Future<void> adicionarVaga(AdicionarVagaRequest request) async {
    try {
      await _dio.post("/vaga", data: request.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deletarVaga(int id) async {
    try {
      await _dio.delete("/vaga/${id}");
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String> gerarUrlAssinada(int idAplicacao) async {
    try {
      final response = await _dio.get("/vaga/url-cv-aplicacao/${idAplicacao}");

      return response.data as String;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> retornarResultado(int idAplicacao, int situacao) async {
    try {
      await _dio.post("/empresa/aplicacao-vaga/${idAplicacao}/${situacao}");
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Vaga>> ObterAplicacoes() async {
    final response = await _dio.get("/candidato/aplicacoes");

    if (response.statusCode == 200) {
      final vagas = response.data as List;

      return vagas.map((item) => Vaga.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao buscar vagas. Código: ${response.statusCode}');
    }
  }

  Future<VagaEmpresaResponse> obterDetalhevaga(int id) async {
    try {
      final response = await _dio.get("/vaga/empresa/${id}");

      return VagaEmpresaResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<DashboardCandidatoResponse> obterDadosDashboardCandidato() async {
    try {
      final response = await _dio.get("/candidato/dashboard");

      return DashboardCandidatoResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> adicionarUsuario(NovoUsuarioRequest request) async {
    try {
      await _dio.post("/usuario", data: request.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<DashboardEmpresaResponse> obterDadosDashboardEmpresa() async {
    try {
      final response = await _dio.get("/empresa/dashboard");

      return DashboardEmpresaResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Vaga>> obterVagasCandidato(ObterTodasVagasRequest request) async {
    try {
      final response = await _dio.get(
        "/vaga/todas",
        queryParameters: request.toJson(),
      );

      if (response.statusCode == 200) {
        final vagas = response.data as List;

        return vagas.map((item) => Vaga.fromJson(item)).toList();
      } else {
        throw Exception(
          'Falha ao buscar vagas. Código: ${response.statusCode}',
        );
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> aplicarVaga(PlatformFile file, int idVaga) async {
    print(idVaga);

    FormData formData = FormData.fromMap({
      'file': kIsWeb
          ? MultipartFile.fromBytes(
              file.bytes!,
              filename: file.name,
              contentType: http.MediaType('application', 'octet-stream'),
            )
          : MultipartFile.fromFile(
              file.path!,
              filename: file.name,
              contentType: http.MediaType('application', 'octet-stream'),
            ),
    });

    await _dio.post(
      "/candidato/vaga/$idVaga",
      data: formData,
      options: Options(contentType: "multipart/form-data"),
    );
  }

  Future<List<Vaga>> obterVagasEmpresa() async {
    try {
      final response = await _dio.get("/vaga/empresa");

      if (response.statusCode == 200) {
        final vagas = response.data as List;

        return vagas.map((item) => Vaga.fromJson(item)).toList();
      } else {
        throw Exception(
          'Falha ao buscar vagas. Código: ${response.statusCode}',
        );
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  /// Realiza o login, salva o cookie de sessão e retorna os dados do usuário.
  Future<Perfil> login(String email, String senha) async {
    try {
      final response = await _dio.post(
        "/usuario/token",
        data: {'login': email, 'senha': senha},
      );

      if (response.statusCode == 200) {
        final logarUsuarioResponse = LogarUsuarioResponse.fromJson(
          response.data as Map<String, dynamic>,
        );

        await StorageManager.instance.setUserCredentials(logarUsuarioResponse);

        return logarUsuarioResponse.perfil;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        throw Exception('E-mail ou senha inválidos.');
      } else {
        throw Exception('Falha ao fazer login. Código: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
