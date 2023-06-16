import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/views/auth_screen/email_varification_screen.dart';
import 'package:explorergocustomer/widgets_common/custom_textfeild.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';

class ForgotPasswordEmailScreen extends StatelessWidget {
  const ForgotPasswordEmailScreen({super.key});

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
                    // "skip".text.color(textfieldGrey).size(16).fontFamily(semibold).make().onTap(() {Get.to(()=> const Home());}),
                  ],
                ),
        
        
                5.heightBox,
                findyouraccout.text.bold.size(25).color(highEmphasis).make(),
                
                25.heightBox,
                // Obx(()=>
                Column(
                    children: [
                      customTextFeild(hint: emailHint, title: email, prefixIcon: emailIcon),
                      10.heightBox,
                      // controller.isloading.value ?  loadingIndicator() : 
                      myButton(
                        color: primary,
                        onPress: () {
                          // vaildation();
                          Get.to(()=> const EmailVarificationScreen());
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