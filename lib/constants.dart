import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

const kCorPrimaria = Color(0xFF5E93AD);
const kCorPrimariaEscura = Color(0xFF3A708A);
const kCorSecundaria = Color(0xFFFF9900);
const kCorSecundariaEscura = Color(0xFFD07D00);
const kCorSecundariaFundo = Color(0xFFFFF5E6);
const kCorFundo = Color(0xFFF3F3F3);
const kBranco = Color(0xFFFFFFFF);
const kCinza = Color(0xFF686868);
const kPreto = Color(0xFF000000);
const kVermelho = Color.fromARGB(255, 255, 0, 0);
const kVermelhoClaro = Color.fromARGB(255, 255, 99, 99);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

class BtnPadrao extends StatelessWidget {
  // CORREÇÃO 1: Adicionado '?' para permitir que 'onPressed' seja nulo.
  final VoidCallback? onPressed;
  final Color? color;
  final String title;

  const BtnPadrao({super.key, required this.title, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 2,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
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
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),

  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(
      width: 3.0,
      color: kCorSecundaria,
    ), // Borda padrão mais fina
  ),

  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(
      width: 3.0,
      color: kCorSecundariaEscura,
    ), // Borda mais grossa e azul
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
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
  ),

  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(12.0)),
    borderSide: BorderSide(
      width: 3.0,
      color: kCorPrimaria,
    ), // Borda padrão mais fina
  ),

  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(
      width: 3.0,
      color: kCorPrimariaEscura,
    ), // Borda mais grossa e azul
  ),
);

const kInputStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'Montserrat',
  fontWeight: FontWeight.w400,
);

appbar(
  context,
  titulo, {
  bool icon = false,
  onTap,
  String? imageIcon,
  Color? iconColor = kBranco,
  Color gradientStart = kCorSecundaria, // Cor inicial do gradiente
  Color gradientEnd = kCorSecundariaEscura, // Cor final do gradiente
  IconData icone = Icons.person, // CORREÇÃO: IconData em vez de Icon
}) {
  return AppBar(
    backgroundColor: gradientEnd, // Usar a cor final como backgroundColor
    foregroundColor: kBranco,
    shadowColor: Colors.transparent,
    toolbarHeight: 112,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            gradientStart,
            gradientEnd,
          ], // Usar as cores passadas como parâmetro
        ),
      ),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Text(
            titulo,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 0,
              letterSpacing: -0.24,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        icon
            ? GestureDetector(
                onTap: onTap,
                child: imageIcon != null
                    ? SvgPicture.asset(imageIcon, width: 24, height: 24)
                    : Icon(icone, color: iconColor), // CORREÇÃO: usar iconColor
              )
            : Container(),
      ],
    ),
    elevation: 0,
  );
}
