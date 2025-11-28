import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import 'package:TechJobs/components/custom_nav_bars.dart';
import 'package:TechJobs/screens/tabs/home_placeholder.dart';
import 'package:TechJobs/screens/tabs/buscar_vagas_page.dart';
class CandidatoScreen extends StatefulWidget {
  static const String id = 'candidato_screen';

  @override
  _CandidatoScreenState createState() => _CandidatoScreenState();
}

class _CandidatoScreenState extends State<CandidatoScreen> {
  int _currentIndex = 0;

  // Lista de páginas para navegação
  final List<Widget> _pages = [
    HomePlaceholder(),
    BuscarVagasPage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        'Candidato',
        gradientStart: kCorSecundaria,
        gradientEnd: kCorSecundariaEscura,
      ),
      backgroundColor: kCorSecundaria,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: kCorFundo,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: _pages[_currentIndex],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CandidatoNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
