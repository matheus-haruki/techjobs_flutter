import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';

class CandidatoScreen extends StatefulWidget {
  static const String id = 'candidato_screen';

  @override
  _CandidatoScreenState createState() => _CandidatoScreenState();
}

class _CandidatoScreenState extends State<CandidatoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context, 'Candidato', icon: true),
      backgroundColor: kCorSecundaria,
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
                child: Row(crossAxisAlignment: CrossAxisAlignment.center),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
