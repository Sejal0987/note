import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'adding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'edit_note.dart';
import 'package:intl/intl.dart';
import 'add_notes.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd (HH:mm)");

User user;

class NotesScreen extends StatefulWidget {
  static const String id = 'notes_screen';
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

final _fireStore = FirebaseFirestore.instance;

class _NotesScreenState extends State<NotesScreen> {
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Text('Your Notes'),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, AddNotes.id); // do something
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Add.id);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.black45,
        ),
        body: NoteStream());
  }
}

class NoteStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collection('notes')
          .doc(user.uid)
          .collection('mynotes')
          .orderBy('createdAt')
          .snapshots(),
      builder: (context, snapshot) {
        List<NoteBubble> noteBubble = [];
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            backgroundColor: Colors.blueAccent,
          );
        }
        final message = snapshot.data.docs.reversed;
        int i = 1;
        for (var msg in message) {
          final String msgText = msg.data()['note'];
          final msgSender = msg.data()['sender'];
          final title = msg.data()['title'];
          final date2 = msg.data()['createdAt'].toDate();
          final date = msg.data()['date'].toDate();
          String dates = dateFormat.format(date);
          String dates2 = dateFormat.format(date2);
          // DateTime dates =
          //     DateTime.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch);

          final currentUser = msgSender;
          noteBubble.add(NoteBubble(
              sender: msgSender,
              text: msgText,
              documents: msg,
              // isMe: currentUser == user.email,
              title: title,
              date: dates,
              date2: dates2));
          i++;
        }

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: noteBubble,
        );
      },
    );
  }
}

class NoteBubble extends StatelessWidget {
  final String text;
  final String sender;
  final DocumentSnapshot documents;
  final String title;
  final date;
  final date2;
  NoteBubble(
      {this.sender,
      this.text,
      this.documents,
      this.title,
      this.date,
      this.date2});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EditNote(
            documentSnapshot: documents,
          );
        }));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Material(
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.black87.withOpacity(0.8),
          child: Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      'Title:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      '$title',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(30.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.white),
                  margin: EdgeInsets.all(20.0),
                  child: Text(
                    '$text',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Created At: $date2',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      Text(
                        'Edited At: $date',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
