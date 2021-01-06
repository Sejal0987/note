import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'round_button.dart';
import 'registration_screen.dart';
import 'login_screen.dart';

class AddNotes extends StatefulWidget {
  static const String id = 'add_notes';
  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset('images/note.jpg'),
                  height: 150.0,
                ),
              ),
              Text(
                'Your Notes',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              RoundButton(
                text: 'Sign up',
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                color: Colors.black54,
              ),
              RoundButton(
                text: 'Log in',
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
