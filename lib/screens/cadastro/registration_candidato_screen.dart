import 'package:TechJobs/models/novo_usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import '../../components/input.dart';
import 'login_screen.dart';
import '../../services/api_services.dart';
import '../../models/candidato_model.dart';
import 'package:flutter/services.dart';
import '../candidato/candidate_main_page.dart';

class CpfFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove todos os caracteres não numéricos
    String text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Limita a 11 dígitos
    if (text.length > 11) {
      text = text.substring(0, 11);
    }

    // Aplica a formatação
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 3 || i == 6) {
        formatted += '.';
      } else if (i == 9) {
        formatted += '-';
      }
      formatted += text[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

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
  final _confirmSenhaFocusNode = FocusNode();

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
  bool _showConfirmPasswordValidation = false;
  bool _passwordsMatch = true;

  @override
  void initState() {
    super.initState();
    // Adicionar listener para o foco do campo de senha
    _senhaFocusNode.addListener(() {
      setState(() {
        _showPasswordValidation = _senhaFocusNode.hasFocus;
      });
    });

    // Adicionar listener para o foco do campo de confirmação de senha
    _confirmSenhaFocusNode.addListener(() {
      setState(() {
        _showConfirmPasswordValidation = _confirmSenhaFocusNode.hasFocus;
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
    _confirmSenhaFocusNode.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  void _validatePassword(String password) {
    setState(() {
      _hasMinLength = password.length > 8;
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));

      // Verificar se as senhas coincidem quando há texto no campo de confirmação
      if (_confirmaSenhaController.text.isNotEmpty) {
        _passwordsMatch = password == _confirmaSenhaController.text;
      }
    });
  }

  void _validateConfirmPassword(String confirmPassword) {
    setState(() {
      _passwordsMatch = _senhaController.text == confirmPassword;
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
              fontWeight: FontWeight.w500,
              color: isValid ? Colors.green : kVermelho,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitCadastro() async {
    // Validação dos campos
    if (!_formKey.currentState!.validate()) {
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
      final novoCandidato = NovoUsuarioRequest(senha: _senhaController.text, login: _emailController.text, perfil: Perfil.Candidato.index, documento: _cpfController.text, nome: _nomeController.text);

      await _apiService.adicionarUsuario(novoCandidato);

      if (mounted) {
        Navigator.pushReplacementNamed(context, LoginScreen.id);
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
                  child: Form(
                    key: _formKey,
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
                                fontWeight: FontWeight.w600,
                                color: kPreto,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 48.0),
                        // Nome
                        Input(
                          label: 'Nome',
                          corInput: CorInput.Primaria,
                          controller: _nomeController,
                          hintText: 'Digite o seu nome completo',
                          prefixIcon: Icon(Icons.person),
                          required: true,
                        ),
                        SizedBox(height: 12.0),
                        // E-mail
                        Input(
                          label: 'E-mail',
                          corInput: CorInput.Primaria,
                          controller: _emailController,
                          hintText: 'Digite seu e-mail',
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icon(Icons.email),
                          required: true,
                        ),
                        SizedBox(height: 12.0),
                        // CPF
                        Input(
                          label: 'CPF',
                          corInput: CorInput.Primaria,
                          controller: _cpfController,
                          hintText: 'Digite seu CPF',
                          prefixIcon: Icon(Icons.description),
                          keyboardType: TextInputType.number,
                          inputFormatters: [CpfFormatter()],
                          required: true,
                        ),
                        SizedBox(height: 12.0),
                        // Senha
                        Input(
                          label: 'Senha',
                          corInput: CorInput.Primaria,
                          controller: _senhaController,
                          focusNode: _senhaFocusNode,
                          hintText: 'Crie uma senha',
                          obscureText: _obscurePassword,
                          onChanged: _validatePassword,
                          prefixIcon: Icon(Icons.lock),
                          required: true,
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
                                      fontWeight: FontWeight.w500,
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
                        // Confirmar Senha
                        Input(
                          label: 'Confirme sua senha',
                          corInput: CorInput.Primaria,
                          controller: _confirmaSenhaController,
                          focusNode: _confirmSenhaFocusNode,
                          hintText: 'Confirme a senha',
                          required: true,
                          obscureText: _obscureConfirmPassword,
                          onChanged: _validateConfirmPassword,
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
                        // Mostrar validação de senhas iguais apenas quando há foco no campo de confirmação
                        if (_showConfirmPasswordValidation &&
                            _confirmaSenhaController.text.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Icon(
                                  _passwordsMatch
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  size: 16,
                                  color: _passwordsMatch
                                      ? Colors.green
                                      : kVermelho,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  _passwordsMatch
                                      ? 'As senhas coincidem'
                                      : 'As senhas devem coincidir',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: _passwordsMatch
                                        ? Colors.green
                                        : kVermelho,
                                  ),
                                ),
                              ],
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
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    LoginScreen.id,
                                  );
                                },
                                child: Text(
                                  'Faça o login',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    color: kPreto,
                                    decoration: TextDecoration.underline,
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
