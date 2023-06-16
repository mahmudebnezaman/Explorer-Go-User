// ignore_for_file: use_build_context_synchronously

// import 'dart:io';

import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/profile_controller.dart';
// import 'package:explorergocustomer/widgets_common/custom_textfeild.dart';
import 'package:explorergocustomer/widgets_common/custom_passwordfeild.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';

class ChangePassword extends StatefulWidget {

  final dynamic data;
  const ChangePassword({super.key, this.data});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  

  bool isPass = true;
  bool isNewPass = true;
  bool isConfirmPass = true;

  void toggleOldPasswordView() {
    setState(() {
      isPass = !isPass;
    });
  }
  void togglePasswordView() {
    setState(() {
      isNewPass = !isNewPass;
    });
  }
  void toggleConfirmPasswordView() {
    setState(() {
      isConfirmPass = !isConfirmPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var nameIcon = const Icon(Icons.account_circle_outlined, size: 25,);
    var controller = Get.find<ProfileController>();
      
    changePassButtonPress() async {
      //if old password matches database
      if(widget.data['password'] == controller.oldpassController.text){
        await controller.changeAuthPassword(email: auth.currentUser!.email, password: controller.oldpassController.text, newpassword: controller.newpassController.text, context: context);
        await controller.updatePassword(pass: controller.newpassController.text);
        controller.reset();
        VxToast.show(context, msg: 'Password Changed Succefully');
      } else{
        VxToast.show(context, msg: 'Old password didn\'t matched');
        controller.isloading(false);
      }
    }

    void vaildation() async {
      if (controller.oldpassController.text.isEmpty && controller.passController.text.isEmpty && controller.newpassController.text.isEmpty) {
        VxToast.show(context, msg: "Please fill the form");
        controller.isloading(false);
      } else {
        if (controller.oldpassController.text.isEmpty) {
          VxToast.show(context, msg: "Old password feild is empty");
          controller.isloading(false);
        } else if (controller.newpassController.text.isEmpty) {
          VxToast.show(context, msg: "New password feild is Empty");
          controller.isloading(false);
        } else if (controller.passController.text.isEmpty) {
          VxToast.show(context, msg: "Confirm password feild is Empty");
          controller.isloading(false);
        } else if (controller.newpassController.text.length < 8) {
          VxToast.show(context, msg: "Minimum password length is 8");
          controller.isloading(false);
        } else if (controller.passController.text != controller.newpassController.text) {
          VxToast.show(context, msg: "New passwords are not matched");
          controller.isloading(false);
        } else {
          changePassButtonPress();
        }
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: "Change Password".text.make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Obx(
            ()=> Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                customPasswordFeild(
                  hint: passwordHint, title: oldpassword, obsText: isPass, suffixIcon: InkWell(
                    onTap: toggleOldPasswordView,
                    child: Icon(
                      isPass 
                        ? Icons.visibility 
                        : Icons.visibility_off,
                    )),
                  controller: controller.oldpassController
                ),
                10.heightBox,
                customPasswordFeild(
                  hint: passwordHint, title: newpassword, obsText: isNewPass, suffixIcon: InkWell(
                    onTap: togglePasswordView,
                    child: Icon(
                      isNewPass 
                        ? Icons.visibility 
                        : Icons.visibility_off,
                    )),
                  controller: controller.newpassController
                ),
                10.heightBox,
                customPasswordFeild(
                  hint: passwordHint, title: confirmPassword, obsText: isConfirmPass, suffixIcon: InkWell(
                    onTap: toggleConfirmPasswordView,
                    child: Icon(
                      isConfirmPass 
                        ? Icons.visibility 
                        : Icons.visibility_off,
                    )),
                  controller: controller.passController
                ),
                
                const Spacer(),
                controller.isloading.value ? loadingIndicator() : SizedBox(
                  width: context.screenWidth-40,
                  child: myButton(
                    color: primary,
                    buttonSize: 20.0,
                    onPress: ()async{
          
                      controller.isloading(true);
                      vaildation();
                   },
                    textColor: whiteColor,
                    title: 'Change Password',
                  ),
                ),
                
              ],
            ),
          ),
        ),
      );
  }
}