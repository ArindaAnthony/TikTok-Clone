import 'dart:io';
import 'package:flutter/material.dart';

Widget profileWidget({File? image}) {
  if (image == null) {
    return Image.asset(
      "assets/mm.png",
      fit: BoxFit.cover,
    );
  } else {
    return CircleAvatar(
        radius: 64,
        backgroundColor: Colors.white,
        backgroundImage: Image.file(
          File("${image?.path}"),
          fit: BoxFit.cover,
        ).image);
  }
}
