
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
// import 'package:path/path.dart';


class BlogController extends GetxController {
  var isloading = false.obs;
  var isFave = false.obs;
  
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
 
}