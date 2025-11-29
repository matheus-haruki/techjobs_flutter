import 'package:TechJobs/models/dados_usuario_model.dart';
import 'package:TechJobs/services/api_services.dart';
import 'package:TechJobs/services/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import 'package:TechJobs/components/custom_nav_bars.dart';
import 'package:TechJobs/screens/empresa/criar_vagas_screen.dart';
import 'package:TechJobs/screens/empresa/vagas_cadastradas_screen.dart';

class EmpresaScreen extends StatefulWidget {
  static const String id = 'empresa_screen';

  @override
  _EmpresaScreenState createState() => _EmpresaScreenState();
}

class _EmpresaScreenState extends State<EmpresaScreen> {
  int _currentIndex = 0; // Índice 0 para "Home"

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        // Já está na Home
        break;
      case 1:
        Navigator.pushNamed(context, CriarVagasScreen.id);
        break;
      case 2:
        Navigator.pushNamed(context, VagasCadastradasScreen.id);
        break;
    }
  }

  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        'Área da Empresa',
        icon: false,
        icone: Icons.add_circle_outline,
        gradientStart: kCorSecundaria,
        gradientEnd: kCorSecundariaEscura,
      ),
      backgroundColor: kCorSecundaria,
      body: SafeArea(
        child: FutureBuilder<UserModel?>(
          future: StorageManager.instance.getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            final user = snapshot.data;

            return Column(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bem vindo, ${user?.nomeUsuario}!',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600,
                                              color: kPreto,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            'Gerencie suas vagas e encontre os melhores talentos',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
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
                          Container(
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
                            child: FutureBuilder(
                              future: _apiService.obterDadosDashboardEmpresa(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }

                                final dados = snapshot.data!;

                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildStatCard(
                                      dados.vagasDisponiveis.toString(),
                                      'Vagas Ativas',
                                      kCorSecundaria,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Colors.grey[300],
                                    ),
                                    _buildStatCard(
                                      dados.candidatos.toString(),
                                      'Candidatos',
                                      kCorSecundaria,
                                    ),
                                    Container(
                                      height: 50,
                                      width: 1,
                                      color: Colors.grey[300],
                                    ),
                                    _buildStatCard(
                                      dados.aprovacoes.toString(),
                                      'Aprovações',
                                      Colors.green,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 25),
                          // Ações Rápidas
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

                          // Cards de Ação
                          Row(
                            children: [
                              Expanded(
                                child: _buildActionCard(
                                  icon: Icons.add_circle_outline,
                                  title: 'Criar Vaga',
                                  description:
                                      'Publique uma nova vaga de emprego',
                                  color: kCorSecundaria,
                                  onTap: () => _onTabTapped(1),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: _buildActionCard(
                                  icon: Icons.list_alt,
                                  title: 'Minhas Vagas',
                                  description: 'Gerencie suas vagas publicadas',
                                  color: kCorSecundaria,
                                  onTap: () => _onTabTapped(2),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24),

                          // Estatísticas
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: EmpresaNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
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
        ),
      ],
    );
  }
}
