import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
class HomeController extends GetxController {

  @override
  void onInit(){
    getUsername();
    super.onInit();
  }

  var currentNavIndex = 0.obs;

  var searchController = TextEditingController();

  var username = '';

    var promotionalImagesLinks = [];
  var promotionalImagesList = RxList<dynamic>.generate(6, (index) => null);

  var isloading = false.obs;

  getUsername() async
{
  var n = await firestore.collection(usersCollection).where('id',isEqualTo: auth.currentUser!.uid).get().then((value){
    if (value.docs.isNotEmpty) {
      return value.docs.single['name'];
    }
  });
  username = n;
}

pickImage(index, context) async {
    try {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (img == null){
      return;
    }else{
      promotionalImagesList[index] = File(img.path);
    }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }

  }
  changePromotionalImages(data) async {
    promotionalImagesLinks.clear();
    for (var i = 0; i < promotionalImagesList.length; i++) {
      if(promotionalImagesList[i] == null && data['promotinal_image'][i] != ''){
         promotionalImagesLinks.add(data['promotinal_image'][i].toString());
      }
      var item = promotionalImagesList[i];
      if (item != null) {
        var sequenceNumber = i + 1;
        var filename = 'promotional$sequenceNumber.jpg'; // Replace with your desired file name format
        var destination = 'images/promotions/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var url = await ref.getDownloadURL();
        promotionalImagesLinks.add(url);
      }
    }
  }
  updatePromotion(context, docId) async {
    var store = firestore.collection('promotions').doc(docId);
    await store.set({
      'promotinal_image': FieldValue.arrayUnion(promotionalImagesLinks)
    });
    // , SetOptions(merge: true));
    VxToast.show(context, msg: "Promotions Updated");
    isloading(false);
  }


}