import 'package:flutter/material.dart';
import 'package:flutter_chat/constants.dart';
import 'package:flutter_chat/screens/escolha_cadastro_screen.dart';
import 'package:flutter_chat/components/switch.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCorFundo,
      body: Stack(
        children: [
          Positioned(
            top: 50.0,
            left: 24.0,
            child: SwitchPersonalizado(textoAtivo: 'Candidato', textoInativo: 'Empresa', valorInicial: false),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 60.0, child: Image.asset('assets/images/logo.png')),
                SizedBox(height: 48.0),
                TextField(
                  style: kInputStyle,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(hintText: 'E-mail'),
                ),
                SizedBox(height: 8.0),
                TextField(
                  style: kInputStyle,
                  obscureText: _obscureSenha,
                  onChanged: (value) {
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Senha',
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
                BtnPadrao(title: 'Entrar', color: kCorPrimaria, onPressed: () {}),
                SizedBox(height: 12.0),
                SizedBox(
                  width: 220,
                  child: Row(
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
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700, color: kCorSecundaria),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
