import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/auth_controller.dart';
import 'package:explorergocustomer/widgets_common/custom_textfeild.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {

  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() => _ForgotPasswordEmailScreenState();
}

  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);
class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final AuthController authController = Get.put(AuthController());

    void vaildation() async {
    if (authController.forgotPassEmailController.text.isEmpty) {
      VxToast.show(context, msg: "Please fill the email field");
    } else {
      if (!regExp.hasMatch(authController.forgotPassEmailController.text)) {
      VxToast.show(context, msg: "Please Try Vaild Email");
    } else {
      auth.sendPasswordResetEmail(email:  authController.forgotPassEmailController.text).then((value) { 
        VxToast.show(context, msg: 'We have sent you an email with password reset link.');
        authController.isloading(false);
        Get.back();
      });
    }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
    resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(imgForgotPassBg)
            ),
            Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(icAppLogoFull, width: 250,),
                  ],
                ),
        
                5.heightBox,
                findyouraccout.text.bold.size(25).color(highEmphasis).make(),
                
                25.heightBox,
                // Obx(()=>
                Column(
                    children: [
                      customTextFeild(hint: emailHint, title: email, prefixIcon: emailIcon, controller: authController.forgotPassEmailController),
                      10.heightBox,
                      authController.isloading.value ?  loadingIndicator() : 
                      myButton(
                        color: primary,
                        onPress: () {
                          authController.isloading(true);
                          vaildation();
                        },
                        textColor: whiteColor,
                        title: findaccountbutton,
                        buttonSize: 20.0,
                      ).box.width(context.screenWidth).make(),
                    ],
                  ),
                // ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}