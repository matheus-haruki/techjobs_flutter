// Em um novo arquivo (ex: confirmation_screen.dart)

import 'dart:async';
import 'package:TechJobs/screens/cadastro/login_screen.dart';
import 'package:flutter/material.dart';

class ConfirmacaoScreen extends StatefulWidget {
  static const String id = 'confirmacao_screen'; // ID único para esta tela

  // Adicionar const ao construtor
  const ConfirmacaoScreen({super.key});

  @override
  _ConfirmacaoScreenState createState() => _ConfirmacaoScreenState();
}

class _ConfirmacaoScreenState extends State<ConfirmacaoScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() {
    Timer(const Duration(seconds: 2), () {
      // MELHORIA: Garante que o widget ainda está na tela antes de navegar.
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // Adicionar const
      backgroundColor: Colors.green, // Cor de sucesso
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle_outline, color: Colors.white, size: 100),
            SizedBox(height: 20),
            Text('Conta criada com sucesso!', style: TextStyle(color: Colors.white, fontSize: 24)),
            SizedBox(height: 10),
            Text('Você será redirecionado para o login.', style: TextStyle(color: Colors.white70, fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
