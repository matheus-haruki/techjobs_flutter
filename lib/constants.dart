import 'package:flutter/material.dart';

const kCorPrimaria = Color(0xFF5E93AD);
const kCorPrimariaEscura = Color(0xFF3A708A);
const kCorSecundaria = Color(0xFFFF9900);
const kCorSecundariaEscura = Color(0xFFD07D00);
const kCorFundo = Color(0xFFF3F3F3);
const kBranco = Color(0xFFFFFFFF);
const kCinza = Color(0xFF686868);
const kPreto = Color(0xFF000000);

const kSendButtonTextStyle = TextStyle(color: Colors.lightBlueAccent, fontWeight: FontWeight.bold, fontSize: 18.0);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(top: BorderSide(color: Colors.lightBlueAccent, width: 2.0)),
);

class BtnPadrao extends StatelessWidget {
  BtnPadrao({required this.title, this.color, required this.onPressed});

  final Color? color;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(fontFamily: 'Montserrat', fontSize: 16.0, fontWeight: FontWeight.w800, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

final kTextFieldDecoration = InputDecoration(
  hintText: 'E-mail',
  hintStyle: TextStyle(
    color: Colors.grey[600], // Cor do texto da dica
    fontSize: 16.0, // Tamanho da fonte
  ),
  fillColor: Color.fromARGB(255, 255, 255, 255),
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),

  prefixIcon: Icon(Icons.email),
  // Borda genérica (usada como base e para outros estados)
  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),

  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(width: 3.0, color: kCorSecundaria), // Borda padrão mais fina
  ),

  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(width: 3.0, color: kCorSecundariaEscura), // Borda mais grossa e azul
  ),
);

final kTextFieldDecorationEmpresa = InputDecoration(
  hintText: 'E-mail',
  hintStyle: TextStyle(
    color: Colors.grey[600], // Cor do texto da dica
    fontSize: 16.0, // Tamanho da fonte
  ),
  fillColor: Color.fromARGB(255, 255, 255, 255),
  filled: true,
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),

  prefixIcon: Icon(Icons.email),
  // Borda genérica (usada como base e para outros estados)
  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),

  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(width: 3.0, color: kCorPrimaria), // Borda padrão mais fina
  ),

  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(width: 3.0, color: kCorPrimariaEscura), // Borda mais grossa e azul
  ),
);



const kInputStyle = TextStyle(color: Colors.black, fontFamily: 'Montserrat', fontWeight: FontWeight.w900);
