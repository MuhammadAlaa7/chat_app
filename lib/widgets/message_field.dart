import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MessageField extends StatelessWidget {
  MessageField(
      {Key? key, required this.scrollController, required this.emailFromLogin})
      : super(key: key);

  final controller = TextEditingController();
  final ScrollController scrollController;
  final String emailFromLogin;
// this is for controlling the focus of the text field ,
//so that if i need to cancel the focus from the textfield to get the keyboard down after finishing the texting
  final focusNode = FocusNode();

  final CollectionReference messagesCollectionReference =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    print('widget email $emailFromLogin');
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: 'Send a message',
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.send,
            color: kPrimaryColor,
          ),
          onPressed: () {
            if (controller.text != '') {
              messagesCollectionReference.add(
                {
                  'message': controller.text,
                  'time': DateTime.now(),
                  'id': emailFromLogin,
                },
              );
              // clear the text in the textfield
              controller.clear();
              // cancel the focus to get the keyboard down
              focusNode.unfocus();
              
              scrollController.animateTo(
                0,
                duration: const Duration(
                  milliseconds: 500,
                ),
                curve: Curves.linear,
              );
            }
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
