import 'dart:async';

import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/controllers/auth_controller.dart';
import 'package:explorergocustomer/views/home_screen/home.dart';
import 'package:path/path.dart';

class MailVarificationController extends GetxController {
  // late Timer _timer;

  @override
  void onInit(){
    super.onInit();
    sendVerificationEmail();
    setTimerForAutoRedirect(context);
  }

  //Send or Resend Email Verification
  Future<void> sendVerificationEmail() async {
    await AuthController.instance.sendEmailVarification(context);
  }

  //set timer to check if verification is done and redirect
  void setTimerForAutoRedirect(context){
    Timer.periodic(const Duration(seconds: 3), (timer) {
      auth.currentUser?.reload();
      final user = auth.currentUser;
      if (user!.emailVerified){
        timer.cancel();
        VxToast.show(context, msg: "Email is varified now");
        Get.offAll(()=>const Home());
      }
    });
  }

  //set timer to check if verification is done and redirect
  void manualRedirect(context){
    auth.currentUser?.reload();
    final user = auth.currentUser;
    if (user!.emailVerified){
      VxToast.show(context, msg: "Email is varified now");
      Get.offAll(()=>const Home());
    }
  }

}