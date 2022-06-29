import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Key key;
  final String _message;
  final bool _isMe;
  final String _username;
  final String _imageUrl;

  const MessageBubble(
    this._message,
    this._isMe,
    this._username,
    this._imageUrl, {
    required this.key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment: _isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: _isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(12),
                  topRight: const Radius.circular(12),
                  bottomLeft: _isMe ? const Radius.circular(12) : const Radius.circular(0),
                  bottomRight: _isMe ? const Radius.circular(0) : const Radius.circular(12),
                ),
              ),
              width: 150,
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8,
              ),
              child: Column(
                crossAxisAlignment: _isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    _username,
                    textAlign: _isMe ? TextAlign.end : TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _isMe ? Colors.black : Theme.of(context).accentTextTheme.headline1!.color,
                    ),
                  ),
                  Text(
                    _message,
                    style: TextStyle(
                      color: _isMe ? Colors.black : Theme.of(context).accentTextTheme.headline1!.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          right: _isMe ? 140 : null,
          left: _isMe ? null : 140,
          top: -10,
          child: CircleAvatar(
            backgroundImage: NetworkImage(_imageUrl),
          ),
        )
      ],
    );
  }
}
