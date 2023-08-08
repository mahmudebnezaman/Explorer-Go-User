import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
class ProductController extends GetxController {

  var quantity = 0.obs;
  var totalPrice = 0.obs;

  var isloading = false.obs;

  var isFave = false.obs;
  var searchController = TextEditingController();

  var bookingNameController = TextEditingController();
  var bookingEmailController = TextEditingController();
  var bookingNumberController = TextEditingController();
  var bookinglocationController = TextEditingController();
  var bookingdateController = TextEditingController();
  var titleController = TextEditingController();
  var durationController = TextEditingController();
  var sailingController = TextEditingController();
  var priceController = TextEditingController();
  var locationController = TextEditingController();
  var overviewController = TextEditingController();
  var seatsController = TextEditingController();
  var pickupNoteController = TextEditingController();
  var timingController = TextEditingController();
  var itineraryController = TextEditingController();
  var inclusionController = TextEditingController();
  var descripctionController = TextEditingController();
  var aditioninfoController = TextEditingController();
  var travelTipsController = TextEditingController();
  var optionsController = TextEditingController();
  var policyController = TextEditingController();
  var bookingTitleController = TextEditingController();
  var bookingSailingController = TextEditingController();
  var bookingTravNumController = TextEditingController();
  var bookingPriceController = TextEditingController();
  var bookingLocationController = TextEditingController();
  var bookingPickupNoteController = TextEditingController();
  var bookingItineraryController = TextEditingController();
  var bookingTravNameController = TextEditingController();
  var bookingTravEmailController = TextEditingController();
  var bookingTravContactController = TextEditingController();

  increseQuantity(totalQuantity){
    if (quantity.value < totalQuantity) {
    quantity.value++;}
  }

  decressQuantity(){
    if(quantity.value>0){
    quantity.value--;}
  }
  calculateTotalPrice(price){
    totalPrice.value = price*quantity.value;
  }

  resetValues(){
    totalPrice.value = 0;
    quantity.value = 0;
    bookingEmailController.clear();
    bookingNameController.clear();
    bookingNumberController.clear();
    bookinglocationController.clear();
    bookingdateController.clear();
  } 

  addToWishlist(docId, context) async {
    await firestore.collection(eventsCollection).doc(docId).set({
      'e_wishlist': FieldValue.arrayUnion([auth.currentUser!.uid])
    }, SetOptions(merge: true));
    isFave(true);
    VxToast.show(context, msg: "Added to wishlist");
  }

