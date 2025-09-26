import 'package:flutter/material.dart';
import 'package:flutter_chat/constants.dart';
import 'login_screen.dart';

class RegistrationCandidatoScreen extends StatefulWidget {
  static const String id = 'registration_candidato_screen';

  @override
  _RegistrationCandidatoScreenState createState() => _RegistrationCandidatoScreenState();
}

class _RegistrationCandidatoScreenState extends State<RegistrationCandidatoScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
                        style: kInputStyle,
                        onChanged: (value) {},
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Digite o seu nome completo', prefixIcon: Icon(Icons.person)),
                      ),
                      SizedBox(height: 12.0),
                      LabelPadrao(texto: ' E-mail:'),
                      TextField(
                        style: kInputStyle,
                        onChanged: (value) {
                          //Do something with the user input.
                        },
                        decoration: kTextFieldDecoration.copyWith(hintText: 'Digite seu e-mail'),
                      ),
                      SizedBox(height: 12.0),
                      LabelPadrao(texto: ' Senha:'),
                      TextField(
                        style: kInputStyle,
                        obscureText: _obscurePassword,
                        onChanged: (value) {
                          //Do something with the user input.
                        },
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
                        style: kInputStyle,
                        obscureText: _obscureConfirmPassword,
                        onChanged: (value) {
                          //Do something with the user input.
                        },
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
                      BtnPadrao(
                        title: 'Finalizar Cadastro',
                        color: kCorPrimaria,
                        onPressed: () {
                          //Implement registration functionality.
                        },
                      ),
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
