import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tutorial/Pages/main_screen.dart';
import 'package:tutorial/Pages/login_screen.dart';
import 'package:tutorial/Models/userModel.dart'as model;

class AuthController extends GetxController {
  var firebaseStorage = FirebaseStorage.instance;
  var firestore = FirebaseFirestore.instance;
  static AuthController instance = Get.find();

  late String imageUrl;
  late Rx<User?> user;
  User get uuser => user.value!;
  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(firebaseAuth.currentUser);
    user.bindStream(firebaseAuth.authStateChanges());
    ever(user, setInitialScreen);
  }

  setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(SignInScreen());
    } else {
      Get.offAll(const HomeScreen());
    }
  }

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void registerUser(String email, String password, String username, File? image) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        //call profilePhoto upload function
        String downloadUrl = await uploadToStorage(image);
        //store to firebaseAuth
        UserCredential credential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        //store to firestore
        model.User user =model.User(
          name: username,
          email: email,
          profilePhoto: downloadUrl,
          uid: credential.user!.uid
        );
         await firestore.collection("users").doc(credential.user!.uid).set(user.toJson());
      } else {
        Get.snackbar("Error creating account", "Fill all Fields");
      }
    } catch (e) {
      Get.snackbar("Error creating account", e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar("Error creating account", "Fill all Fields");
      }
    } catch (e) {
      Get.snackbar("Error signing in", "Invalid Username or password");
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }

  Future<String> uploadToStorage(File? image) async {
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    Reference ref = firebaseStorage.ref().child("profileImages");
    Reference imageUpload = ref.child(uniqueFileName);

    try {
      //store image to database
      await imageUpload.putFile(File(image!.path));
      //get download url
      imageUrl = await imageUpload.getDownloadURL();
    } catch (e) {
      Get.snackbar("Image upload failed", "Check internet connection");
    }
    return imageUrl;
  }
}
