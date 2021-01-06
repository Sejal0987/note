import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

User user;

class EditNote extends StatefulWidget {
  DocumentSnapshot documentSnapshot;
  EditNote({this.documentSnapshot});
  @override
  _EditNoteState createState() => _EditNoteState();
}

final _fireStore = FirebaseFirestore.instance;

class _EditNoteState extends State<EditNote> {
  String note;
  String title;
  final messageController = TextEditingController();
  final messageController2 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    note = widget.documentSnapshot['note'];
    title = widget.documentSnapshot['title'];
    messageController.text = title;
    messageController2.text = note;
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
              onPressed: () {} //getImage,
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
              await widget.documentSnapshot.reference.update(
                {
                  'title': title,
                  'note': note,
                  'date': DateTime.now(),
                },
              ).whenComplete(() => Navigator.pop(context));
            },
            // do something
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await widget.documentSnapshot.reference.delete();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: messageController,
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
              hintStyle: TextStyle(color: Colors.black54, fontSize: 25.0),
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
              controller: messageController2,
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
