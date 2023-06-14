import 'package:flutter/material.dart';
class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:const [
          Text("Message Screen", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}