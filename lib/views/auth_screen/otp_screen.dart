// import 'package:explorergocustomer/consts/consts.dart';
// import 'package:explorergocustomer/widgets_common/my_button.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/style.dart';

// class OTPScreen extends StatelessWidget {
//   const OTPScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         elevation: 0,
//       ),
//       body: Stack(
//           children: [
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Image.asset(imgForgotPassBg)
//             ),
//             Padding(
//             padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // 10.heightBox,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Image.asset(icAppLogoFull, width: 250,),
//                     // "skip".text.color(textfieldGrey).size(16).fontFamily(semibold).make().onTap(() {Get.to(()=> const Home());}),
//                   ],
//                 ),
        
        
//                 5.heightBox,
//                 confirmyouraccount.text.bold.size(25).color(highEmphasis).make(),
//                 5.heightBox,
//                 "We sent a code via E-mail. Enter that code to confirm your account.".text.color(fontGrey).semiBold.make(),
                
//                 25.heightBox,
//                 // Obx(()=>
//                 Column(
//                     children: [
//                       // customTextFeild(hint: emailHint, title: email, prefixIcon: emailIcon),
//                       OTPTextField(
//             // controller: otpController,
//                         length: 6,
//                         width: context.screenWidth,
//                         textFieldAlignment: MainAxisAlignment.spaceEvenly,
//                         fieldWidth: 50,
//                         fieldStyle: FieldStyle.box,
//                         outlineBorderRadius: 12,
//                         style: const TextStyle(fontSize: 17),
//                         onChanged: (pin) {
//                           print("Changed: " + pin);
//                         },
//                         onCompleted: (pin) {
//                           print("Completed: " + pin); 
//                         }
//                       ),
//                       10.heightBox,
//                       // controller.isloading.value ?  loadingIndicator() : 
//                       myButton(
//                         color: primary,
//                         onPress: () {
//                           // vaildation();
//                         },
//                         textColor: whiteColor,
//                         title: findaccountbutton,
//                         buttonSize: 20.0,
//                       ).box.width(context.screenWidth).make(),
//                     ],
//                   ),
//                 // ),
//               ],
//             ),
//           ),
//         ]
//       ),
//     );
//   }
// }