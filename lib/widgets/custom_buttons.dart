import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Button background color

          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ), // Button padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Button border radius
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, color: Color(0xff294461)),
        ),
      ),
    );
  }
}
