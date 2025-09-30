import 'package:TechJobs/screens/confirmacao_screen.dart';
import 'package:TechJobs/screens/empresa_screen.dart';
import 'package:flutter/material.dart';
import 'package:TechJobs/screens/registration_empresa_screen.dart';
import 'package:TechJobs/screens/welcome_screen.dart';
import 'package:TechJobs/screens/login_screen.dart';
import 'package:TechJobs/screens/registration_candidato_screen.dart';
import 'package:TechJobs/screens/escolha_cadastro_screen.dart';
import 'package:TechJobs/screens/candidato_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.black54)),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        EscolhaCadastroScreen.id: (context) => EscolhaCadastroScreen(),
        RegistrationCandidatoScreen.id: (context) => RegistrationCandidatoScreen(),
        RegistrationEmpresaScreen.id: (context) => RegistrationEmpresaScreen(),
        CandidatoScreen.id: (context) => CandidatoScreen(),
        EmpresaScreen.id: (context) => EmpresaScreen(),
        ConfirmacaoScreen.id: (context) => ConfirmacaoScreen(),
      },
    );
  }
}
