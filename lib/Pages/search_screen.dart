import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial/Controllers/search_controller.dart';
import 'package:tutorial/Pages/profile_screen.dart';
import 'package:tutorial/consts.dart';
import '../Models/userModel.dart';
class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  final SearchController searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: buttonColor,
            title: TextFormField(
              decoration: const InputDecoration(
                filled: false,
                hintText: "Search",
                  hintStyle: TextStyle(fontSize: 18, color: Colors.white)
              ),
              onFieldSubmitted: (value)=>searchController.searchUser(value),
            ),
          ),
          body: searchController.searchedUser.isEmpty?Column(
            children:const [
              Center(child: Text("Search for users", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),))
            ],
          ): ListView.builder(
              itemCount: searchController.searchedUser.length,
              itemBuilder: (context, index){
                User user = searchController.searchedUser[index];
            return InkWell(
              onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileScreen(uid: user.uid))),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePhoto),
                ),
                title: Text(user.name, style: const TextStyle(fontSize: 18),),
              ),
            );
          }),
        );
      }
    );
  }
}