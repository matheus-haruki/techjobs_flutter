import 'package:flutter/material.dart';
import 'package:flutter_chat/constants.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen'; // Deve ser exatamente isso

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 157, 153, 153),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: 50.0,

                //   child: Image.asset('assets/images/logo.png'),
                // ),
                Text(
                  'Crie sua conta',
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w900),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            SizedBox(
              width: 225.0,
              child: Text(
                'Crie sua conta para começar a procurar por vagas...',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(height: 48.0),
            TextField(
              style: kInputStyle,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Nome',
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              style: kInputStyle,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(hintText: 'Email'),
            ),
            SizedBox(height: 12.0),
            TextField(
              style: kInputStyle,
              obscureText: true,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Senha',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              style: kInputStyle,
              obscureText: true,
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Confirme a Senha',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 26.0),
            BtnPadrao(
              title: 'Register',
              color: Colors.blueAccent,
              onPressed: () {
                //Implement registration functionality.
              },
            ),
            SizedBox(height: 12.0),
            SizedBox(
              width: 220,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Já possui uma conta?',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      'Faça seu login',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
