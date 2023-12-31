import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutorial/Pages/confirm_screen.dart';
import 'package:tutorial/consts.dart';
class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: ()=>showDialogueBox(context),
          child: Container(
            width: 190,
            height: 50,
            decoration: const BoxDecoration(
              color: buttonColor
            ),
            child: const Center(child: Text("Add Video", style: TextStyle(fontSize: 20, color: backgroundColor, fontWeight: FontWeight.bold))),
          ),
        ),
      )
    );
  }

  showDialogueBox(BuildContext context){
    return showDialog(context: context, builder: (context)=>SimpleDialog(
      children: [
        SimpleDialogOption(
          onPressed: ()=>pickVideo(ImageSource.gallery, context),
          child: Row(
            children: const [
              Icon(Icons.image),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Gallery", style: TextStyle(fontSize: 20),),
              )
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: ()=>pickVideo(ImageSource.camera, context),
          child: Row(
            children: const [
              Icon(Icons.camera_alt),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Camera", style: TextStyle(fontSize: 20),),
              )
            ],
          ),
        ),
        SimpleDialogOption(
          onPressed: ()=>Navigator.of(context).pop(),
          child: Row(
            children: const [
              Icon(Icons.cancel_outlined),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Cancel", style: TextStyle(fontSize: 20),),
              )
            ],
          ),
        ),
      ],
    ));
  }

  pickVideo(ImageSource src, BuildContext context)async{
    final video =await ImagePicker().pickVideo(source: src);
    if (context.mounted) {
      if (video!=null) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ConfirmScreen(videoFile: File(video.path), videoPath: video.path)));
      }
  }
}}