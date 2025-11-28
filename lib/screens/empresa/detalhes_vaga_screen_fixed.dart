import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import 'package:TechJobs/components/custom_nav_bars.dart';

class DetalhesVagaScreen extends StatefulWidget {
  final Map<String, dynamic> vaga;
  final int vagaIndex;

  const DetalhesVagaScreen({
    super.key,
    required this.vaga,
    required this.vagaIndex,
  });

  @override
  _DetalhesVagaScreenState createState() => _DetalhesVagaScreenState();
}

class _DetalhesVagaScreenState extends State<DetalhesVagaScreen> {
  // Lista de candidatos (agora como variável de estado)
  List<Map<String, dynamic>> candidatos = [
    {
      'nome': 'João Silva',
      'email': 'joao.silva@email.com',
      'experiencia': 'Pleno',
      'avatar': 'JS',
      'dataInscricao': DateTime(2024, 1, 16),
      'status': 'Novo',
    },
    {
      'nome': 'Maria Fernanda',
      'email': 'maria.fernanda@email.com',
      'experiencia': 'Sênior',
      'avatar': 'MF',
      'dataInscricao': DateTime(2024, 1, 17),
      'status': 'Analisado',
    },
    {
      'nome': 'Carlos Eduardo',
      'email': 'carlos.eduardo@email.com',
      'experiencia': 'Júnior',
      'avatar': 'CE',
      'dataInscricao': DateTime(2024, 1, 18),
      'status': 'Rejeitado',
    },
    {
      'nome': 'Ana Paula',
      'email': 'ana.paula@email.com',
      'experiencia': 'Pleno',
      'avatar': 'AP',
      'dataInscricao': DateTime(2024, 1, 19),
      'status': 'Novo',
    },
    {
      'nome': 'Pedro Santos',
      'email': 'pedro.santos@email.com',
      'experiencia': 'Sênior',
      'avatar': 'PS',
      'dataInscricao': DateTime(2024, 1, 20),
      'status': 'Aprovado',
    },
  ];

  void _aprovarCandidato(
    BuildContext context,
    Map<String, dynamic> candidato,
    int index,
  ) {
    setState(() {
      candidatos[index]['status'] = 'Aprovado';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${candidato['nome']} foi aprovado!',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.all(16),
      ),
    );
  }

  void _reprovarCandidato(
    BuildContext context,
    Map<String, dynamic> candidato,
    int index,
  ) {
    setState(() {
      candidatos[index]['status'] = 'Rejeitado';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${candidato['nome']} foi rejeitado.',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.all(16),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Novo':
        return Colors.blue;
      case 'Analisado':
        return Colors.orange;
      case 'Aprovado':
        return Colors.green;
      case 'Rejeitado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        'Inscritos',
        icon: false,
        icone: Icons.list_alt,
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
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Card de detalhes da vaga
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.vaga['titulo'],
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 24.0,
                                fontWeight: FontWeight.w800,
                                color: kPreto,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              widget.vaga['descricao'],
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[700],
                                height: 1.5,
                              ),
                            ),
                            SizedBox(height: 16),
                            // Informações da vaga
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  size: 18,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'R\$ ${widget.vaga['salario']}',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Icon(
                                  Icons.location_on,
                                  size: 18,
                                  color: Colors.grey[600],
                                ),
                                SizedBox(width: 4),
                                Text(
                                  widget.vaga['localizacao'],
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            // Badges
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: kCorPrimaria.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    widget.vaga['nivelExperiencia'],
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: kCorPrimaria,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: kCorSecundaria.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    widget.vaga['modeloTrabalho'],
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: kCorSecundaria,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 32),

                      // Lista de candidatos
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Candidatos Inscritos',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w800,
                              color: kPreto,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: kCorPrimaria,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${candidatos.length} inscritos',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),

                      // Lista de candidatos
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: candidatos.length,
                        itemBuilder: (context, index) {
                          final candidato = candidatos[index];

                          return Container(
                            margin: EdgeInsets.only(bottom: 12),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Informações
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        candidato['nome'],
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: kPreto,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        candidato['email'],
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text(
                                            'Nível: ${candidato['experiencia']}',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          SizedBox(width: 12),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getStatusColor(
                                                candidato['status'],
                                              ).withValues(alpha: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              candidato['status'],
                                              style: TextStyle(
                                                fontFamily: 'Montserrat',
                                                fontSize: 12.0,
                                                fontWeight: FontWeight.w600,
                                                color: _getStatusColor(
                                                  candidato['status'],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),

                                // Aprovar ou reprovar
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Botão Aprovar
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          _aprovarCandidato(
                                            context,
                                            candidato,
                                            index,
                                          );
                                        },
                                        icon: Icon(
                                          Icons.check,
                                          color: Colors.green,
                                          size: 20,
                                        ),
                                        constraints: BoxConstraints(),
                                        padding: EdgeInsets.all(8),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    // Botão Reprovar
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.red.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: IconButton(
                                        onPressed: () {
                                          _reprovarCandidato(
                                            context,
                                            candidato,
                                            index,
                                          );
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                        constraints: BoxConstraints(),
                                        padding: EdgeInsets.all(8),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: EmpresaNav(
        currentIndex: 2, // Índice para "Vagas Cadastradas"
        onTap: (index) {
          // Navegar conforme o índice selecionado
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, 'empresa_screen');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, 'criar_vagas_screen');
              break;
            case 2:
              Navigator.pushReplacementNamed(
                context,
                'vagas_cadastradas_screen',
              );
              break;
          }
        },
      ),
    );
  }
}
