import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import 'package:TechJobs/components/btn_quadrado.dart';

class EmpresaScreen extends StatefulWidget {
  static const String id = 'empresa_screen';

  @override
  _EmpresaScreenState createState() => _EmpresaScreenState();
}

class _EmpresaScreenState extends State<EmpresaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, 'Empresa', icon: true, icone: Icons.business, gradientStart: kCorPrimaria, gradientEnd: kCorPrimariaEscura),
      backgroundColor: kCorPrimaria,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: kCorFundo, // Adicionado: cor do container
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                ), // Corrigido: fechamento da decoration
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //TODO: Fazer implementação dos botões
                    BtnPadraoSquare(
                      onTap: () {
                        // Ação ao clicar no botão
                      },
                      icon: Icons.add,
                      textBtn: 'Cadastrar vagas',
                      secondTextBtn: 'publicadas',
                      iconColor: kCorPrimaria,
                      bgIconColor: kCorFundo,
                    ),
                    BtnPadraoSquare(
                      onTap: () {
                        // Ação ao clicar no botão
                      },
                      icon: Icons.work,
                      textBtn: 'Vagas Publicadas',
                      secondTextBtn: 'publicadas',
                      iconColor: kCorPrimaria,
                      bgIconColor: kCorFundo,
                    ),
                    // BtnPadraoSquare(
                    //   onTap: () {
                    //     // Ação ao clicar no botão
                    //   },
                    //   icon: 'assets/icons/candidatos.svg',
                    //   textBtn: 'Candidatos',
                    //   secondTextBtn: 'recebidos',
                    //   iconColor: kCorPrimaria,
                    //   bgIconColor: kCorFundo,
                    // ),
                    // BtnPadraoSquare(
                    //   onTap: () {
                    //     // Ação ao clicar no botão
                    //   },
                    //   icon: 'assets/icons/estatisticas.svg',
                    //   textBtn: 'Estatísticas',
                    //   iconColor: kCorPrimaria,
                    //   bgIconColor: kCorFundo,
                    // ),
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
