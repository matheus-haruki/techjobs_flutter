import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
// Certifique-se de que este import está correto para seu projeto
import 'package:flutter_chat/constants.dart';

class SwitchPersonalizado extends StatefulWidget {
  // 1. Parâmetros para tornar o componente configurável
  final String textoAtivo;
  final String textoInativo;
  final bool valorInicial;
  final ValueChanged<bool>? onChanged; // Callback para notificar o widget "pai"

  const SwitchPersonalizado({
    super.key,
    required this.textoAtivo,
    required this.textoInativo,
    this.valorInicial = false, // Valor padrão é 'false'
    this.onChanged, // O callback é opcional
  });

  @override
  State<SwitchPersonalizado> createState() => _SwitchPersonalizadoState();
}

class _SwitchPersonalizadoState extends State<SwitchPersonalizado> {
  late final ValueNotifier<bool> _controller;

  @override
  void initState() {
    super.initState();
    // 2. Inicializa o controller com o valor recebido via parâmetro
    _controller = ValueNotifier<bool>(widget.valorInicial);

    _controller.addListener(() {
      setState(() {
        // Notifica o widget pai sobre a mudança através do callback
        widget.onChanged?.call(_controller.value);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 3. O layout do componente agora é genérico
    return Column(
      mainAxisSize: MainAxisSize.min, // Para a Row ocupar o mínimo de espaço
      children: [
        AdvancedSwitch(
          width: 50,
          height: 30,
          activeColor: kCorSecundaria,
          inactiveColor: kCorPrimaria,
          // ✨ CORREÇÃO APLICADA AQUI ✨
          activeChild: const Icon(Icons.person, color: Colors.white, size: 20),
          inactiveChild: const Icon(Icons.business, color: Colors.white, size: 20),
          controller: _controller,
        ),
        const SizedBox(width: 16),
        Text(
          // Usa os textos recebidos via parâmetro
          _controller.value ? widget.textoAtivo : widget.textoInativo,
          style: const TextStyle(fontFamily: 'Montserrat', fontSize: 16.0, fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}
