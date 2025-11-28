import 'dart:convert';
import 'package:TechJobs/models/empresa_model.dart';
import 'package:TechJobs/services/auth.dart';
import 'package:TechJobs/services/token_manager.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
// ADICIONADO: Import para o pacote de armazenamento seguro.
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/candidato_model.dart';

class ApiService {
  static const String _baseUrl = "https://sftd3lh74q5m2m3mtrr2pqx7gy0elkda.lambda-url.us-east-1.on.aws";

  // ADICIONADO: Definição da variável _storage.
  // Agora a classe sabe o que é _storage.
  final _storage = const FlutterSecureStorage();

  final Dio _dio = AuthInterceptor.dio;

  /// Função para cadastrar um novo candidato na API.
  Future<void> cadastrarCandidato(Candidato candidato) async {
    final url = Uri.parse('$_baseUrl/candidato');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(candidato.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Cadastro realizado com sucesso!');
        return;
      } else {
        throw Exception('Falha ao cadastrar candidato: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Não foi possível se conectar ao servidor. Verifique sua internet.');
    }
  }

  /// Realiza o login, salva o cookie de sessão e retorna os dados do usuário.
  Future<void> login(String email, String senha) async {

    try {
      final response = await _dio.post(
        "/usuario/token",
        data: {
          'login': email,
          'senha': senha,
        },
      );

      print(response);

      if (response.statusCode == 200) {
        final String token = response.data as String;

        await TokenManager.instance.setTokens(token);
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

  Future<EmpresaModel> obterDadosEmpresa() async {
    try {
      final response = await _dio.get('/empresa');

      if (response.statusCode == 200) {
        final data = response.data;

        print(response.data);
        // Supondo que você tenha um método fromJson em EmpresaModel
        return EmpresaModel.fromJson(data);
      } else {
        throw Exception('Falha ao obter dados da empresa. Código: ${response.statusCode}');
      }
    } catch (e) {
      // print(e);
      rethrow;
    }
  }
  /// EXEMPLO de como usar o cookie salvo em uma futura requisição.
  Future<void> getMeuPerfil() async {
    // Esta linha também funciona agora.
    final String? cookie = await _storage.read(key: 'session_cookie');
    final url = Uri.parse('$_baseUrl/candidato/perfil'); // Endpoint de exemplo

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Cookie': cookie ?? '', // Envia o cookie de volta para se autenticar
      },
    );

    if (response.statusCode == 200) {
      print("Perfil recebido com sucesso!");
    } else {
      throw Exception('Falha ao buscar perfil.');
    }
  }
}