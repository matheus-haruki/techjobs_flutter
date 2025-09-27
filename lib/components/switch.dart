import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:flutter_chat/constants.dart'; // Certifique-se de que este import está correto

class SwitchPersonalizado extends StatefulWidget {
  final String textoAtivo;
  final String textoInativo;
  final bool valorInicial;
  final ValueChanged<bool>? onChanged;

  const SwitchPersonalizado({
    super.key,
    required this.textoAtivo,
    required this.textoInativo,
    this.valorInicial = false,
    this.onChanged,
  });

  @override
  State<SwitchPersonalizado> createState() => _SwitchPersonalizadoState();
}

class _SwitchPersonalizadoState extends State<SwitchPersonalizado> {
  // O controller continua sendo a fonte da verdade para o estado do switch
  late final ValueNotifier<bool> _controller;

  @override
  void initState() {
    super.initState();
    _controller = ValueNotifier<bool>(widget.valorInicial);

    // O listener agora tem uma única responsabilidade: notificar o widget pai.
    // Não precisamos mais do setState() aqui.
    _controller.addListener(() {
      widget.onChanged?.call(_controller.value);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✨ 1. Usando ValueListenableBuilder para reconstruir apenas o necessário
    return ValueListenableBuilder<bool>(
      valueListenable: _controller,
      builder: (context, isAtivo, child) {
        // 'isAtivo' é o valor atual do _controller.
        // 'child' é um widget opcional que não é reconstruído (não usado aqui).
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center, // Centraliza o texto
          children: [
            AdvancedSwitch(
              width: 50,
              height: 30,
              activeColor: kCorPrimaria,
              inactiveColor: kCorSecundaria,
              activeChild: const Icon(
                Icons.business,
                color: Colors.white,
                size: 20,
              ),
              inactiveChild: const Icon(
                Icons.person,
                color: Colors.white,
                size: 20,
              ),
              controller: _controller, // O switch continua a usar o controller
            ),
            // ✨ 2. Correção de layout: SizedBox com 'height' dentro de uma Column
            const SizedBox(height: 8),
            Text(
              isAtivo ? widget.textoAtivo : widget.textoInativo,
              style: const TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16.0,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        );
      },
    );
  }
}
