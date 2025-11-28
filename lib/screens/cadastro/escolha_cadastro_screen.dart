import 'package:flutter/material.dart';
import 'package:TechJobs/screens/cadastro/registration_candidato_screen.dart';
import 'package:TechJobs/constants.dart';
import 'package:TechJobs/screens/cadastro/registration_empresa_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:io';

class EscolhaCadastroScreen extends StatefulWidget {
  static const String id = 'escolha_cadastro_screen'; // ID único para esta tela

  @override
  _EscolhaCadastroScreenState createState() => _EscolhaCadastroScreenState();
}

class _EscolhaCadastroScreenState extends State<EscolhaCadastroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCorFundo,
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            if (Platform.isIOS) SizedBox(height: 45),
            SizedBox(height: 72, child: Image.asset('assets/images/logo.png')),
            SizedBox(height: 35.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BotaoEscolha(
                    urlImagem: 'assets/images/candidatos.svg',
                    titulo: 'Sou candidato',
                    onPressed: () => Navigator.pushNamed(
                      context,
                      RegistrationCandidatoScreen.id,
                    ),
                  ),
                  BotaoEscolha(
                    urlImagem: 'assets/images/empresa.svg',
                    titulo: 'Sou empresa',
                    onPressed: () => Navigator.pushNamed(
                      context,
                      RegistrationEmpresaScreen.id,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BotaoEscolha extends StatelessWidget {
  BotaoEscolha({
    required this.urlImagem,
    required this.titulo,
    required this.onPressed,
  });

  final String urlImagem;
  final String titulo;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 220, // Aumentado 10%: 220 * 1.1 = 242
        height: 246, // Aumentado 10%: 246 * 1.1 = 271
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 220, // Aumentado 10%: 220 * 1.1 = 242
              height: 220, // Aumentado 10%: 220 * 1.1 = 242
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Colors.grey[300]!, width: 2.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 63, // Aumentado 10%: 57 * 1.1 = 63
              child: SizedBox(
                height: 117, // Aumentado 10%: 106 * 1.1 = 117
                width: 117, // Aumentado 10%: 106 * 1.1 = 117
                child: SvgPicture.asset(urlImagem),
              ),
            ),
            Positioned(
              bottom: 29, // Aumentado 10%: 26 * 1.1 = 29
              child: Text(
                titulo,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
