import 'package:flutter/material.dart';
import 'adding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NotesScreen extends StatefulWidget {
  static const String id = 'notes_screen';
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

final _fireStore = FirebaseFirestore.instance;

class _NotesScreenState extends State<NotesScreen> {
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
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                // do something
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
      stream: _fireStore.collection('notes').orderBy('createdAt').snapshots(),
      builder: (context, snapshot) {
        List<NoteBubble> messageBubble = [];
        if (!snapshot.hasData) {
          return CircularProgressIndicator(
            backgroundColor: Colors.blueAccent,
          );
        }
        final message = snapshot.data.docs.reversed;
        for (var msg in message) {
          final String msgText = msg.data()['note'];
          final msgSender = msg.data()['sender'];
          final title = msg.data()['title'];
          final date = msg.data()['date'];
          final currentUser = msgSender;
          messageBubble.add(NoteBubble(
              sender: msgSender,
              text: msgText,
              // isMe: currentUser == user.email,
              title: title,
              date: date));
        }

        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: messageBubble,
        );
      },
    );
  }
}

class NoteBubble extends StatelessWidget {
  final String text;
  final String sender;
  final bool isMe;
  final String title;
  final date;
  NoteBubble({this.sender, this.text, this.isMe, this.title, this.date});
  //String formatter = DateFormat('yMd').format(date);

  // DateTime dateToday =
  //     DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  // 2016-01-25
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.black38,
        child: Column(
          children: [
            Text(
              'Title:',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 30.0,
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 5.0,
            ),
            Text('$title'),
            Container(
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), color: Colors.white),
              margin: EdgeInsets.all(20.0),
              child: Text(
                '$text',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Created:',
                    style: TextStyle(
                      color: Colors.black38,
                    ),
                  ),
                  Text(
                    'Edited At:',
                    style: TextStyle(
                      color: Colors.black38,
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
