import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutorial/consts.dart';
import 'package:tutorial/Pages/login_screen.dart';
import '../Widgets/TextInputField.dart';
import '../Widgets/button_widget.dart';
import '../Widgets/profitephoto_widget.dart';
import 'main_screen.dart';
class SignUpScreen extends StatefulWidget {
   SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController emailController=TextEditingController();

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
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("TikTok Clone", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.red),),
            const SizedBox(height: 24,),
            const Text("Register", style: TextStyle(fontSize: 30),),
            const SizedBox(height: 10,),
            Stack(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: borderColor
                  ),
                    child: profileWidget(image: image),
                ),
                Positioned(
                    bottom: -15,
                    right: -10,
                    child: IconButton(
                      onPressed: () {
                        selectImage();
                      },
                      icon: const Icon(Icons.add_a_photo, color: blueColor,),))
              ],
            ),
            const SizedBox(height: 10,),
            Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width-20,
                  child: TextInputField(text: "Enter username", controller: usernameController, icon: Icons.person, isPasswordType: false)),
            ),
            const SizedBox(height: 15,),
            Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width-20,
                  child: TextInputField(text: "Enter email", controller: emailController, icon: Icons.email, isPasswordType: false)),
            ),
            const SizedBox(height: 15,),
            Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width-20,
                  child: TextInputField(text: "Enter password", controller: passwordController, icon: Icons.lock_outline, isPasswordType: true)),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
                onTap: ()=>authController.registerUser(emailController.text, passwordController.text, usernameController.text, image),
                child: const ReusableButton(text: "SignUp")),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?", style: TextStyle(fontSize: 20),),
                const SizedBox(width: 10,),
                InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                    },
                    child: const Text("Login", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),))
              ],
            )
          ],
        )
    );
  }
}
