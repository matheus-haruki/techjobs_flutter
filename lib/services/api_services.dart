import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/candidato_model.dart'; // Importa nosso model que acabamos de criar

class ApiService {
  // URL base da nossa API. Facilita a manutenção se o endereço mudar.
  static const String _baseUrl = "https://apitechjobs.onrender.com";

  /// Função para cadastrar um novo candidato na API.
  /// Recebe um objeto [Candidato] com os dados do formulário.
  Future<void> cadastrarCandidato(Candidato candidato) async {
    // Constrói a URL completa para o endpoint de cadastro.
    final url = Uri.parse('$_baseUrl/candidato');

    try {
      // Faz a requisição POST, enviando o corpo em formato JSON.
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        // Usamos o método toJson() do nosso model para gerar o corpo da requisição.
        body: jsonEncode(candidato.toJson()),
      );

      // Verifica se a resposta da API foi um sucesso.
      // Códigos 200 (OK) ou 201 (Created) são considerados sucesso para criação.
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Cadastro realizado com sucesso!');
        // A função termina aqui se tudo deu certo.
        return;
      } else {
        // Se a API retornou um código de erro, nós lançamos uma exceção.
        throw Exception('Falha ao cadastrar candidato: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      // Captura erros de conexão ou outros problemas na requisição.
      print(e.toString());
      throw Exception('Não foi possível se conectar ao servidor. Verifique sua internet.');
    }
  }
}
