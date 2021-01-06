import 'package:flutter/material.dart';
import 'round_button.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'notes_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
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
            Flexible(
              child: Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/note.jpg'),
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
                //Do something with the user input.
              },
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: kInputField.copyWith(
                hintText: 'Enter your email.',
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
              ),
              obscureText: true,
              onChanged: (value) {
                password = value;
                //Do something with the user input.
              },
              decoration: kInputField.copyWith(
                hintText: 'Enter your password.',
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundButton(
                color: Colors.black,
                text: 'Log In',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });

                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      setState(() {
                        showSpinner = false;
                      });
                      Navigator.pushNamed(context, NotesScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    setState(() {
                      showSpinner = false;
                    });
                    print(e);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
