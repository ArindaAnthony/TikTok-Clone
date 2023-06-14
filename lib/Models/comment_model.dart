import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String comment;
  String uid;
  String id;
  List likes;
  String profilePhoto;
  final datePublished;

  Comment(
      {required this.username,
        required this.datePublished,
      required this.comment,
      required this.uid,
      required this.id,
      required this.likes,
      required this.profilePhoto});

  Map<String, dynamic> toJson() => {
        "username": username,
        "comment": comment,
        "uid": uid,
        "id": id,
        "profilePhoto": profilePhoto,
        "likes": likes,
        "datePublished": datePublished,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
        username: snapshot["username"],
        datePublished: snapshot["datePublished"],
        comment: snapshot["comment"],
        uid: snapshot["uid"],
        id: snapshot["id"],
        likes: snapshot["likes"],
        profilePhoto: snapshot["profilePhoto"]);
  }
}
