import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {
  const LoginInput({
    Key? key,
    required this.hint,
    required this.label,
    required this.onChanged,
  }) : super(key: key);

  final String hint;
  final String label;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: TextFormField(
        validator: (data) {
          if (data!.isEmpty) {
            return 'Field must not be empty';
          }
          return null;
        },
        style: const TextStyle(
          color: Colors.white,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          label: Text(label),
          labelStyle: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
