import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String email;
  String profilePhoto;
  String uid;

  User(
      {required this.name,
      required this.email,
      required this.uid,
      required this.profilePhoto});

  Map<String, dynamic> toJson() => {
        "name": name,
        "profilePhoto": profilePhoto,
        "email": email,
        "uid": uid,
      };
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        name: snapshot["name"],
        profilePhoto: snapshot["profilePhoto"],
        email: snapshot["email"],
        uid: snapshot["uid"],
        );
  }
}
