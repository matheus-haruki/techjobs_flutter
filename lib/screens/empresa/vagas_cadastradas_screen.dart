import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import 'package:TechJobs/components/custom_nav_bars.dart';
import 'empresa_screen.dart';
import 'criar_vagas_screen.dart';
import 'detalhes_vaga_screen.dart';

class VagasCadastradasScreen extends StatefulWidget {
  static const String id = 'vagas_cadastradas_screen';

  // Lista estática para armazenar as vagas
  static List<Map<String, dynamic>> vagas = [
    {
      'titulo': 'Desenvolvedor Flutter',
      'descricao': 'Desenvolvimento de aplicativos móveis com Flutter',
      'salario': '8000',
      'localizacao': 'São Paulo, SP',
      'nivelExperiencia': 'Pleno',
      'modeloTrabalho': 'Híbrido',
      'candidatos': 25,
      'status': 'Ativa',
      'dataPublicacao': DateTime(2024, 1, 15),
    },
    {
      'titulo': 'Designer UI/UX',
      'descricao': 'Criação de interfaces e experiências do usuário',
      'salario': '6500',
      'localizacao': 'Rio de Janeiro, RJ',
      'nivelExperiencia': 'Júnior',
      'modeloTrabalho': 'Remoto',
      'candidatos': 12,
      'status': 'Ativa',
      'dataPublicacao': DateTime(2024, 1, 10),
    },
  ];

  // Método estático para adicionar nova vaga
  static void adicionarVaga(Map<String, dynamic> novaVaga) {
    vagas.insert(0, novaVaga); // Adiciona no início da lista
  }

  @override
  _VagasCadastradasScreenState createState() => _VagasCadastradasScreenState();
}

class _VagasCadastradasScreenState extends State<VagasCadastradasScreen> {
  int _currentIndex = 2; // Índice 2 para "Vagas Cadastradas"

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    // Navegação baseada no índice
    switch (index) {
      case 0:
        // Navegar para Home (EmpresaScreen)
        Navigator.pushReplacementNamed(context, EmpresaScreen.id);
        break;
      case 1:
        // Navegar para Criar Vagas
        Navigator.pushReplacementNamed(context, CriarVagasScreen.id);
        break;
      case 2:
        // Já está na tela de Vagas Cadastradas
        break;
    }
  }

  // Método para retornar o ícone do modelo de trabalho
  IconData _getModeloIcon(String? modelo) {
    switch (modelo) {
      case 'Presencial':
        return Icons.business;
      case 'Remoto':
        return Icons.home;
      case 'Híbrido':
        return Icons.swap_horiz;
      default:
        return Icons.work;
    }
  }

  // Método para navegar para detalhes da vaga
  void _navegarParaDetalhesVaga(Map<String, dynamic> vaga, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalhesVagaScreen(vaga: vaga, vagaIndex: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        'Vagas Cadastradas',
        icon: false,
        icone: Icons.list_alt,
        gradientStart: kCorSecundaria,
        gradientEnd: kCorSecundariaEscura,
      ),
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
                  color: kCorFundo,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Minhas Vagas',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 28.0,
                              fontWeight: FontWeight.w600,
                              color: kPreto,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: kCorSecundariaEscura,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${VagasCadastradasScreen.vagas.length} vagas',
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
                      SizedBox(height: 24.0),

                      Expanded(
                        child: ListView.builder(
                          itemCount: VagasCadastradasScreen.vagas.length,
                          itemBuilder: (context, index) {
                            final vaga = VagasCadastradasScreen.vagas[index];

                            return InkWell(
                              onTap: () {
                                // Navegar para detalhes da vaga ao clicar no card
                                _navegarParaDetalhesVaga(vaga, index);
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                margin: EdgeInsets.only(bottom: 16.0),
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.05,
                                      ),
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            vaga['titulo'],
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w800,
                                              color: kPreto,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // Deletar vaga
                                            _mostrarDialogoExclusao(
                                              context,
                                              vaga['titulo'],
                                              index,
                                            );
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: kVermelho,
                                          ),
                                          constraints: BoxConstraints(),
                                          padding: EdgeInsets.all(4),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),

                                    Row(
                                      children: [
                                        SizedBox(width: 4),
                                        Text(
                                          'R\$ ${vaga['salario']}',
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.green,
                                          ),
                                        ),
                                        SizedBox(width: 16),
                                        Icon(
                                          Icons.location_on,
                                          size: 16,
                                          color: Colors.grey[600],
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          vaga['localizacao'],
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 28.0),

                                    // BADGES Nível de Experiência e Modelo de Trabalho e candidatos inscritos
                                    Row(
                                      children: [
                                        // Nível de Experiência
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: kCorPrimaria.withValues(
                                              alpha: 0.1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            vaga['nivelExperiencia'] ?? 'N/A',
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600,
                                              color: kCorPrimaria,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        // Modelo de Trabalho
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: kCorSecundaria.withValues(
                                              alpha: 0.1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                _getModeloIcon(
                                                  vaga['modeloTrabalho'],
                                                ),
                                                size: 12,
                                                color: kCorSecundaria,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                vaga['modeloTrabalho'],
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: kCorSecundaria,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        // Badge Candidatos
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: kCorPrimaria.withValues(
                                              alpha: 0.1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.person,
                                                size: 12,
                                                color: kCorPrimaria,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                '${vaga['candidatos']}',
                                                style: TextStyle(
                                                  fontFamily: 'Montserrat',
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: kCorPrimaria,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 2.0),
                                  ],
                                ),
                              ),
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
      bottomNavigationBar: EmpresaNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }

  void _mostrarDialogoExclusao(BuildContext context, String titulo, int index) {
    showDialog(
      context: context,
      barrierDismissible: false, // Impede fechar tocando fora
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Bordas arredondadas
          ),
          backgroundColor: Colors.white,
          elevation: 8,
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ícone de aviso
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.red.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    size: 32,
                    color: Colors.red,
                  ),
                ),

                SizedBox(height: 16),

                // Título
                Text(
                  'Excluir Vaga',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: kPreto,
                  ),
                ),

                SizedBox(height: 12),

                // Conteúdo
                Text(
                  'Tem certeza que deseja excluir a vaga "$titulo"?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),

                Text(
                  'Esta ação não pode ser desfeita.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[500],
                    height: 1.4,
                  ),
                ),

                SizedBox(height: 24),

                // Botões
                Row(
                  children: [
                    // Botão Cancelar
                    Expanded(
                      child: Container(
                        height: 48,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 12),

                    // Botão Excluir
                    Expanded(
                      child: Container(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              VagasCadastradasScreen.vagas.removeAt(index);
                            });
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Vaga "$titulo" excluída com sucesso!',
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                margin: EdgeInsets.all(16),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            'Excluir',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
