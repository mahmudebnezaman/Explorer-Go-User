import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';


class BlogController extends GetxController {
  var isloading = false.obs;
  var isFave = false.obs;

  //textfeild controllers
  var titleController = TextEditingController();
  var locationController = TextEditingController();
  var blogdetailController = TextEditingController();

  var categryList = [].obs;
  List<Category> category = [];
  var blogImagesLinks = [];
  var blogImagesList = RxList<dynamic>.generate(6, (index) => null);

  var categoryValue = ''.obs;

  addToWishlist(docId, context) async {
    await firestore.collection(blogsCollection).doc(docId).set({
      'e_wishlist': FieldValue.arrayUnion([auth.currentUser!.uid])
    }, SetOptions(merge: true));
    isFave(true);
    VxToast.show(context, msg: "Added to wishlist");
  }

  removeFromWishlist(docId, context) async {
    await firestore.collection(blogsCollection).doc(docId).set({
      'e_wishlist': FieldValue.arrayRemove([auth.currentUser!.uid])
    }, SetOptions(merge: true));

    isFave(false);
    VxToast.show(context, msg: "Removed from wishlist");
  }

  checkIfFav(data) async{
    if (data['e_wishlist'].contains(auth.currentUser!.uid)){
      isFave(true);
    }else {
      isFave(false);
    }
  }

  pickImage(index, context) async {
    try {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (img == null){
      return;
    }else{
      blogImagesList[index] = File(img.path);
    }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }

  }

  uploadImages(data) async {
    blogImagesLinks.clear();
    for (var i = 0; i < blogImagesList.length; i++) {
      if(blogImagesList[i] == null && data['e_images'][i] != ''){
         blogImagesLinks.add(data['e_images'][i].toString());
      }
      var item = blogImagesList[i];
      if (item != null) {
        var sequenceNumber = i + 1;
        var filename = '${titleController.value}$sequenceNumber.jpg'; // Replace with your desired file name format
        var destination = 'images/blogs/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var url = await ref.getDownloadURL();
        blogImagesLinks.add(url);
      }
    }
  }
  newUploadImages() async {
    blogImagesLinks.clear();
    for (var i = 0; i < blogImagesList.length; i++) {
      var item = blogImagesList[i];
      if (item != null) {
        var sequenceNumber = i + 1;
        var filename = '${titleController.value}$sequenceNumber.jpg'; // Replace with your desired file name format
        var destination = 'images/blogs/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var url = await ref.getDownloadURL();
        blogImagesLinks.add(url);
      }
    }
  }


  uploadblog(context) async {
    var store = firestore.collection(blogsCollection).doc();
    await store.set({
      'blogdetail' : blogdetailController.text,
      'is_featured': false,
      'categories': categoryValue.value,
      'blogimglinks': FieldValue.arrayUnion(blogImagesLinks),
      'bloglocation': locationController.text,
      'blogtitle': titleController.text,
      'blogwishlist': FieldValue.arrayUnion([])
    });
    VxToast.show(context, msg: "New blog Added");
    isloading(false);
  }
  updateblog(context, docId) async {
    var store = firestore.collection(blogsCollection).doc(docId);
    await store.set({
      'blogdetail' : blogdetailController.text,
      'is_featured': false,
      'categories': categoryValue.value,
      'blogimglinks': FieldValue.arrayUnion(blogImagesLinks),
      'bloglocation': locationController.text,
      'blogtitle': titleController.text,
      'blogwishlist': FieldValue.arrayUnion([])
    });
    // , SetOptions(merge: true));
    VxToast.show(context, msg: "blog Updated");
    isloading(false);
  }

  addFeatured(docId) async {
    await firestore.collection(blogsCollection).doc(docId).set(
      {
        'is_featured': true,
      }, SetOptions(merge: true)
    );
  }

  removeFeatured(docId) async {
    await firestore.collection(blogsCollection).doc(docId).set(
      {
        'is_featured': false,
      }, SetOptions(merge: true)
    );
  }

  removeblog(docId) async{
    await firestore.collection(blogsCollection).doc(docId).delete();
  }

}