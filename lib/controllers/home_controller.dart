import 'package:explorergocustomer/consts/consts.dart';
// import 'package:get/get.dart';

class HomeController extends GetxController {

  @override
  void onInit(){
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;

  var searchController = TextEditingController();

  var username = '';

  getUsername() async
{
  var n = await firestore.collection(usersCollection).where('id',isEqualTo: auth.currentUser!.uid).get().then((value){
    if (value.docs.isNotEmpty) {
      return value.docs.single['name'];
    }
  });
  username = n;
}

}