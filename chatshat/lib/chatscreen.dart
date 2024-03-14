import 'package:chatshat/read_data/chat_bubble.dart';
import 'package:chatshat/read_data/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class chatscreen extends StatefulWidget {
  final String receiverId;
  chatscreen({super.key, required this.receiverId});
  @override
  State<chatscreen> createState() => _chatscreenState();
}

class _chatscreenState extends State<chatscreen> {
  final TextEditingController messageController = TextEditingController();
  late Color clr;
  final ChatService _chatService = ChatService();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  Future<String> getUserName() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("app-users")
        .doc(uid)
        .collection("Users")
        .doc(widget.receiverId)
        .get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    String name = data['Name'];
    return name;
  }

  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => _scrollDown(),
        );
      }
    });
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    messageController.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void _scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatService.sendMessages(
          widget.receiverId, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    clr = Theme.of(context).colorScheme.inversePrimary;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          margin: EdgeInsets.only(left: 60, bottom: 10),
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              InkWell(
                  borderRadius: BorderRadius.circular(20),
                  child: Icon(
                    Icons.account_circle_sharp,
                    size: 55,
                  )),
              FutureBuilder<String>(
                future: getUserName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Text("loading...");
                  return Container(
                    padding: EdgeInsets.only(left: 11, top: 8),
                    child: Text(
                      snapshot.data!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'myNewFont',
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        backgroundColor: clr,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextField(
            focusNode: myFocusNode,
            controller: messageController,
            onSubmitted: (_) => sendMessage(),
            decoration: InputDecoration(
              hintText: 'Message',
              hintStyle: TextStyle(fontSize: 19),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.send_rounded,
                  color: clr,
                  size: 36,
                ),
                onPressed: sendMessage,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverId, senderId),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text("Error");

          if (snapshot.connectionState == ConnectionState.waiting)
            return Text("loading...");

          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['idFrom'] == uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: ChatBubble(message: data["content"], isCurrentUser: isCurrentUser),
    );
  }
}
