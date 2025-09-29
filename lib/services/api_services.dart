import 'dart:convert';
import 'package:http/http.dart' as http;
// ADICIONADO: Import para o pacote de armazenamento seguro.
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/candidato_model.dart';

class ApiService {
  static const String _baseUrl = "https://apitechjobs.onrender.com";

  // ADICIONADO: Definição da variável _storage.
  // Agora a classe sabe o que é _storage.
  final _storage = const FlutterSecureStorage();

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
  Future<Map<String, dynamic>> login(String email, String senha) async {
    final url = Uri.parse('$_baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'email': email, 'senha': senha}),
      );

      if (response.statusCode == 200) {
        final String? rawCookie = response.headers['set-cookie'];
        if (rawCookie != null) {
          // Agora esta linha funciona, pois _storage existe.
          await _storage.write(key: 'session_cookie', value: rawCookie);
          print('SUCESSO: Cookie de sessão salvo!');
        }
        return jsonDecode(response.body);
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        throw Exception('E-mail ou senha inválidos.');
      } else {
        throw Exception('Falha ao fazer login. Código: ${response.statusCode}');
      }
    } catch (e) {
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