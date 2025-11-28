import 'package:flutter/material.dart';
import 'package:TechJobs/constants.dart';

class BtnPadraoSquare extends StatelessWidget {
  final bool visible;
  final Function() onTap;
  final IconData icon;
  final Color iconColor;
  final Color bgIconColor;
  final bool isLoading;
  final String textBtn;
  final String secondTextBtn;

  const BtnPadraoSquare({
    super.key,
    this.visible = true,
    required this.onTap,
    required this.icon,
    this.iconColor = kCorPrimaria,
    this.bgIconColor = kCorSecundariaFundo,
    this.isLoading = false,
    required this.textBtn,
    this.secondTextBtn = "",
  });

  @override
  Widget build(BuildContext context) {
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Visibility(
      visible: visible,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(right: 15 * ffem),
          width: 102,
          height: 122,
          decoration: const BoxDecoration(
            color: kBranco,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Color(0x19000000),
                blurRadius: 10,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: bgIconColor,
                      borderRadius: BorderRadius.circular(
                        20,
                      ), // Define o raio em pixels
                    ),
                    width: 45,
                    height: 45,
                  ),
                  Icon(
                    icon, // Usa diretamente a propriedade IconData
                    color: iconColor,
                    size: 28 * ffem, // Ajuste o tamanho conforme necessário
                  ),
                ],
              ),
              Container(
                height: 35,
                width: double.infinity,
                margin: EdgeInsets.only(top: 5 * ffem),
                padding: EdgeInsets.only(left: 5 * ffem, right: 5 * ffem),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      textBtn,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 11,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        letterSpacing:
                            0.56, // Use Estilos.preto, se estiver definido em outro lugar.
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
