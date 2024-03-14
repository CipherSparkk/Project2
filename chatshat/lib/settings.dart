import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class settingsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(
          fontFamily: 'myNewFont',
          fontSize: 27,
        ),),
        backgroundColor: Colors.transparent,
      ),
      body: Container(),
    );
  }

}