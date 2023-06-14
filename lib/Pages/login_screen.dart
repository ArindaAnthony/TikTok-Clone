import 'package:flutter/material.dart';
import 'package:tutorial/Widgets/TextInputField.dart';
import 'package:tutorial/Widgets/button_widget.dart';
import 'package:tutorial/consts.dart';
import 'package:tutorial/Pages/signup_screen.dart';
class SignInScreen extends StatelessWidget {
   SignInScreen({Key? key}) : super(key: key);

  TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("TikTok Clone", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.red),),
          const SizedBox(height: 20,),
          const Text("Login", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          const SizedBox(height: 30,),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width-20,
                child: TextInputField(text: "Enter username", controller: emailController, icon: Icons.verified_user, isPasswordType: false)),
          ),
          const SizedBox(height: 15,),
          Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width-20,
                child: TextInputField(text: "Enter password", controller: passwordController, icon: Icons.lock_outline, isPasswordType: true)),
          ),
          const SizedBox(height: 20,),
          GestureDetector(
              onTap: ()=>authController.loginUser(emailController.text, passwordController.text),
              child: const ReusableButton(text: "Login")),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?", style: TextStyle(fontSize: 20),),
              const SizedBox(width: 10,),
              InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                  },
                  child: const Text("Register", style: TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),))
            ],
          )
        ],
      )
    );
  }
}
