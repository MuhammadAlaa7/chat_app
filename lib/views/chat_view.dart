import 'dart:html';

import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/widgets/chat_buble.dart';
import 'package:scholar_chat/widgets/message_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message.dart';

class ChatView extends StatelessWidget {
  ChatView({Key? key}) : super(key: key);

  static String id = 'chat id';
  final Stream<QuerySnapshot> messagesStream =
      FirebaseFirestore.instance.collection('messages').snapshots();

  @override
  Widget build(BuildContext context) {
    // the snapshot is the data received

    return StreamBuilder<QuerySnapshot>(
      // What is in the < > in the future builder is the type of the return in the future
      /// the future here is the one responsible for getting the data and it is connected with the builder
      stream: messagesStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('There was an error ');
        }
        if (snapshot.hasData) {
          List<Message> messagesList = [];
// the data comes is in the form of data but its type is object so  i am telling it
// to change the type or to deal with the data coming in the type of Map
// the data() function : collects the data from the document
// I receive the data as a list of documents and I loop on it to take each documnet and
// store it as a message instance
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> documentData =
                document.data() as Map<String, dynamic>;
            messagesList.add(Message.fromJson(documentData));
          }).toList();

          print(messagesList[1].messageText);
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogoPath,
                    height: 50,
                  ),
                  const Text('Chat'),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return ChatBuble(
                          message: messagesList[index].messageText,
                        );
                      },
                      itemCount: messagesList.length,
                    ),
                  ),
                  MessageField(),
                ],
              ),
            ),
          );
        }
        return const Text('Loading...');
      },
    );
  }
}
