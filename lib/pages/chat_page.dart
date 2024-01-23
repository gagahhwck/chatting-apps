import 'package:chat_ui/pages/constans.dart';
import 'package:chat_ui/pages/sign_in_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const collectionName = "messages";

class ChatPage extends StatefulWidget {
  static const String routeName = "/ChatPage";
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Chats"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: Icon(Icons.chat_bubble),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, SignInPage.routeName, (route) => false);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // bubble messages
          MessageStream(),
          // textfield
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: TextField(
                  controller: messageTextController,
                  style: const TextStyle(color: Colors.black),
                  decoration: kMessageTextFieldDecoration,
                  textInputAction: TextInputAction.send,
                )),
                TextButton(
                  onPressed: () {
                    if (messageTextController.text.isEmpty) return;
                    FirebaseFirestore.instance.collection(collectionName).add({
                      'text': messageTextController.text,
                      'sender': FirebaseAuth.instance.currentUser?.email,
                      'time': DateFormat('kk:mm:ss').format(DateTime.now())
                    });
                    messageTextController.clear();
                  },
                  child: const Text(
                    'Send',
                    style: kSendButtonTextStyle,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getMessageCollectio();
  }

  void getMessageCollectio() async {
    final messages =
        await FirebaseFirestore.instance.collection(collectionName).get();
    print(messages.docs.length);
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(collectionName)
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final messages = snapshot.data!.docs;
          List<MessageBubble> messageBubbles = messages.map((message) {
            final messageText = message['text'];
            final messageSender = message['sender'];
            final isMe =
                FirebaseAuth.instance.currentUser!.email == messageSender;
            return MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: isMe,
            );
          }).toList();

          return Expanded(
            child: ListView(
              reverse: true,
              children: messageBubbles,
            ),
          );
        });
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  const MessageBubble(
      {super.key,
      required this.sender,
      required this.text,
      required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 12.0,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          // Bubble
          Material(
            borderRadius: BorderRadius.only(
                topLeft:
                    isMe ? const Radius.circular(30) : const Radius.circular(0),
                topRight:
                    isMe ? const Radius.circular(0) : const Radius.circular(30),
                bottomLeft: const Radius.circular(30),
                bottomRight: const Radius.circular(30)),
            color: isMe ? Colors.blue : Colors.white,
            elevation: 5.0,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text(
                text,
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black45,
                    fontSize: 15.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
