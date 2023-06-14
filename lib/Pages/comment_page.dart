import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/Controllers/comment_controller.dart';
import 'package:tutorial/consts.dart';
import '../Controllers/video_controller.dart';
import 'package:timeago/timeago.dart'as tago;

class CommentPage extends StatefulWidget {
  const CommentPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final VideoController videoController = Get.put(VideoController());

  final TextEditingController controller = TextEditingController();


  CommentController commentController = Get.put(CommentController());

  @override
  void initState() {
    super.initState();
    commentController = Get.put(CommentController());
    commentController.updatePostId(widget.id);
  }


  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(widget.id);
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Expanded(child: Obx(() {
                  return ListView.builder(
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final data = commentController.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: backgroundColor,
                            backgroundImage: NetworkImage(data.profilePhoto),
                          ),
                          title: Row(
                            children: [
                              Text(
                                data.username,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: buttonColor),
                              ),
                              const SizedBox(width: 15,),
                              Text(
                                data.comment,
                                style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                tago.format(data.datePublished.toDate()),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              const SizedBox(
                                width: 11,
                              ),
                              Text(
                                "${data.likes.length} likes",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          trailing: InkWell(
                              onTap: () => commentController.likeComment(data.id),
                              child: Icon(
                                Icons.favorite,
                                size: 25,
                                color: data.likes.contains(authController.uuser.uid) ? Colors.red : Colors.white,
                              )),
                        );
                      });
                })),
                const Divider(
                  color: borderColor,
                ),
                ListTile(
                  title: TextFormField(
                    controller: controller,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    decoration: const InputDecoration(
                        labelText: "Comment",
                        labelStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: buttonColor))),
                  ),
                  trailing: TextButton(
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      commentController.postComment(controller.text);
                    },
                    child: const Text(
                      "Send",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
class CommentPage extends StatefulWidget {
  CommentPage({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final VideoController videoController = Get.put(VideoController());
  final TextEditingController controller = TextEditingController();
  late CommentController commentController;

  @override
  void initState() {
    super.initState();
    commentController = Get.put(CommentController());
    commentController.updatePostId(widget.id);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Expanded(
                  child: Obx(
                    () => ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        final data = videoController.videoList[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: backgroundColor,
                            backgroundImage: NetworkImage(data.profilePhoto),
                          ),
                          title: Row(
                            children: [
                              Text(
                                data.username,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: buttonColor,
                                ),
                              ),
                              Text(
                                data.caption,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              const Text(
                                "date",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(
                                width: 11,
                              ),
                              Text(
                                data.likes.length.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          trailing: InkWell(
                            onTap: () => videoController.likeVideo(data.id),
                            child: Icon(
                              Icons.favorite,
                              size: 25,
                              color: data.likes.contains(authController.uuser.uid)
                                  ? Colors.red
                                  : Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Divider(
                  color: borderColor,
                ),
                ListTile(
                  title: TextFormField(
                    controller: controller,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      labelText: "Comment",
                      labelStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: buttonColor),
                      ),
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      try {
                        commentController.postComment(comment: controller.text);
                        controller.clear();
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                    child: const Text(
                      "Send",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 */
