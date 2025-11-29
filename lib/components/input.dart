import 'package:TechJobs/constants.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum CorInput { Primaria, Secundaria }

extension EstiloCorInput on CorInput {
  InputDecoration get estilo {
    switch (this) {
      case CorInput.Primaria:
        return InputDecoration(
          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1.5, color: kCorPrimaria),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2, color: kCorPrimariaEscura),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2, color: kVermelhoClaro),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2, color: kVermelho),
          ),
          errorStyle: TextStyle(color: kVermelho),
        );
      case CorInput.Secundaria:
        return InputDecoration(
          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1.5, color: kCorSecundaria),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2, color: kCorSecundariaEscura),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2, color: kVermelhoClaro),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 2, color: kVermelho),
          ),
          errorStyle: TextStyle(color: kVermelho),
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
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final String? Function(String?)? customValidator;
  final bool required;

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
    this.maxLines,
    this.inputFormatters,
    this.onChanged,
    this.focusNode,
    this.customValidator,
    this.required = false,
  });

  String? defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }

    return null;
  }

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
        SizedBox(height: 5),
        TextFormField(
          validator: required ? customValidator ?? defaultValidator : null,
          controller: controller,
          focusNode: focusNode,
          style: kInputStyle,
          obscureText: obscureText ?? false,
          maxLines: maxLines ?? 1,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
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

class InputDropdown<T> extends StatefulWidget {
  final String label;
  final CorInput corInput;
  final T? value;
  final List<T> items;
  final String Function(T) itemLabel;
  final Function(T?)? onChanged;
  final String? Function(T?)? customValidator;
  final FocusNode? focusNode;
  final bool required;

  const InputDropdown({
    super.key,
    required this.label,
    required this.corInput,
    required this.items,
    required this.itemLabel,
    this.value,
    this.onChanged,
    this.customValidator,
    this.focusNode,
    this.required = false,
  });

  @override
  _InputDropdownState<T> createState() => _InputDropdownState<T>();
}

class _InputDropdownState<T> extends State<InputDropdown<T>> {
  late FocusNode _focusNode;
  bool _isDropdownOpen = false;

  String? _defaultValidator(T? value) {
    if (value == null) {
      return 'Campo obrigatório';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    // Listen for focus changes to determine if the dropdown is open
    _focusNode.addListener(() {
      setState(() {
        _isDropdownOpen = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.label,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 5),
        DropdownButtonFormField<T>(
          focusNode: _focusNode,
          initialValue: widget.value,
          onChanged: widget.onChanged,
          decoration: widget.corInput.estilo.copyWith(
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            prefixIcon: null,
            suffixIcon: Icon(
              _isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: Colors.grey[600],
            ),
          ),
          dropdownColor: Colors.white,
          hint: Text("-- Selecione uma opção --", style: TextStyle(color: Colors.grey[600]),),
          validator: widget.required
              ? widget.customValidator ?? _defaultValidator
              : null,
          items: widget.items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(widget.itemLabel(item)),
            );
          }).toList(),
        ),
      ],
    );
  }
}
