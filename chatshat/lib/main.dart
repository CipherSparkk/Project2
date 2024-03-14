import 'package:chatshat/Uihelper.dart';
import 'package:chatshat/read_data/getusername.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'addUser.dart';
import 'chatscreen.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatShat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: decidePage(),
    );
  }
}

class decidePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData)
            return MyHomePage();
          else
            return login();
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<String> docIds = [];
    Future getUser() async {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection("app-users").doc(uid).collection("Users").get().then(
            (snapshot) => snapshot.docs.forEach((user) {
              docIds.add(user.reference.id);
            }),
          );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ChatShat',
              style: TextStyle(fontFamily: "myTitleFont", fontSize: 38),
            ),
            CupertinoButton(
                onPressed: () {}, child: Icon(Icons.search_outlined, size: 35)),
          ],
        ),
      ),
      body: Column(
        children: [

          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: 600,
              width: double.infinity,
              child: FutureBuilder(
                  future: getUser(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                        itemCount: docIds.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => chatscreen(
                                            receiverId: docIds[index],
                                          )));
                            },
                            child: ListTile(
                              leading: Icon(
                                Icons.account_circle_rounded,
                                color: Colors.black45,
                                size: 60,
                              ),
                              title: GetUserName(
                                DocumentId: docIds[index],
                              ),
                              titleTextStyle: TextStyle(
                                  fontFamily: 'myNewFont',
                                  color: Colors.black,
                                  fontSize: 19),
                              subtitle: Text(
                                "Hi",
                                style: TextStyle(fontFamily: 'myNewFont'),
                              ),
                            ),
                          );
                        });
                  }),
            ),
          )
        ],
      ), //
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 11, bottom: 20),
        child: FloatingActionButton(
          onPressed: () {
            String newUser =
                FirebaseFirestore.instance.collection("Users").doc().id;
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => addUser(newUid: newUser)));
          },
          child: Icon(Icons.add),
        ),
      ), // T
      // his
      drawer:
          Uihelper.drawer(context), // Set the drawer directly in the Scaffold
// trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
