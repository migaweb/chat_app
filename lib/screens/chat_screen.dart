import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert, color: theme.primaryIconTheme.color),
            items: [
              DropdownMenuItem(
                value: 'Logout',
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    Text('Logout'),
                    SizedBox(width: 8.0),
                  ],
                ),
              ),
            ],
            onChanged: (itemIdentifier) async {
              if (itemIdentifier == 'Logout') {
                await FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/iTcIYIW26ZIxSLuD4cPt/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final documents = streamSnapshot.data.documents;
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, i) => Container(
                padding: EdgeInsets.all(8.0),
                child: Text(documents[i]['text'])),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/iTcIYIW26ZIxSLuD4cPt/messages')
              .add({'text': 'This was added by clicking the button.'});
        },
      ),
    );
  }
}
