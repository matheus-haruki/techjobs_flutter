import 'package:TechJobs/models/vaga_request.dart';
import 'package:TechJobs/services/formatter.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import 'package:TechJobs/components/custom_nav_bars.dart';
import 'empresa_screen.dart';
import 'vagas_cadastradas_screen.dart';
import '../../components/input.dart';
import 'package:TechJobs/services/api_services.dart';

class CriarVagasScreen extends StatefulWidget {
  static const String id = 'criar_vagas_screen';

  @override
  _CriarVagasScreenState createState() => _CriarVagasScreenState();
}

class _CriarVagasScreenState extends State<CriarVagasScreen> {
  int _currentIndex = 1; // Índice 1 para "Criar Vagas"

  // Controladores dos campos
  final _nomeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _salarioController = TextEditingController();
  final _numeroController = TextEditingController();
  final _cepController = TextEditingController();

  // Chave do form para validação
  final _formKey = GlobalKey<FormState>();

  late final CurrencyTextInputFormatter _moneyFormatter;

  // Variáveis para os dropdowns
  String? _nivelExperiencia;
  String? _modeloTrabalho;

  final ApiService _apiService = ApiService();

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

  void _selectNivel(String nivel) {
    setState(() {
      _nivelExperiencia = nivel;
    });
  }

  void _selectModelo(String modelo) {
    setState(() {
      _modeloTrabalho = modelo;
    });
  }

  Future<void> _publicarVaga() async {
    if (_formKey.currentState!.validate()) {
      final request = AdicionarVagaRequest(
        nome: _nomeController.text,
        cargo: _nomeController.text,
        modelo: _modeloTrabalho ?? "",
        nivelExperiencia: _nivelExperiencia ?? "",
        cep: _cepController.text,
        numero: _numeroController.text,
        descricao: _descricaoController.text,
        salarioPrevisto: _moneyFormatter.getUnformattedValue().toDouble(),
      );

      await _apiService.adicionarVaga(request);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vaga publicada com sucesso!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Limpar campos
      _nomeController.clear();
      _descricaoController.clear();
      _salarioController.clear();
      _numeroController.clear();
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
    _nomeController.dispose();
    _descricaoController.dispose();
    _salarioController.dispose();
    _numeroController.dispose();
    _cepController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _moneyFormatter = CurrencyTextInputFormatter.currency(
      locale: "pt-BR",
      symbol: "R\$",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(
        context,
        'Cadastrar vaga',
        icon: false,
        icone: Icons.add_circle_outline,
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
                child: GestureDetector(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Informações',
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
                            label: 'Nome da Vaga',
                            required: true,
                            corInput: CorInput.Secundaria,
                            controller: _nomeController,
                            hintText: 'Ex: Desenvolvedor Flutter',
                          ),
                          SizedBox(height: 20.0),

                          // Descrição
                          Input(
                            label: 'Descrição da Vaga',
                            corInput: CorInput.Secundaria,
                            controller: _descricaoController,
                            required: true,
                            hintText:
                                'Descreva as responsabilidades e requisitos',
                            maxLines: 3,
                          ),

                          SizedBox(height: 20.0),
                          Input(
                            label: 'Salário (R\$)',
                            corInput: CorInput.Secundaria,
                            controller: _salarioController,
                            required: true,
                            hintText: 'Ex: 5.000,00',
                            keyboardType: TextInputType.number,
                            inputFormatters: [_moneyFormatter],
                          ),
                          SizedBox(height: 20.0),

                          // Salário e Localização
                          Row(
                            children: [
                              Expanded(
                                child: Input(
                                  label: 'CEP',
                                  corInput: CorInput.Secundaria,
                                  controller: _cepController,
                                  required: true,
                                  hintText: 'Ex: 00000-000',
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [CepFormatter()],
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: Input(
                                  label: 'Número',
                                  required: true,
                                  corInput: CorInput.Secundaria,
                                  controller: _numeroController,
                                  hintText: '11B',
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
                                  corInput: CorInput.Secundaria,
                                  value: _nivelExperiencia,
                                  itemLabel: (valor) => valor,
                                  items: _niveisExperiencia,
                                  required: true,
                                  onChanged: (valor) =>
                                      _selectNivel(valor ?? ""),
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Expanded(
                                child: InputDropdown(
                                  label: 'Modelo',
                                  corInput: CorInput.Secundaria,
                                  value: _modeloTrabalho,
                                  items: _modelosTrabalho,
                                  itemLabel: (valor) => valor,
                                  required: true,
                                  onChanged: (valor) =>
                                      _selectModelo(valor ?? ""),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24.0), // Espaçamento fixo
                          // Botão para publicar
                          Center(
                            child: Container(
                              child: BtnPadrao(
                                title: 'Adicionar',
                                color: kCorSecundaria,
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
