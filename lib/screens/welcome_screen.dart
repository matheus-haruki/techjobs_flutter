import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import 'package:TechJobs/screens/cadastro/escolha_cadastro_screen.dart';
import 'package:TechJobs/screens/cadastro/login_screen.dart'; // Import absoluto

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCorFundo,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '.',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 45.0,
                    fontWeight: FontWeight.w600,
                    color: kCorSecundariaEscura,
                  ),
                ),
                Text(
                  'T',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 45.0,
                    fontWeight: FontWeight.w600,
                    color: kCorPrimariaEscura,
                  ),
                ),
                Text(
                  'ech',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 45.0,
                    fontWeight: FontWeight.w600,
                    color: kPreto,
                  ),
                ),
                Text(
                  'J',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 45.0,
                    fontWeight: FontWeight.w600,
                    color: kCorPrimariaEscura,
                  ),
                ),
                Text(
                  'obs',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 45.0,
                    fontWeight: FontWeight.w600,
                    color: kPreto,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PJ ou CLT, temos a vaga certa para você',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            SizedBox(height: 48.0),
            BtnPadrao(
              title: 'Entrar',
              color: kCorPrimaria,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            SizedBox(height: 15),
            BtnPadrao(
              title: 'Cadastre-se',
              color: kCorSecundaria,
              onPressed: () {
                debugPrint(
                  'Register button pressed - trying to navigate to: ${EscolhaCadastroScreen.id}',
                );

                Navigator.pushNamed(context, EscolhaCadastroScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
