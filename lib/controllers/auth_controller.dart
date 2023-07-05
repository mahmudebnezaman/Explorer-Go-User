import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  @override
  void onInit() {
    // Initialize your controller here
    super.onInit();
  }

  var isloading = false.obs;

  //text controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Future<UserCredential?> loginMethod({context, profileController}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      update();
    } on FirebaseAuthException {
      VxToast.show(context, msg: "Please use valid email & password!");
    }
    isloading(false);
    return userCredential;
  }

  Future<UserCredential?> signupMethod(
      {required email, required password, context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //storing data method

  storeUserData({required name, required password, required email}) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(auth.currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': auth.currentUser!.uid,
      'emergency_contact': '',
      'emergency_contact_name': '',
      'role': 'user'
    });
  }
  editRoleAsAdmin(docId) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(docId);
    store.set({
      'role': 'admin'
    }, SetOptions(merge: true));
  }
  editRoleAsUser(docId) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(docId);
    store.set({
      'role': 'user'
    }, SetOptions(merge: true));
  }

  //Email varification
  Future<void> sendEmailVarification(context) async{
    try {
      await auth.currentUser?.sendEmailVerification();
    }on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  //signout method
  signoutMethod(context) async {
    try {
      await GoogleSignIn().signOut(); 
      await auth.signOut();
      emailController.clear(); // clear the email controller
      passwordController.clear(); // clear the password controller
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    isloading(false);
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
    storeGoogleUserData({required name, required email, required imgUrl}) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(auth.currentUser!.uid);
    store.set({
      'name': name,
      'password': '',
      'email': email,
      'imageUrl': imgUrl,
      'id': auth.currentUser!.uid,
      'emergency_contact': '',
      'emergency_contact_name': '',
      'role': 'user',
    });
  }
}