  removeFromWishlist(docId, context) async {
    await firestore.collection(eventsCollection).doc(docId).set({
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

  confirmOrderController(var tripnameId, var date, var img, var location, var pickup, var itinerary) async {
    await firestore.collection(bookingsCollection).doc().set(
      {
        'trip_name': tripnameId,
        'traveler_name': bookingNameController.text,
        'traveler_email': bookingEmailController.text,
        'traveler_mobile': bookingNumberController.text,
        'e_date': date,
        'traveler_count': quantity.value,
        'total_price': totalPrice.value,
        'traveler_id': auth.currentUser!.uid,
        'status': "Pending",
        'img_url': img,
        'location': location,
        'Pickup Note': pickup,
        'Itinerary': itinerary,
      }
    );
    isloading(false);
    resetValues();
  }

  var categryList = [].obs;
  List<Category> category = [];
  var eventImagesLinks = [];
  var eventImagesList = RxList<dynamic>.generate(6, (index) => null);

  var categoryValue = ''.obs;

  pickImage(index, context) async {
    try {
    final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (img == null){
      return;
    }else{
      eventImagesList[index] = File(img.path);
    }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }

  }

  uploadImages(data) async {
    eventImagesLinks.clear();
    for (var i = 0; i < eventImagesList.length; i++) {
      if(eventImagesList[i] == null && data['e_images'][i] != ''){
         eventImagesLinks.add(data['e_images'][i].toString());
      }
      var item = eventImagesList[i];
      if (item != null) {
        var sequenceNumber = i + 1;
        var filename = '${titleController.value}$sequenceNumber.jpg'; // Replace with your desired file name format
        var destination = 'images/vendors/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var url = await ref.getDownloadURL();
        eventImagesLinks.add(url);
      }
    }
  }
  newUploadImages() async {
    eventImagesLinks.clear();
    for (var i = 0; i < eventImagesList.length; i++) {
      var item = eventImagesList[i];
      if (item != null) {
        var sequenceNumber = i + 1;
        var filename = '${titleController.value}$sequenceNumber.jpg'; // Replace with your desired file name format
        var destination = 'images/vendors/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var url = await ref.getDownloadURL();
        eventImagesLinks.add(url);
      }
    }
  }


  uploadEvent(context) async {
    var store = firestore.collection(eventsCollection).doc();
    await store.set({
      'is_featured': false,
      'categories': categoryValue.value,
      'duration': durationController.text,
      'e_date': sailingController.text,
      'e_images': FieldValue.arrayUnion(eventImagesLinks),
      'e_location': locationController.text,
      'e_price': priceController.text,
      'e_title': titleController.text,
      'e_wishlist': FieldValue.arrayUnion([]),
      'Overview': overviewController.text,
      'Pickup Note': pickupNoteController.text,
      'Timing': timingController.text,
      'Itinerary': itineraryController.text,
      'Inclusion & Exclusion': inclusionController.text,
      'Description': descripctionController.text,
      'Additional Information': aditioninfoController.text,
      'Travel Tips': travelTipsController.text,
      'Options': optionsController.text,
      'Policy': policyController.text,
      'available_seats': seatsController.text
    });
    VxToast.show(context, msg: "New Event Added");
    isloading(false);
  }
  updateEvent(context, docId) async {
    var store = firestore.collection(eventsCollection).doc(docId);
    await store.set({
      'is_featured': false,
      'categories': categoryValue.value,
      'duration': durationController.text,
      'e_date': sailingController.text,
      'e_images': FieldValue.arrayUnion(eventImagesLinks),
      'e_location': locationController.text,
      'e_price': priceController.text,
      'e_title': titleController.text,
      'e_wishlist': FieldValue.arrayUnion([]),
      'Overview': overviewController.text,
      'Pickup Note': pickupNoteController.text,
      'Timing': timingController.text,
      'Itinerary': itineraryController.text,
      'Inclusion & Exclusion': inclusionController.text,
      'Description': descripctionController.text,
      'Additional Information': aditioninfoController.text,
      'Travel Tips': travelTipsController.text,
      'Options': optionsController.text,
      'Policy': policyController.text,
      'available_seats': seatsController.text
    }
    , SetOptions(merge: true));
    VxToast.show(context, msg: "Event Updated");
    isloading(false);
  }

  addFeatured(docId) async {
    await firestore.collection(eventsCollection).doc(docId).set(
      {
        'is_featured': true,
      }, SetOptions(merge: true)
    );
  }

  removeFeatured(docId) async {
    await firestore.collection(eventsCollection).doc(docId).set(
      {
        'is_featured': false,
      }, SetOptions(merge: true)
    );
  }

  removeEvent(docId) async{
    await firestore.collection(eventsCollection).doc(docId).delete();
  }

  cancelBooking(docId) async {
    await firestore.collection(bookingsCollection).doc(docId).set(
      {
        'status': "Cancelled",
      }, SetOptions(merge: true)
    );
  }

  confirmBooking(docId) async {
    await firestore.collection(bookingsCollection).doc(docId).set(
      {
        'status': "Active",
      }, SetOptions(merge: true)
    );
  }

  pastooking(docId) async {
    await firestore.collection(bookingsCollection).doc(docId).set(
      {
        'status': "Previous",
      }, SetOptions(merge: true)
    );
  }

  updateOrderController(var docid) async {
    await firestore.collection(bookingsCollection).doc(docid).set(
      {
        'trip_name': bookingTitleController.text,
        'traveler_name': bookingTravNameController.text,
        'traveler_email': bookingTravEmailController.text,
        'traveler_mobile': bookingTravContactController.text,
        'e_date': bookingSailingController.text,
        'traveler_count': bookingTravNameController.text,
        'total_price': bookingPriceController.text,
        'location': bookingLocationController.text,
        'Pickup Note': bookingPickupNoteController.text,
        'Itinerary': bookingItineraryController.text,
      }, SetOptions(merge: true)
    );
    isloading(false);
  }

}