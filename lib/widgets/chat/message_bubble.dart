import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final String userImage;
  final bool isMe;
  final Key key;

  MessageBubble(this.message, this.username, this.userImage, this.isMe,
      {this.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      overflow: Overflow.visible,
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : theme.accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                  bottomLeft:
                      !isMe ? Radius.circular(0) : Radius.circular(12.0),
                  bottomRight:
                      isMe ? Radius.circular(0) : Radius.circular(12.0),
                ),
              ),
              width: 140.0,
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 16.0,
              ),
              margin: EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 8.0,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isMe
                            ? Colors.black
                            : theme.accentTextTheme.headline1.color),
                  ),
                  Text(
                    message,
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                      color: isMe
                          ? Colors.black
                          : theme.accentTextTheme.headline1.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 120,
          right: !isMe ? null : 120,
          child: CircleAvatar(
            //radius: 25.0,
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
    );
  }
}
