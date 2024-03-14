import 'package:chatshat/Uihelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'main.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool x = true;
  bool y = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController cpassController = TextEditingController();

  signUp(String email, String pass, String cpass) async {
    if (email == "" || pass == "" || cpass == "") {
      Uihelper.CustomAlertBox(context, "Please fill all fields!!!");
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection("app-users").doc(uid).set({
        "E-mail": email,
        "uid": uid,
        "Name": "Username",
      });

      Navigator.push(context, CupertinoPageRoute(builder: (context) => MyHomePage()));
    } catch (ex) {
      Uihelper.CustomAlertBox(context, ex.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                height: 100,
              ),
              Text(
                'Welcome to',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w800,
                    color: Colors.deepOrangeAccent),
              ),
              Text(
                'ChatShat',
                style: TextStyle(
                  fontFamily: "myTitleFont",
                  fontSize: 55,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 380,
                child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                        ),
                        prefixIcon: Container(
                          child: Icon(
                            Icons.email_outlined,
                            color: Colors.orange,
                          ),
                        ),
                        hintText: 'Enter E-mail id')),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 380,
                child: TextField(
                  controller: passController,
                  obscureText: x,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                    ),
                    prefixIcon: Container(
                        margin: EdgeInsets.only(right: 15, left: 10),
                        child: Icon(
                          Icons.password,
                          color: Colors.orange,
                        )),
                    suffixIcon: CupertinoButton(
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.orange,
                      ),
                      onPressed: () {
                        setState(() {
                          if (x == true) {
                            x = false;
                          } else {
                            x = true;
                          }
                        });
                      },
                    ),
                    hintText: 'Enter Password',
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 380,
                child: TextField(
                  controller: cpassController,
                  obscureText: y,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                    ),
                    prefixIcon: Container(
                        margin: EdgeInsets.only(right: 15, left: 10),
                        child: Icon(
                          Icons.password,
                          color: Colors.orange,
                        )),
                    suffixIcon: CupertinoButton(
                      child: Icon(
                        Icons.remove_red_eye,
                        color: Colors.orange,
                      ),
                      onPressed: () {
                        setState(() {
                          if (y == true) {
                            y = false;
                          } else {
                            y = true;
                          }
                        });
                      },
                    ),
                    hintText: 'Enter Confirm Password',
                  ),
                ),
              ),
              SizedBox(height: 10),
              CupertinoButton(
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 90,
                    color: Colors.orange,
                  ),
                  onPressed: () {
                      signUp(emailController.text.toString(), passController.text.toString(), cpassController.text.toString());
                    }
                  )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: Container(
          margin: EdgeInsets.only(bottom: 30, left: 20),
          child: Row(
            children: [
              Text(
                'Already have an account?',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                width: 6,
              ),
              CupertinoButton(
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: CupertinoColors.activeOrange),
                ),
                onPressed: () {
                  Navigator.pop(context, CupertinoPageRoute(builder: (context) {
                    return login();
                  }));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
