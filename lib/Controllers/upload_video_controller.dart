import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:tutorial/Models/video_model.dart';
import 'package:tutorial/consts.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  //upload video method
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection("users").doc(uid).get();
      //get video id
      var allDocs = await firestore.collection("videos").get();
      int len = allDocs.docs.length;
      String videoUrl = await uploadToStorage("Video $len", videoPath);
      String thumbnail = await uploadImageToStorage("Video $len", videoPath);
      Video video = Video(
          username: (userDoc.data()! as Map<String, dynamic>)["name"],
          uid: uid,
          id: "Video $len",
          likes: [],
          commentCount: 0,
          shareCount: 0,
          thumbnail: thumbnail,
          songName: songName,
          caption: caption,
          videoUrl: videoUrl,
          profilePhoto:
              (userDoc.data()! as Map<String, dynamic>)["profilePhoto"]);
      await firestore.collection("videos").doc("Video $len").set(video.toJson());
      Get.back();
    } catch (e) {
      Get.snackbar("Error uploading video", e.toString());
    }
  }

  Future<String> uploadToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child("videos").child(id);
    UploadTask uploadTask = ref.putFile(await compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

  Future<String> uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child("thumbnails").child(id);
    UploadTask uploadTask = ref.putFile(await getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }
}
