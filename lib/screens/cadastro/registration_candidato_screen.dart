import 'package:TechJobs/screens/cadastro/confirmacao_screen.dart';
import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import 'login_screen.dart';
import '../../services/api_services.dart';
import '../../models/candidato_model.dart';
import 'package:brasil_fields/brasil_fields.dart';

class RegistrationCandidatoScreen extends StatefulWidget {
  static const String id = 'registration_candidato_screen';

  @override
  _RegistrationCandidatoScreenState createState() =>
      _RegistrationCandidatoScreenState();
}

class _RegistrationCandidatoScreenState
    extends State<RegistrationCandidatoScreen> {
  // CORREÇÃO 1: Adicionar a declaração dos controladores.
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _cpfController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();
  final _senhaFocusNode = FocusNode();

  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Validação de senha
  bool _hasMinLength = false;
  bool _hasNumber = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _showPasswordValidation = false;

  @override
  void initState() {
    super.initState();
    // Adicionar listener para o foco do campo de senha
    _senhaFocusNode.addListener(() {
      setState(() {
        _showPasswordValidation = _senhaFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _cpfController.dispose();
    _senhaController.dispose();
    _confirmaSenhaController.dispose();
    _senhaFocusNode.dispose();
    super.dispose();
  }

  void _validatePassword(String password) {
    setState(() {
      _hasMinLength = password.length > 8;
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));
    });
  }

  bool _isPasswordValid() {
    return _hasMinLength && _hasNumber && _hasUppercase && _hasLowercase;
  }

  Widget _buildPasswordRequirement(String requirement, bool isValid) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: isValid ? Colors.green : kVermelho,
          ),
          SizedBox(width: 8),
          Text(
            requirement,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isValid ? Colors.green : kVermelho,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitCadastro() async {
    // Validação dos campos
    if (_nomeController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _senhaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validação da força da senha
    if (!_isPasswordValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A senha não atende aos critérios de segurança.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_senhaController.text != _confirmaSenhaController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('As senhas não coincidem.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final novoCandidato = Candidato(
        nome: _nomeController.text,
        email: _emailController.text,
        senha: _senhaController.text,
      );

      await _apiService.cadastrarCandidato(novoCandidato);

      if (mounted) {
        // Verifica se o widget ainda está na tela antes de navegar
        Navigator.pushReplacementNamed(context, ConfirmacaoScreen.id);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
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
                          SizedBox(
                            width: 80.0,
                            child: Image.asset('assets/images/logo.png'),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            'Seja bem vindo, Novato',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 25.0,
                              fontWeight: FontWeight.w900,
                              color: kPreto,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 48.0),
                      LabelPadrao(texto: ' Nome:'),
                      TextField(
                        controller: _nomeController,
                        style: kInputStyle,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Digite o seu nome completo',
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      LabelPadrao(texto: ' E-mail:'),
                      TextField(
                        controller: _emailController,
                        style: kInputStyle,
                        keyboardType: TextInputType.emailAddress,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Digite seu e-mail',
                        ),
                      ),
                      SizedBox(height: 12.0),
                      //CPF
                      LabelPadrao(texto: ' CPF:'),
                      TextField(
                        controller: _cpfController,
                        style: kInputStyle,
                        keyboardType: TextInputType.number,
                        inputFormatters: [CpfInputFormatter()],
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Digite seu CPF',
                          prefixIcon: Icon(Icons.description),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      //Senha
                      LabelPadrao(texto: ' Senha:'),
                      TextField(
                        controller: _senhaController,
                        focusNode: _senhaFocusNode, // Adicionar o FocusNode
                        style: kInputStyle,
                        obscureText: _obscurePassword,
                        onChanged: _validatePassword,
                        decoration: kTextFieldDecoration.copyWith(
                          hintText: 'Crie uma senha',
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      // Mostrar validação apenas quando o campo está em foco
                      if (_showPasswordValidation)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //condições da senha
                                Text(
                                  'A senha deve conter: ',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: kPreto,
                                  ),
                                ),
                                SizedBox(height: 8),
                                _buildPasswordRequirement(
                                  'Mais de 8 caracteres',
                                  _hasMinLength,
                                ),
                                _buildPasswordRequirement(
                                  'Pelo menos 1 número',
                                  _hasNumber,
                                ),
                                _buildPasswordRequirement(
                                  'Uma letra maiúscula',
                                  _hasUppercase,
                                ),
                                _buildPasswordRequirement(
                                  'Uma letra minúscula',
                                  _hasLowercase,
                                ),
                              ],
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
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 26.0),
                      BtnPadrao(
                        title: 'Finalizar Cadastro',
                        color: kCorPrimaria,
                        onPressed: _isLoading ? null : _submitCadastro,
                      ),
                      SizedBox(height: 12.0),
                      SizedBox(
                        width: 220,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Já possui uma conta? ',
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
                                Navigator.pushNamed(context, LoginScreen.id);
                              },
                              child: Text(
                                'Faça o login',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700,
                                  color: kPreto,
                                ),
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
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: kPreto,
        ),
      ),
    );
  }
}

// Supondo que você tenha uma classe BtnPadrao parecida com esta:
class BtnPadrao extends StatelessWidget {
  const BtnPadrao({
    Key? key,
    required this.title,
    required this.color,
    this.onPressed,
  }) : super(key: key);

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
