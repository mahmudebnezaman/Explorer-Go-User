import 'dart:async';

import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/controllers/auth_controller.dart';
import 'package:explorergocustomer/views/home_screen/home.dart';
import 'package:path/path.dart';

class MailVarificationController extends GetxController {
  var isloading = false.obs;
  AuthController authController = Get.find<AuthController>();
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    sendVerificationEmail();
    setTimerForAutoRedirect(context);
  }

  // Send or Resend Email Verification
  Future<void> sendVerificationEmail() async {
    await authController.sendEmailVarification(context);
  }

  // Set timer to check if verification is done and redirect
  void setTimerForAutoRedirect(context) {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      final user = auth.currentUser;
      if (user != null) {
        user.reload();
        if (user.emailVerified) {
          timer.cancel();
          VxToast.show(context, msg: "Email is verified now");
          Get.offAll(() => const Home());
        }
      }
    });
  }

  // Manually check if verification is done and redirect
  void manualRedirect(context) {
    final user = auth.currentUser;
    if (user != null) {
      user.reload();
      if (user.emailVerified) {
        VxToast.show(context, msg: "Email is verified now");
        Get.offAll(() => const Home());
      }
    }
  }

  // Cancel the timer when the controller is disposed
  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  removeUser(String? docId) async {
    await firestore.collection(usersCollection).doc(docId).delete();
  }
}
