import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class MessageField extends StatelessWidget {
  MessageField({Key? key}) : super(key: key);

  final controller = TextEditingController();

  final CollectionReference messagesCollectionReference =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: (value) {
        // add data in a new document in the collection messages through its reference
        messagesCollectionReference.add({
          'message': value,
        });
        //   controller.text = '';
        controller.clear();
      },
      decoration: InputDecoration(
        hintText: 'Send a message',
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        suffix: IconButton(
          icon: const Icon(
            Icons.send,
            color: kPrimaryColor,
          ),
          onPressed: () {},
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
