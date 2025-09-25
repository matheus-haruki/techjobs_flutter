import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart'; // Deve estar assim
import 'package:flutter_chat/constants.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: [
                SizedBox(height: 60.0, child: Image.asset('assets/images/logo.png')),
                Text('Flash Chat', style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.w900)),
              ],
            ),
            SizedBox(height: 48.0),
            BtnPadrao(
              title: 'Log In',
              color: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            BtnPadrao(
              title: 'Register',
              color: Colors.blueAccent,
              onPressed: () {
                debugPrint('Register button pressed - trying to navigate to: ${RegistrationScreen.id}');

                Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
