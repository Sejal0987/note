import 'package:flutter/material.dart';
import 'add_notes.dart';
import 'notes_screen.dart';
import 'adding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'registration_screen.dart';
import 'login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AddNotes.id,
      routes: {
        AddNotes.id: (context) => AddNotes(),
        NotesScreen.id: (context) => NotesScreen(),
        Add.id: (context) => Add(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        LoginScreen.id: (context) => LoginScreen(),
      },
      theme: ThemeData.dark(),
    );
  }
}
