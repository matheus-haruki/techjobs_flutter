import 'package:TechJobs/models/novo_usuario_model.dart';
import 'package:TechJobs/screens/empresa/empresa_screen.dart';
import 'package:TechJobs/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import '../../components/input.dart';
import 'package:flutter/services.dart';
import 'login_screen.dart';

// Formatador de CNPJ customizado
class CnpjFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove todos os caracteres não numéricos
    String text = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // Limita a 14 dígitos
    if (text.length > 14) {
      text = text.substring(0, 14);
    }

    // Aplica a formatação XX.XXX.XXX/XXXX-XX
    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 5) {
        formatted += '.';
      } else if (i == 8) {
        formatted += '/';
      } else if (i == 12) {
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

class RegistrationEmpresaScreen extends StatefulWidget {
  static const String id = 'registration_empresa_screen';

  @override
  _RegistrationEmpresaScreenState createState() =>
      _RegistrationEmpresaScreenState();
}

class _RegistrationEmpresaScreenState extends State<RegistrationEmpresaScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Controllers para os campos
  final TextEditingController _nomeEmpresaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmSenhaController = TextEditingController();
  final _senhaFocusNode = FocusNode();
  final _confirmSenhaFocusNode = FocusNode();

  // Validação de senha
  bool _hasMinLength = false;
  bool _hasNumber = false;
  bool _hasUppercase = false;
  bool _hasLowercase = false;
  bool _showPasswordValidation = false;
  bool _showConfirmPasswordValidation = false;
  bool _passwordsMatch = true;
  bool _isLoading = false;

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
    _nomeEmpresaController.dispose();
    _emailController.dispose();
    _cnpjController.dispose();
    _senhaController.dispose();
    _confirmSenhaController.dispose();
    _senhaFocusNode.dispose();
    _confirmSenhaFocusNode.dispose();
    super.dispose();
  }

  void _validatePassword(String password) {
    setState(() {
      _hasMinLength = password.length > 8;
      _hasNumber = password.contains(RegExp(r'[0-9]'));
      _hasUppercase = password.contains(RegExp(r'[A-Z]'));
      _hasLowercase = password.contains(RegExp(r'[a-z]'));

      // Verificar se as senhas coincidem quando há texto no campo de confirmação
      if (_confirmSenhaController.text.isNotEmpty) {
        _passwordsMatch = password == _confirmSenhaController.text;
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

  final _formKey = GlobalKey<FormState>();

  final ApiService _apiService = ApiService();

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

    if (_senhaController.text != _confirmSenhaController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('As senhas não coincidem.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final novoCandidato = NovoUsuarioRequest(
        senha: _senhaController.text,
        login: _emailController.text,
        perfil: Perfil.Candidato.index,
        documento: _cnpjController.text,
        nome: _nomeEmpresaController.text,
      );

      setState(() {
        _isLoading = true;
      });

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
      setState(() {
        _isLoading = true;
      });
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
                              'Seja bem vindo, CNPJ',
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

                        // Nome da Empresa
                        Input(
                          label: 'Nome da Empresa',
                          corInput: CorInput.Secundaria,
                          controller: _nomeEmpresaController,
                          hintText: 'Digite o nome da empresa',
                          prefixIcon: Icon(Icons.person),
                          required: true,
                        ),
                        SizedBox(height: 12.0),

                        // E-mail
                        Input(
                          label: 'E-mail',
                          required: true,
                          corInput: CorInput.Secundaria,
                          controller: _emailController,
                          hintText: 'Digite seu e-mail',
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: Icon(Icons.email),
                        ),
                        SizedBox(height: 12.0),

                        // CNPJ
                        Input(
                          label: 'CNPJ',
                          required: true,
                          corInput: CorInput.Secundaria,
                          controller: _cnpjController,
                          hintText: 'Digite o CNPJ',
                          prefixIcon: Icon(Icons.business),
                          keyboardType: TextInputType.number,
                          inputFormatters: [CnpjFormatter()],
                        ),
                        SizedBox(height: 12.0),

                        // Senha
                        Input(
                          label: 'Senha',
                          required: true,
                          corInput: CorInput.Secundaria,
                          controller: _senhaController,
                          focusNode: _senhaFocusNode,
                          hintText: 'Crie uma senha',
                          obscureText: _obscurePassword,
                          onChanged: _validatePassword,
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
                          required: true,
                          corInput: CorInput.Secundaria,
                          controller: _confirmSenhaController,
                          focusNode: _confirmSenhaFocusNode,
                          hintText: 'Confirme a senha',
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
                            _confirmSenhaController.text.isNotEmpty)
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
                          color: kCorSecundaria,
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
          ],
        ),
      ),
    );
  }
}
