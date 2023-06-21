// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/profile_controller.dart';
import 'package:explorergocustomer/widgets_common/custom_textfeild.dart';
import 'package:explorergocustomer/widgets_common/custom_passwordfeild.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';

class EditProfileInfo extends StatefulWidget {

  final dynamic data;
  const EditProfileInfo({super.key, this.data});

  @override
  State<EditProfileInfo> createState() => _EditProfileInfoState();
}

class _EditProfileInfoState extends State<EditProfileInfo> {
  

  bool isPass = true;

  void togglePasswordView() {
    setState(() {
      isPass = !isPass;
    });
  }

  @override
  Widget build(BuildContext context) {
    var nameIcon = const Icon(Icons.account_circle_outlined, size: 25,);
    var controller = Get.find<ProfileController>();

    return WillPopScope(
      onWillPop: () async {
        controller.reset();
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Obx(
              ()=> Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                      children: [
                        widget.data['imageUrl'] == '' && controller.profileImagePath.isEmpty? Image.asset(icUser,fit: BoxFit.cover,height: 100,width: 100, color: fontGrey,).box.clip(Clip.antiAlias).roundedFull.white.shadow3xl.make()
                        : widget.data['imageUrl'] != '' && controller.profileImagePath.isEmpty? Image.network(widget.data['imageUrl'],fit: BoxFit.cover,height: 100,width: 100).box.clip(Clip.antiAlias).roundedFull.border(color: whiteColor, width: 2).white.shadow3xl.make()
                        : Image.file(File(controller.profileImagePath.value), width: 100, fit: BoxFit.cover,).box.clip(Clip.antiAlias).roundedFull.border(color: whiteColor, width: 2).white.shadow3xl.make(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(icPencil,fit: BoxFit.fill,color: highEmphasis,height: 15,).box.roundedFull.white.padding(const EdgeInsets.all(4)).shadowSm.make().onTap(() {
                      controller.changeImage(context);})),
    
                      ],
                    ).box.height(100).width(100).make(),
                  const Divider(),
                  20.heightBox,
                  customTextFeild(
                    controller: controller.nameController,
                    hint: nameHint,
                    title: name,
                    prefixIcon: nameIcon,
                  ),
                  10.heightBox,
                  customPasswordFeild(hint: passwordHint, title: password, obsText: isPass, suffixIcon: InkWell(
                      onTap: togglePasswordView,
                      child: Icon(
                        isPass 
                          ? Icons.visibility 
                          : Icons.visibility_off,
                      )), controller: controller.passController),
                  
                  const Spacer(),
                  controller.isloading.value ? loadingIndicator() : SizedBox(
                    width: context.screenWidth-40,
                    child: myButton(
                      color: primary,
                      buttonSize: 20.0,
                      onPress: ()async{
            
                        controller.isloading(true);
            
                        //if image is not selected
                        if(controller.profileImagePath.value.isNotEmpty){
                          await controller.uploadProfileImage();
                        } else {
                          controller.profileImageLink = widget.data['imageUrl'];
                        }
            
                        //if old password matches database
                        if(widget.data['password'] == controller.passController.text){
                          await controller.updateProfile(
                          imgUrl: controller.profileImageLink,
                          name: controller.nameController.text,
                          );
                          VxToast.show(context, msg: 'Updated');
                        } else{
                          VxToast.show(context, msg: 'Password doesnot matched with old password');
                          controller.isloading(false);
                        }
                     },
                      textColor: whiteColor,
                      title: 'Save',
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ),
    );
  }
}