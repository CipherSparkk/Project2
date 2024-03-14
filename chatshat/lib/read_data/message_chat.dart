import 'package:flutter/material.dart';

class MessageChat{
  String content;
  String idFrom;
  String idTo;
  String timestamp;

  MessageChat({
    required this.content,
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
});

  Map<String, dynamic> toMap(){
    return {
      'content' : content,
      'idFrom' : idFrom,
      'idTo' : idTo,
      'timestamp' : timestamp,
    };
  }
}