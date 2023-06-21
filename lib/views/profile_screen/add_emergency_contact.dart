// ignore_for_file: use_build_context_synchronously
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/profile_controller.dart';
import 'package:explorergocustomer/widgets_common/custom_textfeild.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';

class EmergencyContact extends StatefulWidget {

  final dynamic data;
  const EmergencyContact({super.key, this.data});

  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  late ProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ProfileController>();
    controller.emergencycontactController.text = widget.data['emergency_contact'];
    controller.emergencycontactNameController.text = widget.data['emergency_contact_name'];
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async {
        controller.reset();
        return true;
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: "Emergency Contact".text.make(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Obx(
              ()=> Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  customTextFeild(
                    title: name,
                    hint: "Given Name",
                    prefixIcon: const Icon(Icons.account_circle_outlined, size: 25,),
                    controller: controller.emergencycontactNameController,
                  ),
    
                  10.heightBox,
                  
                  customTextFeild(
                    title: "Emergency Contact",
                    hint: "e.g. 012345678912",
                    prefixIcon: const Icon(Icons.mobile_friendly_outlined),
                    controller: controller.emergencycontactController,
                    keytype: TextInputType.number,
                    maxLength: 11
                  ),
                  
                  const Spacer(),
                  controller.isloading.value ? loadingIndicator() : SizedBox(
                    width: context.screenWidth-40,
                    child: myButton(
                      color: primary,
                      buttonSize: 20.0,
                      onPress: ()async{
                        controller.isloading(true);
                        await controller.updateEmergencyContact(
                          contact: controller.emergencycontactController.text,
                          name: controller.emergencycontactNameController.text
                        );
                        VxToast.show(context, msg: 'Saved');
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