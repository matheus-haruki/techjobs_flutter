import 'package:TechJobs/screens/empresa/empresa_screen.dart';
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

  @override
  void dispose() {
    _nomeEmpresaController.dispose();
    _emailController.dispose();
    _cnpjController.dispose();
    _senhaController.dispose();
    _confirmSenhaController.dispose();
    super.dispose();
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
                      ),
                      SizedBox(height: 12.0),

                      // E-mail
                      Input(
                        label: 'E-mail',
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
                        corInput: CorInput.Secundaria,
                        controller: _senhaController,
                        hintText: 'Crie uma senha',
                        obscureText: _obscurePassword,
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
                      SizedBox(height: 12.0),

                      // Confirmar Senha
                      Input(
                        label: 'Confirme sua senha',
                        corInput: CorInput.Secundaria,
                        controller: _confirmSenhaController,
                        hintText: 'Confirme a senha',
                        obscureText: _obscureConfirmPassword,
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
                      SizedBox(height: 26.0),
                      BtnPadrao(
                        title: 'Finalizar Cadastro',
                        color: kCorSecundaria,
                        onPressed: () {
                          Navigator.pushNamed(context, EmpresaScreen.id);
                        },
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
          ],
        ),
      ),
    );
  }
}
