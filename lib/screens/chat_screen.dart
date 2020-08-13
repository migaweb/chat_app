import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(onMessage: (msg) {
      //print(msg);
      return;
    }, onLaunch: (msg) {
      //print(msg);
      return;
    }, onResume: (msg) {
      //print(msg);
      return;
    });
    //fbm.getToken(); specific device..
    fbm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          DropdownButton(
            underline: Container(),
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
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
