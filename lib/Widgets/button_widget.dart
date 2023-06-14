import 'package:flutter/material.dart';
class ReusableButton extends StatelessWidget {
  final String text;
  const ReusableButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width-20,
      height: 50,
      decoration:  BoxDecoration(
        color: Colors.red.withOpacity(1),
        borderRadius: BorderRadius.circular(10),
      ),
        child:  Center(child: Text(text, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),

    );
  }
}
