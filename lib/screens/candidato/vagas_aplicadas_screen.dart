import 'package:TechJobs/models/vagas_model.dart';
import 'package:TechJobs/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import 'package:TechJobs/components/custom_nav_bars.dart';
import 'candidate_main_page.dart';
import 'buscar_vagas_screen.dart';

class VagasAplicadasScreen extends StatefulWidget {
  static const String id = 'vagas_aplicadas_screen';

  @override
  _VagasAplicadasScreenState createState() => _VagasAplicadasScreenState();
}

class _VagasAplicadasScreenState extends State<VagasAplicadasScreen> {
  int _currentIndex = 2; // Índice 2 para "Vagas Aplicadas" (antes era 3)

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navegação baseada no índice
    switch (index) {
      case 0:
        // Navegar para Home (CandidateMainPage)
        Navigator.pushReplacementNamed(context, CandidateMainPage.id);
        break;
      case 1:
        // Navegar para Buscar Vagas
        Navigator.pushReplacementNamed(context, BuscarVagasScreen.id);
        break;
      case 2:
        // Já está na tela de Vagas Aplicadas
        break;
    }
  }

  // Lista fictícia de vagas aplicadas
  final List<Map<String, dynamic>> _vagasAplicadas = [
    {
      'titulo': 'Desenvolvedor Flutter',
      'empresa': 'TechCorp Solutions',
      'descricao':
          'Desenvolvimento de aplicativos mobile usando Flutter. Experiência com Dart, API REST e Firebase.',
      'salario': 'R\$ 6.000,00',
      'localizacao': 'São Paulo, SP',
      'nivel': 'Pleno',
      'modelo': 'Híbrido',
      'dataAplicacao': '3 dias atrás',
      'status': 'Em análise',
      'statusColor': Colors.orange,
    },
    {
      'titulo': 'Desenvolvedor React Native',
      'empresa': 'InnovaTech',
      'descricao':
          'Desenvolvimento de aplicações mobile multiplataforma. Conhecimento em JavaScript, React e Redux.',
      'salario': 'R\$ 7.500,00',
      'localizacao': 'Rio de Janeiro, RJ',
      'nivel': 'Sênior',
      'modelo': 'Remoto',
      'dataAplicacao': '1 semana atrás',
      'status': 'Aprovado',
      'statusColor': Colors.green,
    },
    {
      'titulo': 'Desenvolvedor iOS',
      'empresa': 'AppMakers Inc',
      'descricao':
          'Desenvolvimento nativo iOS usando Swift. Experiência com UIKit, Core Data e arquitetura MVVM.',
      'salario': 'R\$ 8.000,00',
      'localizacao': 'Belo Horizonte, MG',
      'nivel': 'Sênior',
      'modelo': 'Presencial',
      'dataAplicacao': '2 semanas atrás',
      'status': 'Recusado',
      'statusColor': Colors.red,
    },
    {
      'titulo': 'Desenvolvedor Backend Node.js',
      'empresa': 'CloudSystems',
      'descricao':
          'Desenvolvimento de APIs e microserviços. Experiência com Node.js, MongoDB e Docker.',
      'salario': 'R\$ 7.000,00',
      'localizacao': 'Florianópolis, SC',
      'nivel': 'Pleno',
      'modelo': 'Remoto',
      'dataAplicacao': '5 dias atrás',
      'status': 'Entrevista agendada',
      'statusColor': kCorPrimaria,
    },
  ];

  List<Widget> _buildVagasAplicadasList(List<Vaga> vagas) {
    if (vagas.isEmpty) {
      return [
        Container(
          height: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.work_history, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Você ainda não se aplicou para nenhuma vaga',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      BuscarVagasScreen.id,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kCorPrimaria,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Buscar Vagas',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    return vagas.map((vaga) => _buildVagaAplicadaCard(vaga)).toList();
  }

  Widget _buildVagaAplicadaCard(Vaga vaga) {
    Color nivelColor;
    switch (vaga.nivelExperiencia) {
      case 'Estagiário':
        nivelColor = Colors.blue;
        break;
      case 'Júnior':
        nivelColor = Colors.green;
        break;
      case 'Pleno':
        nivelColor = kCorSecundaria;
        break;
      case 'Sênior':
        nivelColor = Colors.purple;
        break;
      default:
        nivelColor = Colors.grey;
    }

    Color statusCor;
    switch (vaga.situacao) {
      case 1:
        statusCor = Colors.orange;
        break;
      case 2:
        statusCor = Colors.green;
        break;
      case 3:
        statusCor = Colors.red;
        break;
      default:
        statusCor = Colors.grey;
    }

    Color modeloColor;
    switch (vaga.modelo) {
      case 'Remoto':
        modeloColor = Colors.green;
        break;
      case 'Presencial':
        modeloColor = Colors.orange;
        break;
      case 'Híbrido':
        modeloColor = kCorPrimaria;
        break;
      default:
        modeloColor = Colors.grey;
    }

    final situacaoMap = {1: "Em análise", 2: "Aprovado", 3: "Reprovado"};

    return Container(
      margin: EdgeInsets.only(bottom: 16),
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
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header com empresa e status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      vaga.nomeEmpresa ?? "",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kCorPrimaria,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusCor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      situacaoMap[vaga.situacao ?? 1] ?? "",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: statusCor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              // Título da vaga
              Text(
                vaga.nome,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: kPreto,
                ),
              ),
              SizedBox(height: 8),

              // Descrição
              Text(
                vaga.descricao,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 12),

              // Salário e localização
              Row(
                children: [
                  Icon(Icons.attach_money, size: 16, color: Colors.green),
                  SizedBox(width: 4),
                  Text(
                    'R\$ ${vaga.salarioPrevisto}',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 16),
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      vaga.cep ?? "",
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),

              // Tags (nível, modelo) e data de aplicação
              Row(
                children: [
                  // Tag de nível
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: nivelColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      vaga.nivelExperiencia,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: nivelColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),

                  // Tag de modelo
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: modeloColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      vaga.modelo,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: modeloColor,
                      ),
                    ),
                  ),

                  Spacer(),

                  // Data de aplicação
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Aplicado há ${vaga.dataCadastro.toString()}',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        'Vagas aplicadas',
        icon: false,
        icone: Icons.work_history,
        gradientStart: kCorPrimaria,
        gradientEnd: kCorPrimariaEscura,
      ),
      backgroundColor: kCorPrimaria,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: kCorFundo,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título
                      Text(
                        'Minhas candidaturas',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 28.0,
                          fontWeight: FontWeight.w600,
                          color: kPreto,
                        ),
                      ),

                      SizedBox(height: 8),

                      // Subtítulo
                      Text(
                        'Acompanhe o status das suas aplicações',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),

                      SizedBox(height: 32),

                      // Lista de vagas aplicadas
                      SingleChildScrollView(
                        child: FutureBuilder(
                          future: _apiService.ObterAplicacoes(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            final vagas = snapshot.data!;

                            return Column(
                              children: _buildVagasAplicadasList(vagas),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
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
