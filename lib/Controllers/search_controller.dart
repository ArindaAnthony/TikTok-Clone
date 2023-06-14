import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tutorial/consts.dart';
import '../Models/userModel.dart';


class SearchController extends GetxController {
  final Rx<List<User>> _searchedUser = Rx<List<User>>([]);
  List<User> get searchedUser => _searchedUser.value;

  searchUser(String typedUser)async{
    _searchedUser.bindStream(
      firestore.collection("users").where("name", isGreaterThanOrEqualTo: typedUser).snapshots().map((QuerySnapshot query) {
        List<User> retVal = [];
        for(var element in query.docs){
          retVal.add(User.fromSnap(element));
        }
        return retVal;
      })
    );
  }
}