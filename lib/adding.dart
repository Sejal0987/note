import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

final _fireStore = FirebaseFirestore.instance;
User user;

class Add extends StatefulWidget {
  static const String id = 'adding';
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  String note;
  String title;
  File image;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  DateTime date;

  void getCurrentUser() async {
    try {
      user = _auth.currentUser;
      if (user != null) {
        print(user.email);
      }
    } catch (e) {
      print(e);
    }
  }

  void getImage() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50, maxWidth: 150);
    setState(() {
      image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.image,
              color: Colors.white,
            ),
            onPressed: getImage,
          ),
          SizedBox(
            width: 10.0,
          ),
          IconButton(
            padding: EdgeInsets.only(right: 10.0),
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () async {
              await _fireStore
                  .collection('notes')
                  .doc(user.uid)
                  .collection('mynotes')
                  .add({
                'sender': user.email,
                'title': title,
                'note': note,
                'createdAt': Timestamp.now(),
                'date': DateTime.now(),
              });
              Navigator.pop(context);
            },
            // do something
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            onChanged: (value) {
              title = value;
            },
            style: TextStyle(
              fontSize: 25.0,
              color: Colors.black,
              fontWeight: FontWeight.w900,
            ),
            decoration: InputDecoration(
              hintText: 'Title',
              hintStyle: TextStyle(
                color: Colors.black54,
                fontSize: 25.0,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            ),
          ),
          Expanded(
            child: TextField(
              onChanged: (value) {
                note = value;
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: 'Description',
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
