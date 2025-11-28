import 'package:TechJobs/constants.dart';
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
        SizedBox(height: 5),
        TextField(
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

class InputDropdown extends StatelessWidget {
  final String label;
  final CorInput corInput;
  final String? currentValue;
  final String? hintText;
  final List<String> items;
  final bool isOpen;
  final VoidCallback onToggle;
  final Function(String) onSelect;

  const InputDropdown({
    super.key,
    required this.label,
    required this.corInput,
    required this.items,
    required this.isOpen,
    required this.onToggle,
    required this.onSelect,
    this.currentValue,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    // Calcular altura do dropdown baseado no número de itens
    double dropdownHeight = isOpen ? (items.length * 48.0) + 8 : 0;

    return Container(
      height:
          56 +
          dropdownHeight +
          29, // Altura: label (24px) + espaço (5px) + campo (56px) + dropdown
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label igual ao Input
          Text(
            label,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),

          // Dropdown customizado
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Campo principal
                GestureDetector(
                  onTap: onToggle,
                  child: Container(
                    height: 56, // Altura fixa para o campo
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isOpen
                            ? (corInput == CorInput.Primaria
                                  ? kCorPrimariaEscura
                                  : kCorSecundariaEscura)
                            : (corInput == CorInput.Primaria
                                  ? kCorPrimaria
                                  : kCorSecundaria),
                        width: isOpen ? 2 : 1.5,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currentValue ?? hintText ?? '',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: currentValue != null
                                ? Colors.black
                                : Colors.grey[600],
                          ),
                        ),
                        Icon(
                          isOpen
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.grey[600],
                        ),
                      ],
                    ),
                  ),
                ),

                // Lista dropdown
                if (isOpen)
                  Container(
                    height: dropdownHeight - 8,
                    margin: EdgeInsets.only(top: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: items.map((item) {
                          return GestureDetector(
                            onTap: () => onSelect(item),
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color:
                                        items.indexOf(item) == items.length - 1
                                        ? Colors.transparent
                                        : Colors.grey[200]!,
                                  ),
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey[800],
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
