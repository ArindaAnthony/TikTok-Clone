
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tutorial/Controllers/auth_controller.dart';
import 'package:tutorial/Pages/add_screen.dart';
import 'package:tutorial/Pages/profile_screen.dart';
import 'package:tutorial/Pages/search_screen.dart';
import 'package:tutorial/Pages/video_screen.dart';
import 'package:tutorial/Pages/main_screen.dart';
const backgroundColor= Colors.black;
const buttonColor= Colors.red;
const borderColor= Colors.grey;
const blueColor=Colors.blue;
const primaryColor = Colors.white;

//controllers
var authController=AuthController.instance;

 List pages =[
  VideoScreen(),
  SearchScreen(),
  const AddScreen(),
  const Center(child: Text("Message Screen")),
  ProfileScreen(uid: authController.uuser.uid)
];

void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: blueColor,
      textColor: Colors.white,
      fontSize: 16.0);
}
//firebase constants
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;


/*CircleAvatar(
radius: 64,
backgroundColor: Colors.white,
backgroundImage: Image.file(
File("${image?.path}"),
fit: BoxFit.cover,
).image,*/
