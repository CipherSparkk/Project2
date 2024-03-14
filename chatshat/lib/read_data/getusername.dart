import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class GetUserName extends StatelessWidget{
  final String DocumentId;

  GetUserName({required this.DocumentId});
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference users = FirebaseFirestore.instance.collection("app-users").doc(uid).collection("Users");
      return FutureBuilder<DocumentSnapshot>(
          future: users.doc(DocumentId).get(),
          builder: ((context,snapshot){
            if(snapshot.connectionState == ConnectionState.done) {
              Map<String,dynamic> data =
                snapshot.data!.data() as Map<String,dynamic>;
              return Text('${data['Name']}');
            }
            return
                Text('loading...');
          }
          ));
  }

}