import 'package:TechJobs/screens/candidato_screen.dart';
import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import 'package:TechJobs/screens/escolha_cadastro_screen.dart';
import 'package:TechJobs/components/switch.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureSenha = true;
  bool _isCandidato = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // A decoração do TextField já muda com base no estado
    final InputDecoration activeDecoration = _isCandidato ? kTextFieldDecorationEmpresa : kTextFieldDecoration;

    // ✨ PASSO 1: Crie uma variável para a cor do botão baseada no mesmo estado
    final Color activeButtonColor = _isCandidato ? kCorSecundaria : kCorPrimaria;

    final Color activeFundoColor = _isCandidato ? kCorSecundariaFundo : kCorFundo;

    final String activeRoleText = _isCandidato ? 'Digite seu CNPJ' : 'Digite seu e-mail';

    final Icon activeIcon = _isCandidato ? Icon(Icons.business) : Icon(Icons.email);

    return Scaffold(
      backgroundColor: activeFundoColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SwitchPersonalizado(
                  textoAtivo: 'Empresa',
                  textoInativo: 'Candidato',
                  valorInicial: _isCandidato,
                  onChanged: (value) {
                    setState(() {
                      _isCandidato = value;
                    });
                  },
                ),
                SizedBox(height: 30.0),
                SizedBox(height: 60.0, child: Image.asset('assets/images/logo.png')),
                SizedBox(height: 48.0),
                TextField(
                  controller: _emailController,
                  style: kInputStyle,
                  keyboardType: TextInputType.emailAddress,
                  decoration: activeDecoration.copyWith(hintText: activeRoleText, prefixIcon: activeIcon),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: _passwordController,
                  style: kInputStyle,
                  obscureText: _obscureSenha,
                  decoration: activeDecoration.copyWith(
                    hintText: 'Digite sua senha',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureSenha ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureSenha = !_obscureSenha;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                // ✨ PASSO 2: Use a variável de cor que criamos
                BtnPadrao(
                  title: 'Entrar',
                  color: activeButtonColor, // <-- ALTERAÇÃO APLICADA AQUI
                  onPressed: () {
                    Navigator.pushNamed(context, CandidatoScreen.id);
                  },
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Não possui uma conta? ', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700)),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      onPressed: () {
                        Navigator.pushNamed(context, EscolhaCadastroScreen.id);
                      },
                      child: Text(
                        'Registre-se aqui',
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: activeButtonColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
