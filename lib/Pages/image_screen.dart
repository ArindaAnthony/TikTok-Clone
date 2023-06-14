import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutorial/Widgets/profitephoto_widget.dart';

import '../Widgets/button_widget.dart';
import '../consts.dart';
class ImagePage extends StatefulWidget {
   ImagePage({Key? key}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  FirebaseFirestore firestore =FirebaseFirestore.instance;

  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  late String imageUrl;

/*   pickImage()async{
    ImagePicker imagePicker= ImagePicker();
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    Reference ref = firebaseStorage.ref().child("profileImages").child(uniqueFileName);
    try{
      await ref.putFile(File(file!.path));
      imageUrl = await ref.getDownloadURL();
    }catch(e){

    }
  }*/

  File? image;

  Future selectImage()async{
    try{
      final pickedFile= await ImagePicker.platform.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile!=null) {
          image=File(pickedFile.path);
        }  else{
          image = File("assets/img.png");
          toast("no image has been selected");
        }
      });
    }catch(e){
      toast("Some error occurred $e");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          const Text("Add image to firebase"),
          const SizedBox(height: 30,),
          Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: borderColor
                ),
                /*assets/mm.png*/
                //"${image?.path}"
                child: profileWidget(image: image)
              ),
              Positioned(
                  bottom: -15,
                  right: -10,
                  child: IconButton(
                    onPressed: () {
                      selectImage();
                    },
                      icon: const Icon(Icons.add_a_photo, color: blueColor,)),),
            ],
          ),
          const SizedBox(height: 40,),
          InkWell(
              onTap: (){
                authController.uploadToStorage(image!);
              },
              child: const ReusableButton(text: "Upload to database"))
        ],
      ),
    );
  }
}
