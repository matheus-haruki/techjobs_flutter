import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';
import 'package:TechJobs/components/custom_nav_bars.dart';
import 'empresa_screen.dart';

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
        Navigator.pushReplacementNamed(context, '');
        break;
    }
  }

  void _publicarVaga() {
    if (_formKey.currentState!.validate()) {
      // Validar dropdowns
      if (_nivelExperiencia == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Por favor, selecione o nível de experiência'),
            backgroundColor: kVermelho,
          ),
        );
        return;
      }

      if (_modeloTrabalho == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Por favor, selecione o modelo de trabalho'),
            backgroundColor: kVermelho,
          ),
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
      Future.delayed(Duration(seconds: 2), () {
      });
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
                            fontWeight: FontWeight.w900,
                            color: kPreto,
                          ),
                        ),
                        SizedBox(height: 24.0),

                        // Título da Vaga
                        Text(
                          'Título da Vaga',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: kPreto,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: kPreto, // Cor do texto digitado
                          ),
                          controller: _tituloController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o título da vaga';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Ex: Desenvolvedor Flutter',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: kCorPrimaria),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: kVermelho),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.0),

                        // Descrição
                        Text(
                          'Descrição da Vaga',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                            color: kPreto,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: kPreto, // Cor do texto digitado
                          ),
                          controller: _descricaoController,
                          maxLines: 4,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira a descrição da vaga';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText:
                                'Descreva as responsabilidades e requisitos...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: kCorPrimaria),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: kVermelho),
                            ),
                          ),
                        ),

                        SizedBox(height: 20.0),

                        // Salário e Localização
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Salário (R\$)',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      color: kPreto,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  TextFormField(
                                    controller: _salarioController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Insira o salário';
                                      }
                                      if (double.tryParse(value) == null) {
                                        return 'Valor inválido';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Ex: 5000',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: kCorPrimaria,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: kVermelho,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Localização',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      color: kPreto,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  TextFormField(
                                    controller: _localizacaoController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Insira a localização';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Ex: São Paulo, SP',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: kCorPrimaria,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: kVermelho,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.0),

                        // Nível de Experiência e Modelo de Trabalho
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nível',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      color: kPreto,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  DropdownButtonFormField<String>(
                                    initialValue: _nivelExperiencia,
                                    decoration: InputDecoration(
                                      hintText: '',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontFamily: 'Montserrat',
                                        fontSize: 16.0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: kCorPrimaria,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: kPreto,
                                    ),
                                    items: _niveisExperiencia.map((
                                      String nivel,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: nivel,
                                        child: Text(nivel),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _nivelExperiencia = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Modelo de Trabalho',
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w700,
                                      color: kPreto,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  DropdownButtonFormField<String>(
                                    initialValue: _modeloTrabalho,
                                    decoration: InputDecoration(
                                      hintText: '',
                                      hintStyle: TextStyle(
                                        color: Colors.grey[500],
                                        fontFamily: 'Montserrat',
                                        fontSize: 16.0,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: kCorPrimaria,
                                        ),
                                      ),
                                    ),
                                    style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: kPreto,
                                    ),
                                    items: _modelosTrabalho.map((
                                      String modelo,
                                    ) {
                                      return DropdownMenuItem<String>(
                                        value: modelo,
                                        child: Text(modelo),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _modeloTrabalho = newValue;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 40.0), // Espaço antes do botão
                        // Botão para publicar
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _publicarVaga,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kCorPrimaria,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Publicar Vaga',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
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
      bottomNavigationBar: EmpresaNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
