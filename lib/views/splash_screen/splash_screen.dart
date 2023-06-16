import 'package:explorergocustomer/consts/consts.dart';
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

changeScreen(){
    Future.delayed(const Duration(seconds: 2),(){
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted){
          Get.offAll (()=>const LoginScreen());
        } else if (user!.emailVerified){
          Get.offAll(()=>const Home());
        }
         else {
          Get.offAll(()=>const EmailVarificationScreen());
        }
      });
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
            credits.text.fontFamily(semibold).white.make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}