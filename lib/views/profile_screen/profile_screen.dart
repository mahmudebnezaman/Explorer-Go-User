// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/auth_controller.dart';
import 'package:explorergocustomer/controllers/profile_controller.dart';
import 'package:explorergocustomer/views/profile_screen/change_password.dart';
import 'package:explorergocustomer/views/profile_screen/edit_profile.dart';

// import 'package:explorergocustomer/consts/lists.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/views/auth_screen/login_screen.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: StreamBuilder(
        stream: FireStoreServices.getUser(auth.currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
              return Center(child: loadingIndicator());
            } else {
      
              var data = snapshot.data!.docs[0];
              return Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          data['imageUrl'] == '' ? Image.asset(icUser,fit: BoxFit.cover,height: 100,width: 100, color: fontGrey,).box.clip(Clip.antiAlias).roundedFull.border(color: whiteColor, width: 2).white.shadow3xl.make() 
                          : Image.network(data['imageUrl'],fit: BoxFit.cover,height: 100,width: 100).box.clip(Clip.antiAlias).roundedFull.white.shadow3xl.make(),
                          if(data['password'] != '') Align(
                            alignment: Alignment.bottomRight,
                            child: Image.asset(icPencil,fit: BoxFit.fill,color: highEmphasis,height: 15,).box.roundedFull.white.padding(const EdgeInsets.all(4)).shadowSm.make().onTap(() {controller.nameController.text = data['name'];
                              Get.to(()=> EditProfileInfo(data: data,));})),
        
                        ],
                      ).box.height(100).width(100).make(),
                      10.heightBox,
                      "${data['name']}".text.size(20).fontFamily(bold).color(highEmphasis).make(),
                      "${data['email']}".text.size(18).fontFamily(regular).color(fontGrey).make(),
                    ],
                  ),
                ),
                10.heightBox,
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Inbox".text.color(highEmphasis).size(18).fontFamily(bold).make(),
                    Image.asset(icRight, height: 18, color: lightGrey,)
                  ],
                ),
                const Divider(),
                "Personal Details".text.color(highEmphasis).size(18).fontFamily(bold).make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Emergency Contact".text.color(fontGrey).size(16).fontFamily(regular).make(),
                    Image.asset(icRight, height: 18, color: lightGrey,)
                  ],
                ),
                2.heightBox,
                if(data['password'] != '') Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Change Password".text.color(fontGrey).size(16).fontFamily(regular).make(),
                    Image.asset(icRight, height: 18, color: lightGrey,)
                  ],
                ).onTap(() {Get.to(()=>ChangePassword(data: data,));}),
                const Divider(),
                "Help & Support".text.color(highEmphasis).size(18).fontFamily(bold).make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Terms & Conditions".text.color(fontGrey).size(16).fontFamily(regular).make(),
                    Image.asset(icRight, height: 18, color: lightGrey,)
                  ],
                ),
                2.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Privacy Policy".text.color(fontGrey).size(16).fontFamily(regular).make(),
                    Image.asset(icRight, height: 18, color: lightGrey,)
                  ],
                ),
                2.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Refund & Cancellation".text.color(fontGrey).size(16).fontFamily(regular).make(),
                    Image.asset(icRight, height: 18, color: lightGrey,)
                  ],
                ),
                const Spacer(),
                myButton(
                  buttonSize: 20.0,
                  textColor: primary,
                  color: whiteColor,
                  onPress: () async {
                    await Get.put(AuthController()).signoutMethod(context);
                    Get.offAll( ()=> const LoginScreen());
                    },
                  title: signout
                ).box.border(color: primary, width: 2).roundedSM.width(context.screenWidth).make()
              ]),
          );
          }

        },
      ),
    );
  }
}
