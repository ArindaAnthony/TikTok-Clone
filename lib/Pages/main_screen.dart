import 'package:flutter/material.dart';
import 'package:tutorial/Widgets/custom_icon.dart';
import '../consts.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController pageController;
  int pageIndex=0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        onTap: (index){
          setState(() {
            pageIndex =index;
          });
        },
        currentIndex: pageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home" ),
          BottomNavigationBarItem(icon: Icon(Icons.search, size: 30,), label: "Search"),
          BottomNavigationBarItem(icon: CustomIcon(), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.message_outlined),label: "Message" ),
          BottomNavigationBarItem(icon: Icon(Icons.person_2_outlined),label: "Profile" ),
        ],
      ),
      body: pages[pageIndex]

      /*Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: InkWell(
                onTap: ()=> authController.signOut(),
                child: const ReusableButton(text: "LOG OUT")),
          ),
          const SizedBox(height: 40,),
          InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ImagePage()));
              },
              child: const ReusableButton(text: "Image Page"))
        ],
      ),*/
    );
  }
}
