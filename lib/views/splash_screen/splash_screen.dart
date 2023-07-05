import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/controllers/auth_controller.dart';
import 'package:explorergocustomer/views/admin_home_screen/admin_home.dart';
import 'package:explorergocustomer/views/auth_screen/email_varification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:explorergocustomer/views/auth_screen/login_screen.dart';
import 'package:explorergocustomer/views/home_screen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

var authcontroller = Get.put(AuthController());

void changeScreen() {
  auth.authStateChanges().listen((User? user) {
    if (user == null && mounted) {
      Get.offAll(() => const LoginScreen());
    } else if (user != null) {
      user.reload().then((_) {
        if (user.emailVerified) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(auth.currentUser!.uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              final userRole = documentSnapshot.get('role') as String;
              if (userRole == 'admin') {
                Get.offAll(() => const AdminHome());
              } else if (userRole == 'user') {
                Get.offAll(() => const Home());
              }
            }
          });
        } else {
          Get.offAll(() => const EmailVarificationScreen());
        }
      });
    }
  });
}

  @override
  void initState(){
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: highEmphasis,
      body: Center(
        child: Column(
          children: [
            300.heightBox,
            Image.asset(icAppLogo).box.size(220, 220).make(),
            const Spacer(),
            const CircularProgressIndicator(
              color: whiteColor,
            ),
            10.heightBox,
            credits.text.fontFamily(semibold).white.make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}