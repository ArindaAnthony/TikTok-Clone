import 'package:cloud_firestore/cloud_firestore.dart';

class Video{
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String thumbnail;
  String songName;
  String caption;
  String videoUrl;
  String profilePhoto;

  Video(
      {required this.username,
      required this.uid,
      required this.id,
      required this.likes,
      required this.commentCount,
      required this.shareCount,
      required this.thumbnail,
      required this.songName,
      required this.caption,
      required this.videoUrl,
      required this.profilePhoto});

  Map<String, dynamic> toJson()=>{
    "username": username,
    "uid": uid,
    "id": id,
    "thumbnail": thumbnail,
    "songName": songName,
    "caption": caption,
    "videoUrl": videoUrl,
    "profilePhoto": profilePhoto,
    "likes": likes,
    "commentCount": commentCount,
    "shareCount": shareCount,
  };
  static Video fromSnap (DocumentSnapshot snap){
    var snapshot = snap.data() as Map<String, dynamic>;
    return Video(username: snapshot["username"], uid: snapshot["uid"], id: snapshot["id"],
        likes: snapshot["likes"], commentCount: snapshot["commentCount"], shareCount: snapshot["shareCount"],
        thumbnail: snapshot["thumbnail"], songName: snapshot["songName"], caption: snapshot["caption"],
        videoUrl: snapshot["videoUrl"], profilePhoto: snapshot["profilePhoto"]
    );
  }
}