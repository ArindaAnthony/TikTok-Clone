import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/Controllers/video_controller.dart';
import 'package:tutorial/Pages/comment_page.dart';
import 'package:tutorial/Widgets/circle_animation.dart';
import 'package:tutorial/Widgets/video_player_widget.dart';
import 'package:tutorial/consts.dart';
import 'package:chewie/chewie.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({Key? key}) : super(key: key);
  final VideoController videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Obx((){
          return PageView.builder(
            itemCount: videoController.videoList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index){
              final data = videoController.videoList[index];
              return Stack(
                children: [
                  //video player
                  VideoPlayerItem(videoUrl: data.videoUrl),
                  Positioned(
                    bottom: 20,
                    left: 30,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          data.username,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 7,),
                        Text(
                          data.caption,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 7,),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Icon(
                              Icons.music_note,
                              size: 15,
                              color: Colors.white,
                            ),const SizedBox(width: 10,),
                            Text(
                              data.songName,
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      right: 17,
                      top: size.height/4,
                      child: Container(
                        width: 100,
                        margin: EdgeInsets.only(top: size.height / 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            buildProfile(data.profilePhoto),
                            Column(
                              children: [
                                InkWell(
                                    onTap: () =>videoController.likeVideo(data.id),
                                    child: Icon(
                                      Icons.favorite,
                                      size: 40,
                                      color: data.likes.contains(authController.uuser.uid)? Colors.red: Colors.white,
                                      //color: data.likes.contains(authController.uuser.uid) ? Colors.red : Colors.white,
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${data.likes.length} likes",
                                  style: const TextStyle(fontSize: 20, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                InkWell(
                                    onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> CommentPage(id: data.id,))),
                                    child: const Icon(
                                      Icons.message,
                                      size: 40,
                                      color: Colors.white,
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  data.commentCount.toString(),
                                  style: const TextStyle(fontSize: 20, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.reply,
                                      size: 40,
                                      color: Colors.white,
                                    )),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  data.shareCount.toString(),
                                  style: const TextStyle(fontSize: 20, color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                CircleAnimation(child: buildProfile(data.thumbnail)),
                                // CircleAnimation(child: buildMusicAlbum("profile photo"))
                              ],
                            )
                          ],
                        ),
                      ))
                ],
              );
            },

          );
        }
        )

        /*PageView.builder(
        itemCount: 0,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index){
        return Stack(
          children: [
            //VideoPlayerItem(videoUrl: videoUrl),
            Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Expanded(child: Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Username", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),
                      const Text("caption", style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400),),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Icon(Icons.music_note, size: 15, color: Colors.white,),
                          Text("song name", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),)
                        ],
                      )
                    ],
                  ),
                )),
                Container(
                  width: 100,
                  margin: EdgeInsets.only(top: size.height/5),
                  child: Column(
                    mainAxisAlignment:  MainAxisAlignment.spaceEvenly,
                    children: [
                      buildProfile("photo url"),
                      Column(
                        children: [
                          InkWell(
                              onTap: (){
                              },
                              child: const Icon(Icons.favorite, size: 40, color: Colors.red,)),
                          const SizedBox(height: 5,),
                          const Text("2034", style: TextStyle(fontSize: 20, color: Colors.white),),
                          const SizedBox(height: 7,),
                          InkWell(
                              onTap: (){
                              },
                              child: const Icon(Icons.message, size: 40, color: Colors.white,)),
                          const SizedBox(height: 5,),
                          const Text("234", style: TextStyle(fontSize: 20, color: Colors.white),),
                          const SizedBox(height: 7,),
                          InkWell(
                              onTap: (){
                              },
                              child: const Icon(Icons.reply, size: 40, color: Colors.white,)),
                          const SizedBox(height: 5,),
                          const Text("20", style: TextStyle(fontSize: 20, color: Colors.white),),
                          const SizedBox(height: 7,),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        );
      }),*/
        );
  }

  buildProfile(String photo) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
              left: 5,
              child: Container(
                width: 60,
                height: 60,
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image(
                      image: NetworkImage(photo),
                      fit: BoxFit.cover,
                    )),
              ))
        ],
      ),
    );
  }

  buildMusicAlbum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.grey, Colors.white]
              ),
              borderRadius: BorderRadius.circular(25)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(image: NetworkImage(profilePhoto), fit: BoxFit.cover,),
            ),
          )
        ],
      ),
    );
  }
}
