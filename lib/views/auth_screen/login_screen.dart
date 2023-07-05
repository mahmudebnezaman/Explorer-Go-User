import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';

import 'package:explorergocustomer/controllers/auth_controller.dart';
import 'package:explorergocustomer/views/admin_home_screen/admin_home.dart';

import 'package:explorergocustomer/views/auth_screen/email_varification_screen.dart';
import 'package:explorergocustomer/views/auth_screen/forgot_password_reset_email.dart';
import 'package:explorergocustomer/views/auth_screen/signup_screen.dart';
import 'package:explorergocustomer/views/home_screen/home.dart';

import 'package:explorergocustomer/widgets_common/custom_textfeild.dart';
import 'package:explorergocustomer/widgets_common/custom_passwordfeild.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

class _LoginScreenState extends State<LoginScreen> {

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


  bool? isCheck = false;
  var controller = Get.put(AuthController());

  void vaildation() async {
    if (controller.emailController.text.isEmpty && controller.passwordController.text.isEmpty) {
      VxToast.show(context, msg: "Please fill the signin form");
    } else {
      if (controller.emailController.text.isEmpty) {
      VxToast.show(context, msg: "Email feild is Empty");
    } else if (!regExp.hasMatch(controller.emailController.text)) {
      VxToast.show(context, msg: "Please Try Vaild Email");
    }  else if (controller.passwordController.text.isEmpty) {
      VxToast.show(context, msg: "Password feild is Empty");
    }else {
      signinButtonPress();
    }
    }
  }

  signinButtonPress() async {
    controller.isloading(true);
      await controller.loginMethod(context: context).then((value) {
        if(value != null){
          VxToast.show(context, msg: signedin);
          controller.forgotPass();
          changeScreen();
        } else{
          controller.isloading(false);
        }
      });
  }
  
  bool isPass = true;

  void togglePasswordView() {
    setState(() {
      isPass = !isPass;
    });
  }


  @override
  Widget build(BuildContext context) {

   return Scaffold(
    resizeToAvoidBottomInset: false,
    backgroundColor: whiteColor,
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(icAppLogoFull, width: 250,),
                // "skip".text.color(textfieldGrey).size(16).fontFamily(semibold).make().onTap(() {Get.to(()=> const Home());}),
              ],
            ),


            5.heightBox,
            signin.text.fontFamily(bold).size(35).color(highEmphasis).make(),
            25.heightBox,
            createNewAccount.text.color(darkFontGrey).size(20).fontFamily(semibold).make(),
            5.heightBox,
            registerHere.text.color(primary).size(20).fontFamily(semibold).make().onTap((){
              Get.to(()=> const SignUp());
            }),
            
            25.heightBox,
            Obx(()=>
             Column(
                children: [
                  customTextFeild(hint: emailHint, title: email, prefixIcon: emailIcon, controller: controller.emailController),
                  10.heightBox,
                  customPasswordFeild(hint: passwordHint, title: password, obsText: isPass, suffixIcon: InkWell(
                    onTap: togglePasswordView,
                    child: Icon(
                      isPass 
                        ? Icons.visibility 
                        : Icons.visibility_off,
                    )), controller: controller.passwordController),
                  10.heightBox,
                  forgetPass.text.size(15).color(primary).make().onTap(() {Get.to(()=> const ForgotPasswordEmailScreen());}),
                  10.heightBox,
                  controller.isloading.value ?  loadingIndicator() : myButton(
                    color: primary,
                    onPress: () {
                      vaildation();
                    },
                    textColor: whiteColor,
                    title: signin,
                    buttonSize: 20.0,
                  ).box.width(context.screenWidth).make(),
                ],
              ),
            ),

            10.heightBox,
            Align(
              alignment: Alignment.center,
              child: 'or'.text.color(fontGrey).size(16).fontFamily(semibold).make(),
            ),

            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(icGoogleLogo, height: 25,),
                20.widthBox,
                loginWith.text.semiBold.color(darkFontGrey).size(18).make()
              ],
            ).box.border(color: primary, width: 2).padding(const EdgeInsets.all(12)).roundedSM.make().onTap(() async {
              controller.isloading(true);
              await controller.signInWithGoogle().then((value) async {
                // return controller.storeGoogleUserData(name: auth.currentUser!.displayName.toString(), email: auth.currentUser!.email.toString(), imgUrl: auth.currentUser!.photoURL.toString());
                final userExists = await checkUserExists(auth.currentUser!.uid);
                if (!userExists) {
                    return controller.storeGoogleUserData(
                      name: auth.currentUser!.displayName.toString(),
                      email: auth.currentUser!.email.toString(),
                      imgUrl: auth.currentUser!.photoURL.toString(),
                    );
                }
              });
            })
          ],
        ),
      ),
    ),
   );
  }
}

Future<bool> checkUserExists(String userId) async {
  final snapshot = await firestore.collection(usersCollection).doc(userId).get();
  return snapshot.exists;
}