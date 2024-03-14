import 'package:chatshat/SignUp.dart';
import 'package:chatshat/Uihelper.dart';
import 'package:chatshat/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class login extends StatefulWidget {

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isConditionTrue = false;

  bool x = true;
logIn (String email, String password)
async {
  if(email == "" || password == "")
    return Uihelper.CustomAlertBox(context, "Please fill all fields!!!");
  else {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password).then((value) {
            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => MyHomePage()));
      });
    }on FirebaseAuthException catch(ex)
  {
    return Uihelper.CustomAlertBox(context, ex.code.toString());
  }
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(height: 30,),
                CircleAvatar(
                  radius: 195.0,
                  child: Stack(
                    children: [
                      ClipOval(
                          child: Image.asset('assets/images/img1.jpeg')
                      ),
                      Center(
                        child: Text(
                          'ChatShat',
                          style: TextStyle(
                            fontSize: 65,
                            fontWeight: FontWeight.bold,
                            fontFamily: "myTitleFont",
                          ),
                        ),
                      ),
                      Center(
                        child: Divider(
                          color: Colors.orange,
                          thickness: 5,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
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
                SizedBox(height: 10,),
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
                          child: Icon(Icons.password,
                            color: Colors.orange,)),
                      suffixIcon: CupertinoButton(child: Icon(Icons.remove_red_eye, color: Colors.orange,),
                        onPressed: ()
                        {
                          setState(() {
                            if(x == true) {
                              x = false;
                            }
                            else{
                              x = true;
                            }
                          });
                        }
                        ,),
                      hintText: 'Enter Password',
                    ),),
                ),
                SizedBox(height: 10),
                CupertinoButton(
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(30),
                    onPressed: () {
                        logIn(emailController.text.toString(), passController.text.toString());
                    }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        child: Container(
          margin: EdgeInsets.only(bottom: 30, left: 20),
          child: Row(
            children: [
              Text('Ceate an account',
                style: TextStyle(
                  fontSize: 20,
                ),),
              SizedBox(
                width: 6,
              ),
              CupertinoButton(
                child: Text('SignUp',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: CupertinoColors.activeOrange
                  ),),
                onPressed: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) {
                    return SignUpPage();
                  }));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
