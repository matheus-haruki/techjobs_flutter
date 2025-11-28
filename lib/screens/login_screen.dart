import 'package:TechJobs/components/input.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:TechJobs/constants.dart';
import 'package:TechJobs/screens/candidato_screen.dart';
import 'package:TechJobs/screens/escolha_cadastro_screen.dart';
import 'package:TechJobs/components/switch.dart';
import 'package:TechJobs/services/api_services.dart'; // Garanta que este caminho está correto

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // --- Suas variáveis de UI existentes ---
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureSenha = true;
  bool _isCandidato = false;

  // --- LÓGICA ADICIONADA ---
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // --- LÓGICA ADICIONADA ---
  Future<void> _submitLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _apiService.login(_emailController.text, _passwordController.text);
      print(
        'Login realizado com sucesso para o usuário: ${_emailController.text}',
      );

      if (mounted) {
        // Navega para a tela principal, substituindo a de login
        Navigator.pushReplacementNamed(context, CandidatoScreen.id);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
        );
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
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 50.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 60.0,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    const SizedBox(height: 20.0),
                    Input(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Digite seu e-mail",
                      corInput: CorInput.Primaria,
                      label: "E-mail:",
                      prefixIcon: const Icon(Icons.email)
                    ),
                    const SizedBox(height: 30.0),
                    Input(
                      controller: _passwordController,
                      corInput: CorInput.Primaria,
                      hintText: "Digite sua senha",
                      label: "Senha:",
                      prefixIcon: const Icon(Icons.lock),
                      obscureText: _obscureSenha,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureSenha
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureSenha = !_obscureSenha;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    BtnPadrao(
                      title: 'Entrar',
                      color: kCorPrimaria,
                      // CORREÇÃO: A chamada para _submitLogin está agora dentro de uma função anônima () { ... }
                      onPressed: _isLoading
                          ? null
                          : () {
                              _submitLogin();
                            },
                    ),
                    const SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Não possui uma conta? ',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              EscolhaCadastroScreen.id,
                            );
                          },
                          child: Text(
                            'Registre-se aqui',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w700,
                              color: kCorPrimaria,
                              decoration: TextDecoration.underline

                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // LÓGICA DO LOADING ADICIONADA
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
