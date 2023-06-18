import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {

  var profileImagePath = ''.obs;

  var profileImageLink = '';

  var isloading = false.obs;

  //textfield
  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var passController = TextEditingController();
  var newpassController = TextEditingController();

  var emergencycontactController = TextEditingController();
  var emergencycontactNameController = TextEditingController();
 
  changeImage(context) async{
    try {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (img == null) return ;
    profileImagePath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var filename = basename(profileImagePath.value);
    var destination = 'images/${auth.currentUser!.uid}$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile({name, imgUrl}) async {
    var store = firestore.collection(usersCollection).doc(auth.currentUser!.uid);
    await store.set({
      'name': name,
      'imageUrl': imgUrl
    },SetOptions(merge: true));
    isloading(false);
  }

  changeAuthPassword({email, password, newpassword, context}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await auth.currentUser!.reauthenticateWithCredential(cred).then((value){
      auth.currentUser!.updatePassword(newpassword);
    }).catchError((error){
      VxToast.show(context, msg: error);
    });
  }

  updatePassword({required pass}) async {
    var store = firestore.collection(usersCollection).doc(auth.currentUser!.uid);
    await store.set({
      'password': pass,
    },SetOptions(merge: true));
    isloading(false);
  }

  updateEmergencyContact({required contact, required name}) async {
    var store = firestore.collection(usersCollection).doc(auth.currentUser!.uid);
    await store.set({
      'emergency_contact': contact,
      'emergency_contact_name': name
    },SetOptions(merge: true));
    isloading(false);
  }

  void reset() {
    profileImagePath.value = '';
    profileImageLink = '';
    isloading.value = false;
    nameController.clear();
    oldpassController.clear();
    passController.clear();
    newpassController.clear();
  }

}