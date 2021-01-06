import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'constants.dart';
import 'round_button.dart';
import 'notes_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;
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
                  child: Image.asset('images/note.jpg'),
                  height: 200.0,
                ),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  email = value;
                  //Do something with the user input.
                },
                decoration: kInputField.copyWith(
                    hintText: 'Enter your email.',
                    hintStyle: TextStyle(color: Colors.black54))),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black),
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: kInputField.copyWith(
                hintText: 'Enter your password.',
                hintStyle: TextStyle(color: Colors.black54),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundButton(
                color: Colors.black38,
                text: 'Register',
                onPressed: () async {
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);

                    if (newUser != null) {
                      Navigator.pushNamed(context, NotesScreen.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
