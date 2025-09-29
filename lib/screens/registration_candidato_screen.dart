import 'package:TechJobs/screens/confirmacao_screen.dart';
import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import 'login_screen.dart';
import '../services/api_services.dart';
import '../models/candidato_model.dart';

class RegistrationCandidatoScreen extends StatefulWidget {
  static const String id = 'registration_candidato_screen';

  @override
  _RegistrationCandidatoScreenState createState() => _RegistrationCandidatoScreenState();
}

class _RegistrationCandidatoScreenState extends State<RegistrationCandidatoScreen> {
  // CORREÇÃO 1: Adicionar a declaração dos controladores.
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();

  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _confirmaSenhaController.dispose();
    super.dispose();
  }

  Future<void> _submitCadastro() async {
    // Validação dos campos
    if (_nomeController.text.isEmpty || _emailController.text.isEmpty || _senhaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Por favor, preencha todos os campos.'), backgroundColor: Colors.red));
      return;
    }
    if (_senhaController.text != _confirmaSenhaController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('As senhas não coincidem.'), backgroundColor: Colors.red));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final novoCandidato = Candidato(nome: _nomeController.text, email: _emailController.text, senha: _senhaController.text);

      await _apiService.cadastrarCandidato(novoCandidato);

      if (mounted) {
        // Verifica se o widget ainda está na tela antes de navegar
        Navigator.pushReplacementNamed(context, ConfirmacaoScreen.id);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erro: ${e.toString()}'), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCorFundo,
      body: Center(
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 80.0, child: Image.asset('assets/images/logo.png')),
                          SizedBox(height: 20.0),
                          Text(
                            'Seja bem vindo, Novato',
                            style: TextStyle(fontFamily: 'Montserrat', fontSize: 25.0, fontWeight: FontWeight.w900, color: kPreto),
                          ),
                        ],
                      ),
                      SizedBox(height: 48.0),
                      LabelPadrao(texto: ' Nome:'),
                      TextField(
                        controller: _nomeController,
                        style: kInputStyle,
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Digite o seu nome completo', prefixIcon: Icon(Icons.person)),
                      ),
                      SizedBox(height: 12.0),
                      LabelPadrao(texto: ' E-mail:'),
                      TextField(
                        controller: _emailController,
                        style: kInputStyle,
                        keyboardType: TextInputType.emailAddress,
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Digite seu e-mail'),
                      ),
                      SizedBox(height: 12.0),
                      LabelPadrao(texto: ' Senha:'),
                      TextField(
                        controller: _senhaController,
                        style: kInputStyle,
                        obscureText: _obscurePassword,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Crie uma senha',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      LabelPadrao(texto: ' Confirme sua senha:'),
                      TextField(
                        controller: _confirmaSenhaController,
                        style: kInputStyle,
                        obscureText: _obscureConfirmPassword,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Confirme a senha',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(_obscureConfirmPassword ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword = !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 26.0),
                      BtnPadrao(title: 'Finalizar Cadastro', color: kCorPrimaria, onPressed: _isLoading ? null : _submitCadastro),
                      SizedBox(height: 12.0),
                      SizedBox(
                        width: 220,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Já possui uma conta? ', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700)),
                            TextButton(
                              style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                              onPressed: () {
                                Navigator.pushNamed(context, LoginScreen.id);
                              },
                              child: Text(
                                'Faça o login',
                                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: kPreto),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // CORREÇÃO 2: Indicador de loading posicionado corretamente.
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}

class LabelPadrao extends StatelessWidget {
  LabelPadrao({required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2.0),
      child: Text(
        texto,
        style: TextStyle(fontFamily: 'Montserrat', fontSize: 18, fontWeight: FontWeight.w900, color: kPreto),
      ),
    );
  }
}

// Supondo que você tenha uma classe BtnPadrao parecida com esta:
class BtnPadrao extends StatelessWidget {
  const BtnPadrao({Key? key, required this.title, required this.color, this.onPressed}) : super(key: key);

  final String title;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(title),
      style: ElevatedButton.styleFrom(backgroundColor: color),
    );
  }
}
