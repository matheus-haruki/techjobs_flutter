import 'package:flutter/material.dart';
import 'package:flutter_chat/screens/registration_screen.dart';
import 'package:flutter_chat/constants.dart';
import 'package:flutter_svg/svg.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, RegistrationScreen.id),
              child: SizedBox(
                width: 250,
                height: 280, // Aumentei a altura para acomodar o texto
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 2.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 65,
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: SvgPicture.asset('assets/images/candidatos.svg'),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      child: Text(
                        'Sou candidato',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, RegistrationScreen.id),
              child: SizedBox(
                width: 250,
                height: 280, // Aumentei a altura para acomodar o texto
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 2.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 65,
                      child: SizedBox(
                        height: 120,
                        width: 120,
                        child: SvgPicture.asset('assets/images/empresa.svg'),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      child: Text(
                        'Sou empresa',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
