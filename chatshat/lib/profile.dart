import 'package:chatshat/Uihelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _nameController = TextEditingController();
  bool _enableField = false;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  late Color clr;

  String _hintText = '';

  @override
  void initState() {
    super.initState();
    // Assuming you have access to the uid
    FirebaseFirestore.instance
        .collection("app-users")
        .doc(uid)
        .get()
        .then((docSnapshot) {
      if (docSnapshot.exists) {
        setState(() {
          _hintText = docSnapshot.data()?['name'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    clr = Theme.of(context).colorScheme.inversePrimary;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
              fontFamily: "mynewFont",
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100,),
            CupertinoButton(
                child: Icon(
                  Icons.account_circle_sharp,
                  size: 300,
                  color: clr,
                ),
                onPressed: () {
                  
                }),
            Container(
              padding: EdgeInsets.only(left: 70, right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      enabled: _enableField,
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: _hintText,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  CupertinoButton(
                    child: Icon(Icons.edit, color: clr),
                    onPressed: () {
                      setState(() {
                        _enableField = true;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CupertinoButton(
                color: clr,
                borderRadius: BorderRadius.circular(20),
                child: const Text(
                  "Update",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "mynewFont",
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                onPressed: () {
                  FirebaseFirestore.instance.collection("app-users").doc(uid).update({
                    "name": _nameController.text,
                  });
                  Uihelper.CustomAlertBox(context, "Username Updated");
                  setState(() {
                    _enableField = false;
                  });
                })
          ],
        ),
      ),
    );
  }
}
