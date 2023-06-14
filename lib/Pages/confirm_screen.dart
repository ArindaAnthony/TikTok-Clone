import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/instance_manager.dart';
import 'package:tutorial/Controllers/upload_video_controller.dart';
import 'package:tutorial/Widgets/TextInputField.dart';
import 'package:video_player/video_player.dart';
class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen({Key? key, required this.videoFile, required this.videoPath}) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  TextEditingController songController =TextEditingController();
  TextEditingController captionController =TextEditingController();
  UploadVideoController uploadVideoController = Get.put(UploadVideoController());
  late VideoPlayerController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      controller =VideoPlayerController.file(widget.videoFile);
    });
    controller.initialize();
    controller.play();
    controller.setVolume(0.8);
    controller.setLooping(true);
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            SizedBox(
              height: MediaQuery.of(context).size.height/1.5,
              width: MediaQuery.of(context).size.width,
              child: VideoPlayer(controller),

            ),
            const SizedBox(height: 30,),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    width: MediaQuery.of(context).size.width-20,
                    child: TextInputField(text: "Song Name", controller: songController, icon: Icons.music_note, isPasswordType: false),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    width: MediaQuery.of(context).size.width-20,
                    child: TextInputField(text: "Caption", controller: captionController, icon: Icons.closed_caption, isPasswordType: false),
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(onPressed: ()=> uploadVideoController.uploadVideo(songController.text, captionController.text, widget.videoPath),
                  child: const Text("Share", style: TextStyle(fontSize: 20, color: Colors.white),))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
