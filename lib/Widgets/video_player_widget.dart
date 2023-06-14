import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../consts.dart';
class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
   const VideoPlayerItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    chewieController = ChewieController(videoPlayerController: videoPlayerController, looping: true);

    videoPlayerController.initialize().then((_) {
      setState(() {}); // to update the video player with the initial values
      videoPlayerController.play();
      videoPlayerController.setVolume(1);
    });

    super.initState();
  }
/*  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.videoUrl)..initialize().then((value){
      videoPlayerController.play();
      videoPlayerController.setVolume(1);
    });
    chewieController = ChewieController(videoPlayerController: videoPlayerController, looping: true,);
    super.initState();
  }*/
  @override
  void dispose() {
    chewieController.dispose();
    videoPlayerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: backgroundColor
      ),
      child:  VideoPlayer(videoPlayerController),
    );
  }
}
