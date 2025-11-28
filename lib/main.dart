import 'package:TechJobs/screens/cadastro/confirmacao_screen.dart';
import 'package:TechJobs/screens/empresa/empresa_screen.dart';
import 'package:flutter/material.dart';
import 'package:TechJobs/screens/cadastro/registration_empresa_screen.dart';
import 'package:TechJobs/screens/welcome_screen.dart';
import 'package:TechJobs/screens/cadastro/login_screen.dart';
import 'package:TechJobs/screens/cadastro/registration_candidato_screen.dart';
import 'package:TechJobs/screens/cadastro/escolha_cadastro_screen.dart';
import 'package:TechJobs/screens/candidato/candidato_screen.dart';
// Adicionar imports das telas da empresa que estavam faltando
import 'package:TechJobs/screens/empresa/criar_vagas_screen.dart';
import 'package:TechJobs/screens/empresa/vagas_cadastradas_screen.dart';

void main() => runApp(TechJobsApp()); // Mudança de nome mais apropriada

class TechJobsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechJobs', // Adicionar título do app
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.black,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w400,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        EscolhaCadastroScreen.id: (context) => EscolhaCadastroScreen(),
        RegistrationCandidatoScreen.id: (context) =>
            RegistrationCandidatoScreen(),
        RegistrationEmpresaScreen.id: (context) => RegistrationEmpresaScreen(),
        CandidatoScreen.id: (context) => CandidatoScreen(),
        EmpresaScreen.id: (context) => EmpresaScreen(),
        ConfirmacaoScreen.id: (context) => ConfirmacaoScreen(),
        // Adicionar as rotas que estavam faltando
        CriarVagasScreen.id: (context) => CriarVagasScreen(),
        VagasCadastradasScreen.id: (context) => VagasCadastradasScreen(),
      },
    );
  }
}
