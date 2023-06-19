import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';

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

  confirmOrderController(var tripnameId, var date) async {
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
        'status': "pending"
      }
    );
    isloading(false);
    resetValues();
  }
}