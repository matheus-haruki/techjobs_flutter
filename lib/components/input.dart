import 'package:TechJobs/constants.dart';
import 'package:flutter/material.dart';

enum CorInput { Primaria, Secundaria }

extension EstiloCorInput on CorInput {
  InputDecoration get estilo {
    switch (this) {
      case CorInput.Primaria:
        return InputDecoration(
          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1.5,
              color: kCorPrimaria,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 2,
              color: kCorPrimariaEscura,
            ),
          ),
        );
      case CorInput.Secundaria:
        return InputDecoration(
          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1.5,
              color: kCorSecundaria,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 2,
              color: kCorSecundariaEscura,
            ),
          ),
        );
    }
  }
}

class Input extends StatelessWidget {
  final String label;
  final CorInput corInput;
  final TextEditingController controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool? obscureText;

  const Input({
    super.key,
    required this.label,
    required this.corInput,
    required this.controller,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        TextField(
          controller: controller,
          style: kInputStyle,
          obscureText: obscureText ?? false,
          decoration: corInput.estilo.copyWith(
            hintText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
