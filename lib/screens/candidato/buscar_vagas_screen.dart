import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import 'package:TechJobs/components/custom_nav_bars.dart';
import '../../components/input.dart';
import 'candidate_main_page.dart';

class BuscarVagasScreen extends StatefulWidget {
  static const String id = 'buscar_vagas_screen';

  @override
  _BuscarVagasScreenState createState() => _BuscarVagasScreenState();
}

class _BuscarVagasScreenState extends State<BuscarVagasScreen> {
  int _currentIndex = 1; // Índice 1 para "Buscar Vagas"

  // Controllers
  final _searchController = TextEditingController();
  final _salarioInicioController = TextEditingController();
  final _salarioFimController = TextEditingController();

  // Filtros
  String? _nivelSelecionado;
  String? _modeloSelecionado;

  // Controle dos dropdowns
  bool _showNivelDropdown = false;
  bool _showModeloDropdown = false;

  // Controle de filtros ativos
  bool get _hasActiveFilters {
    return _searchController.text.isNotEmpty ||
        _salarioInicioController.text.isNotEmpty ||
        _salarioFimController.text.isNotEmpty ||
        _nivelSelecionado != null ||
        _modeloSelecionado != null;
  }

  // Listas para dropdowns
  final List<String> _niveis = ['Estagiário', 'Júnior', 'Pleno', 'Sênior'];
  final List<String> _modelos = ['Presencial', 'Remoto', 'Híbrido'];

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
        // Já está na tela de Buscar Vagas
        break;
      case 2:
        // Navegar para Vagas Aplicadas
        Navigator.pushReplacementNamed(context, 'vagas_aplicadas_screen');
        break;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _salarioInicioController.dispose();
    _salarioFimController.dispose();
    super.dispose();
  }

  void _closeAllDropdowns() {
    setState(() {
      _showNivelDropdown = false;
      _showModeloDropdown = false;
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: kCorFundo,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                // Handle bar
                Container(
                  width: 40,
                  height: 4,
                  margin: EdgeInsets.only(top: 12, bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),

                // Title
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filtros',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: kPreto,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setModalState(() {
                        _showNivelDropdown = false;
                        _showModeloDropdown = false;
                      });
                    },
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),

                          // Salário
                          Text(
                            'Faixa Salarial (R\$)',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: kPreto,
                            ),
                          ),
                          SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Input(
                                  label: 'Salário Inicial',
                                  corInput: CorInput.Primaria,
                                  controller: _salarioInicioController,
                                  hintText: 'Ex: 3.000',
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icon(Icons.attach_money),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Input(
                                  label: 'Salário Final',
                                  corInput: CorInput.Primaria,
                                  controller: _salarioFimController,
                                  hintText: 'Ex: 8.000',
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icon(Icons.attach_money),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24),

                          // Nível e Modelo
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: InputDropdown(
                                  label: 'Nível',
                                  corInput: CorInput.Primaria,
                                  currentValue: _nivelSelecionado,
                                  hintText: 'Nível',
                                  items: _niveis,
                                  isOpen: _showNivelDropdown,
                                  onToggle: () {
                                    setModalState(() {
                                      _showNivelDropdown = !_showNivelDropdown;
                                      _showModeloDropdown = false;
                                    });
                                  },
                                  onSelect: (String nivel) {
                                    setModalState(() {
                                      _nivelSelecionado = nivel;
                                      _showNivelDropdown = false;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: InputDropdown(
                                  label: 'Modelo',
                                  corInput: CorInput.Primaria,
                                  currentValue: _modeloSelecionado,
                                  hintText: 'Modelo',
                                  items: _modelos,
                                  isOpen: _showModeloDropdown,
                                  onToggle: () {
                                    setModalState(() {
                                      _showModeloDropdown =
                                          !_showModeloDropdown;
                                      _showNivelDropdown = false;
                                    });
                                  },
                                  onSelect: (String modelo) {
                                    setModalState(() {
                                      _modeloSelecionado = modelo;
                                      _showModeloDropdown = false;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 40),

                          // Botões
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(
                                        color: kCorPrimaria,
                                        width: 1.5,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      'Limpar',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: kCorPrimaria,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // Atualizar o estado principal para refletir mudanças no ícone
                                      setState(() {});
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kCorPrimaria,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      'Aplicar',
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _pesquisarVagas() {
    // Atualizar estado do botão de filtro
    setState(() {});
    // TODO: Implementar lógica de pesquisa
    String termoPesquisa = _searchController.text;
    if (termoPesquisa.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pesquisando por: "$termoPesquisa"'),
          backgroundColor: kCorPrimaria,
        ),
      );
    }
  }

  // Lista fictícia de vagas
  final List<Map<String, dynamic>> _vagasFicticias = [
    {
      'titulo': 'Desenvolvedor Flutter',
      'empresa': 'TechCorp Solutions',
      'descricao':
          'Desenvolvimento de aplicativos mobile usando Flutter. Experiência com Dart, API REST e Firebase.',
      'salario': 'R\$ 6.000,00',
      'localizacao': 'São Paulo, SP',
      'nivel': 'Pleno',
      'modelo': 'Híbrido',
      'candidatos': 12,
      'dataPublicacao': '2 dias atrás',
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
      'candidatos': 8,
      'dataPublicacao': '1 dia atrás',
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
      'candidatos': 15,
      'dataPublicacao': '3 dias atrás',
    },
    {
      'titulo': 'Estagiário Desenvolvedor',
      'empresa': 'StartupTech',
      'descricao':
          'Oportunidade para estagiário em desenvolvimento web. Aprendizado em HTML, CSS, JavaScript e frameworks modernos.',
      'salario': 'R\$ 1.200,00',
      'localizacao': 'São Paulo, SP',
      'nivel': 'Estagiário',
      'modelo': 'Híbrido',
      'candidatos': 25,
      'dataPublicacao': '5 dias atrás',
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
      'candidatos': 6,
      'dataPublicacao': '1 semana atrás',
    },
    {
      'titulo': 'Desenvolvedor Full Stack',
      'empresa': 'WebDev Pro',
      'descricao':
          'Desenvolvimento frontend e backend. Conhecimento em React, Node.js, PostgreSQL e AWS.',
      'salario': 'R\$ 9.000,00',
      'localizacao': 'Curitiba, PR',
      'nivel': 'Sênior',
      'modelo': 'Híbrido',
      'candidatos': 18,
      'dataPublicacao': '4 dias atrás',
    },
  ];

  List<Widget> _buildVagasList() {
    if (_vagasFicticias.isEmpty) {
      return [
        Container(
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.work_off, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'Nenhuma vaga encontrada',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    return _vagasFicticias.map((vaga) => _buildVagaCard(vaga)).toList();
  }

  Widget _buildVagaCard(Map<String, dynamic> vaga) {
    Color nivelColor;
    switch (vaga['nivel']) {
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

    Color modeloColor;
    switch (vaga['modelo']) {
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
        onTap: () {
          // TODO: Navegar para detalhes da vaga
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Abrindo detalhes da vaga: ${vaga['titulo']}'),
              backgroundColor: kCorPrimaria,
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header com empresa e data
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      vaga['empresa'],
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: kCorPrimaria,
                      ),
                    ),
                  ),
                  Text(
                    vaga['dataPublicacao'],
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              // Título da vaga
              Text(
                vaga['titulo'],
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
                vaga['descricao'],
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
                    vaga['salario'],
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
                      vaga['localizacao'],
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

              // Tags (nível, modelo) e candidatos
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
                      vaga['nivel'],
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
                      vaga['modelo'],
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: modeloColor,
                      ),
                    ),
                  ),

                  Spacer(),

                  // Botão Inscrever-se
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        'detalhes_vaga_screen',
                        arguments: vaga,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kCorPrimaria,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      minimumSize: Size(0, 36),
                    ),
                    child: Text(
                      'Inscrever-se',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        'Buscar Vagas',
        icon: false,
        icone: Icons.search,
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
                child: GestureDetector(
                  onTap: _closeAllDropdowns,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título
                        Text(
                          'Encontre sua vaga ideal',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 28.0,
                            fontWeight: FontWeight.w600,
                            color: kPreto,
                          ),
                        ),

                        SizedBox(height: 32),

                        // Barra de pesquisa e filtro
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Input(
                                label: 'Pesquisar',
                                corInput: CorInput.Primaria,
                                controller: _searchController,
                                hintText: 'Pesquise sua vaga',
                                prefixIcon: Icon(Icons.search),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.send, color: kCorPrimaria),
                                  onPressed: _pesquisarVagas,
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Padding(
                              padding: const EdgeInsets.only(top: 23.0),
                              child: Container(
                                height: 45,
                                child: Stack(
                                  children: [
                                    ElevatedButton(
                                      onPressed: _showFilterBottomSheet,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _hasActiveFilters
                                            ? kCorPrimariaEscura
                                            : kCorPrimaria,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                      ),
                                      child: Icon(
                                        _hasActiveFilters
                                            ? Icons.filter_alt
                                            : Icons.tune,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    // Badge indicador de filtros ativos
                                    if (_hasActiveFilters)
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 32),

                        // Lista de vagas
                        Text(
                          'Vagas Disponíveis',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: kPreto,
                          ),
                        ),
                        SizedBox(height: 16),

                        // Lista de vagas fictícias
                        SingleChildScrollView(
                          child: Column(children: _buildVagasList()),
                        ),
                      ],
                    ),
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
