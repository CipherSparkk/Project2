import 'package:chatshat/Uihelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class addUser extends StatelessWidget {
  late Color clr;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final String newUid;
  addUser({required this.newUid});

  @override
  Widget build(BuildContext context) {
    clr = Theme.of(context).colorScheme.inversePrimary;

    saveDetails(String name, String phone, String email) async {
      if (name == "" || phone == "" || email == "") {
        Uihelper.CustomAlertBox(context, "Please fill all the details!!!");
        return;
      }
      String uid = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("app-users")
          .where("E-mail", isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String existingUid = querySnapshot.docs.first.id;

        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection("app-users")
            .doc(uid).collection("Users").doc(existingUid)
            .get();

        if (userSnapshot.exists) {
          Uihelper.CustomAlertBox(context, "User already exists!");
        } else {
          // User exists in "app-users" but not in "Users", add them to "Users" collection
          FirebaseFirestore.instance.collection("app-users").doc(uid).collection("Users").doc(existingUid).set({
            "Name": name,
            "Phone": phone,
            "E-mail": email,
            "uid": existingUid,
          });
          Uihelper.CustomAlertBox(context, "User Added Successfully");
        }
      } else {
        Uihelper.CustomAlertBox(context, "No User Existed");
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle_sharp,
              size: 220,
              color: clr,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Username')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(hintText: 'Phone')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(hintText: 'E-mail')),
            ),
            SizedBox(
              height: 30,
            ),
            CupertinoButton(
              color: clr,
              child: Text(
                "Save",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                saveDetails(
                    nameController.text.toString(),
                    phoneController.text.toString(),
                    emailController.text.toString());
                Uihelper.CustomAlertBox(context, "User Added");
                Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(20),
            ),
            SizedBox(
              height: 125,
            ),
          ],
        ),
      ),
    );
  }
}
