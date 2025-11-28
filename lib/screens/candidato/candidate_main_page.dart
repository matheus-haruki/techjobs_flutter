import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import 'package:TechJobs/components/custom_nav_bars.dart';

class CandidateMainPage extends StatefulWidget {
  static const String id = 'candidate_main_page';

  @override
  _CandidateMainPageState createState() => _CandidateMainPageState();
}

class _CandidateMainPageState extends State<CandidateMainPage> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    // Navegação baseada no índice
    switch (index) {
      case 0:
        // Já está na Home
        setState(() {
          _currentIndex = 0;
        });
        break;
      case 1:
        // Navegar para Buscar Vagas - resetar para home
        setState(() {
          _currentIndex = 0;
        });
        Navigator.pushNamed(context, 'buscar_vagas_screen');
        break;
      case 2:
        // Navegar para Vagas Aplicadas
        setState(() {
          _currentIndex = 0;
        });
        Navigator.pushNamed(context, 'vagas_aplicadas_screen');
        break;
    }
  }

  Widget _buildHomePage() {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: kCorFundo,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Seção de Boas-vindas
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bem vindo, (nome do candidato)!',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        color: kPreto,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Encontre as melhores oportunidades em tecnologia',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    // Cards de estatísticas
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatCard(
                            '12',
                            'Vagas\nAplicadas',
                            kCorPrimaria,
                          ),
                          _buildStatCard(
                            '3',
                            'Processos\nAtivos',
                            kCorSecundaria,
                          ),
                          _buildStatCard(
                            '156',
                            'Novas Vagas\nDisponíveis',
                            Colors.green,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),

                    // Cards de ações rápidas
                    Text(
                      'Ações Rápidas',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kPreto,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildActionCard(
                            icon: Icons.search,
                            title: 'Buscar Vagas',
                            description: 'Encontre as melhores oportunidades',
                            color: kCorPrimaria,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                'buscar_vagas_screen',
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: _buildActionCard(
                            icon: Icons.work_outline,
                            title: 'Vagas Aplicadas',
                            description: 'Conheça as empresas parceiras',
                            color: kCorSecundaria,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                'vagas_aplicadas_screen',
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kPreto,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String number, String label, Color color) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        'Área do Candidato',
        icon: false,
        icone: Icons.notifications_outlined,
        gradientStart: kCorPrimaria,
        gradientEnd: kCorPrimariaEscura,
      ),
      backgroundColor: kCorPrimaria,
      body: _buildHomePage(),
      bottomNavigationBar: CandidatoNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
