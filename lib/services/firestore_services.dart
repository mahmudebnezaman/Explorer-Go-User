import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';

class FireStoreServices{
  static getUser(uid){
    return firestore.collection(usersCollection).where('id',isEqualTo: uid).snapshots();
  }

  static getAllUser(){
    return firestore.collection(usersCollection).orderBy('role').snapshots();
  }

//get products according to category
  static getEvents(category){
    if(category == "All" || category == "See All"){
      return firestore.collection(eventsCollection).snapshots();
    } else {
      return firestore.collection(eventsCollection).where('categories', isEqualTo: category).snapshots();
    }
  }

//get products according to category
  static getUpcomingEvents(category){
    if(category == "All" || category == popular){
      return firestore.collection(eventsCollection).snapshots();
    } else if(category == recomended) {
    return firestore.collection(eventsCollection).where('is_featured', isEqualTo: true).snapshots();
    }
  }

//get blogs according to category
  static getBlogs(category){
    if(category == "All" || category == "See All"){
      return firestore.collection(blogsCollection).snapshots();
    } else {
      return firestore.collection(blogsCollection).where('categories', isEqualTo: category).snapshots();
    }
  }

  //get wishlist
  static getSaved(uid){
    return firestore.collection(eventsCollection).where('e_wishlist', arrayContains: uid).snapshots();
  }

  //get all chat messages
  static getChatMessages (docId){
    return firestore.collection(chatsCollection).doc(docId).collection(messagesCollection).orderBy('created_on', descending: false).snapshots();
  }

  //get featured products
  static getFeaturedProducts(){
    return firestore.collection(eventsCollection).where('is_featured', isEqualTo: true).snapshots();
  }

  //get featured blogs
  static getFeaturedBlogs(){
    return firestore.collection(blogsCollection).where('is_featured', isEqualTo: true).snapshots();
  }

  //get promotions
  static getPromotionalProducts(){
    return firestore.collection(promotionalCollection).snapshots();
  }

  //search products
  static searchProducts(title){
    return firestore.collection(eventsCollection).get();
  }

  static getBookings(category){
    if(category == "Upcoming"){
      return firestore.collection(bookingsCollection).where('traveler_id', isEqualTo: auth.currentUser!.uid).where('status', whereIn: ["Active" , "Pending"]).snapshots();
    } else if (category == "Upcoming"){
      return firestore.collection(bookingsCollection).where('traveler_id', isEqualTo: auth.currentUser!.uid).where('status', isEqualTo: "Active").snapshots();
    } else if (category == "Previous"){
      return firestore.collection(bookingsCollection).where('traveler_id', isEqualTo: auth.currentUser!.uid).where('status', isEqualTo: "Previous").snapshots();
    } else if (category == "Cancelled"){
      return firestore.collection(bookingsCollection).where('traveler_id', isEqualTo: auth.currentUser!.uid).where('status', isEqualTo: "Cancelled").snapshots();
    }
  }

  static adminGetBookings(category){
    if(category == "Upcoming"){
      return firestore.collection(bookingsCollection).where('status', whereIn: ["Active" , "Pending"]).snapshots();
    } else if (category == "Upcoming"){
      return firestore.collection(bookingsCollection).where('status', isEqualTo: "Active").snapshots();
    } else if (category == "Previous"){
      return firestore.collection(bookingsCollection).where('status', isEqualTo: "Previous").snapshots();
    } else if (category == "Cancelled"){
      return firestore.collection(bookingsCollection).where('status', isEqualTo: "Cancelled").snapshots();
    }
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getBookingDetails(String dataid) {
    var bookingRef = FirebaseFirestore.instance.collection('bookings').doc(dataid);
    return bookingRef.snapshots();
  }
}
