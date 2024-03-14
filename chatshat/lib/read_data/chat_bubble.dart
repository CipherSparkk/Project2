import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  ChatBubble({required this.message, required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 17, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isCurrentUser ? Colors.orange.shade300 : Colors.grey.shade300,
      ),
      child: Text(message, style: TextStyle(
        fontFamily: 'myNewFont',
        fontSize: 19,
      ),),
    );
  }
}
