import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import 'package:TechJobs/components/custom_nav_bars.dart';
import 'empresa_screen.dart';
import 'vagas_cadastradas_screen.dart';
import '../../components/input.dart';

class CriarVagasScreen extends StatefulWidget {
  static const String id = 'criar_vagas_screen';

  @override
  _CriarVagasScreenState createState() => _CriarVagasScreenState();
}

class _CriarVagasScreenState extends State<CriarVagasScreen> {
  int _currentIndex = 1; // Índice 1 para "Criar Vagas"

  // Controladores dos campos
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _salarioController = TextEditingController();
  final _localizacaoController = TextEditingController();

  // Chave do form para validação
  final _formKey = GlobalKey<FormState>();

  // Variáveis para os dropdowns
  String? _nivelExperiencia;
  String? _modeloTrabalho;

  // Controle de visibilidade dos dropdowns customizados
  bool _showNivelDropdown = false;
  bool _showModeloDropdown = false;

  // Variável para controlar se um dropdown está aberto

  // Listas para os dropdowns
  final List<String> _niveisExperiencia = [
    'Estagiário',
    'Júnior',
    'Pleno',
    'Sênior',
  ];

  final List<String> _modelosTrabalho = ['Presencial', 'Remoto', 'Híbrido'];

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
        // Já está na tela de Criar Vagas
        break;
      case 2:
        // Navegar para Vagas Cadastradas
        Navigator.pushReplacementNamed(context, VagasCadastradasScreen.id);
        break;
    }
  }

  void _toggleNivelDropdown() {
    setState(() {
      _showNivelDropdown = !_showNivelDropdown;
      _showModeloDropdown = false; // Fechar o outro
    });
  }

  void _toggleModeloDropdown() {
    setState(() {
      _showModeloDropdown = !_showModeloDropdown;
      _showNivelDropdown = false; // Fechar o outro
    });
  }

  void _selectNivel(String nivel) {
    setState(() {
      _nivelExperiencia = nivel;
      _showNivelDropdown = false;
    });
  }

  void _selectModelo(String modelo) {
    setState(() {
      _modeloTrabalho = modelo;
      _showModeloDropdown = false;
    });
  }

  void _closeAllDropdowns() {
    setState(() {
      _showNivelDropdown = false;
      _showModeloDropdown = false;
    });
  }

  void _publicarVaga() {
    if (_formKey.currentState!.validate()) {
      // Validar dropdowns
      if (_nivelExperiencia == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Nível'), backgroundColor: kVermelho),
        );
        return;
      }

      if (_modeloTrabalho == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Modelo'), backgroundColor: kVermelho),
        );
        return;
      }

      // Criar a nova vaga
      // final novaVaga = {
      //   'titulo': _tituloController.text,
      //   'descricao': _descricaoController.text,
      //   'salario': _salarioController.text,
      //   'localizacao': _localizacaoController.text,
      //   'nivelExperiencia': _nivelExperiencia,
      //   'modeloTrabalho': _modeloTrabalho,
      //   'candidatos': 0,
      //   'dataPublicacao': DateTime.now(),
      // };

      // Adicionar a vaga à lista global (ou salvar em banco de dados)

      // Mostrar mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vaga publicada com sucesso!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Limpar campos
      _tituloController.clear();
      _descricaoController.clear();
      _salarioController.clear();
      _localizacaoController.clear();
      setState(() {
        _nivelExperiencia = null;
        _modeloTrabalho = null;
      });

      // Navegar para a lista de vagas após 2 segundos
      Future.delayed(Duration(seconds: 2), () {});
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _salarioController.dispose();
    _localizacaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        'Cadastrar Vaga',
        icon: false,
        icone: Icons.add_circle_outline,
        gradientStart: kCorPrimaria,
        gradientEnd: kCorPrimariaEscura,
      ),
      backgroundColor: kCorPrimaria,
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
                child: GestureDetector(
                  onTap: _closeAllDropdowns,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nova Vaga',
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 28.0,
                              fontWeight: FontWeight.w600,
                              color: kPreto,
                            ),
                          ),
                          SizedBox(height: 24.0),

                          // Título da Vaga
                          Input(
                            label: 'Título da Vaga',
                            corInput: CorInput.Primaria,
                            controller: _tituloController,
                            hintText: 'Ex: Desenvolvedor Flutter',
                          ),
                          SizedBox(height: 20.0),

                          // Descrição
                          Input(
                            label: 'Descrição da Vaga',
                            corInput: CorInput.Primaria,
                            controller: _descricaoController,
                            hintText:
                                'Descreva as responsabilidades e requisitos',
                            maxLines: 3,
                          ),

                          SizedBox(height: 20.0),

                          // Salário e Localização
                          Row(
                            children: [
                              Expanded(
                                child: Input(
                                  label: 'Salário (R\$)',
                                  corInput: CorInput.Primaria,
                                  controller: _salarioController,
                                  hintText: 'Ex: 5.000,00',
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: Input(
                                  label: 'Localização',
                                  corInput: CorInput.Primaria,
                                  controller: _localizacaoController,
                                  hintText: 'São Paulo, SP',
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20.0),

                          // Nível de Experiência e Modelo de Trabalho
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: InputDropdown(
                                  label: 'Nível',
                                  corInput: CorInput.Primaria,
                                  currentValue: _nivelExperiencia,
                                  hintText: 'Nível',
                                  items: _niveisExperiencia,
                                  isOpen: _showNivelDropdown,
                                  onToggle: _toggleNivelDropdown,
                                  onSelect: _selectNivel,
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: InputDropdown(
                                  label: 'Modelo',
                                  corInput: CorInput.Primaria,
                                  currentValue: _modeloTrabalho,
                                  hintText: 'Modelo',
                                  items: _modelosTrabalho,
                                  isOpen: _showModeloDropdown,
                                  onToggle: _toggleModeloDropdown,
                                  onSelect: _selectModelo,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24.0), // Espaçamento fixo
                          // Botão para publicar
                          Center(
                            child: Container(
                              child: BtnPadrao(
                                title: 'Publicar Vaga',
                                color: kCorPrimaria,
                                onPressed: _publicarVaga,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
}
