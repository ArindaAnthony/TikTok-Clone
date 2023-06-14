import 'package:flutter/material.dart';
class TextInputField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final IconData icon;
  final bool isPasswordType;
  const TextInputField({Key? key, required this.text, required this.controller, required this.icon, required this.isPasswordType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPasswordType,
      autocorrect: isPasswordType,
      enableSuggestions: isPasswordType,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white70,),
        labelText: text,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 0, style: BorderStyle.none),
        ),
      ),
      keyboardType: isPasswordType?TextInputType.visiblePassword:TextInputType.emailAddress,

    );
  }
}
