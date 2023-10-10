import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';

class ReceivedChatBuble extends StatelessWidget {
  const ReceivedChatBuble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        decoration: const BoxDecoration(
          color: Color(0xff006389),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
        ),
        child: Text(
          message,
          style:const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}




class SentChatBuble extends StatelessWidget {
  const SentChatBuble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
        ),
        child: Text(
          message,
          style:const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}