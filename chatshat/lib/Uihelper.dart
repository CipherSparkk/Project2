import 'package:chatshat/login.dart';
import 'package:chatshat/profile.dart';
import 'package:chatshat/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Uihelper {
  static CustomAlertBox(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Ok",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ))
          ],
        );
      },
    );
  }

  static drawer(context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      child: SafeArea(
        child: Column(
          children: [
            CupertinoButton(
                child: Icon(
                  Icons.account_circle_sharp,
                  size: 230,
                  color: Colors.white,
                ),
                onPressed: () {}),
            Divider(
              height: 2,
              color: Colors.white,
            ),
            TextButton(
              child: ListTile(
                leading: Icon(Icons.person,color: Colors.white,size: 28,),
                  title: Text("Profile", style: TextStyle(
                      color: Colors.white,
                      fontFamily: "mynewFont",
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ))),
              onPressed: (){
                Navigator.push(context, CupertinoPageRoute(builder: (context) => Profile()));
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) => settingsPage()));
              },
              child: ListTile(
                leading: Icon(Icons.settings,color: Colors.white,size: 28,),
                title: Text("Settings", style: TextStyle(
                  color: Colors.white,
                  fontFamily: "mynewFont",
                  fontSize: 19,
                  fontWeight: FontWeight.bold
                ))),

            ),
            TextButton(
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.white,size: 28,),
                  title: Text("Log out", style: TextStyle(
                      color: Colors.white,
                      fontFamily: "mynewFont",
                      fontSize: 19,
                      fontWeight: FontWeight.bold
                  ))),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => login()));
              }
            ),

          ],
        ),
      ),
    );
  }
}
