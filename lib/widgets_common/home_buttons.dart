import 'package:explorergocustomer/consts/consts.dart';

Widget homeButton({width, height, icon, String? title, onPress}){
  
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(icon,width: 26, color: whiteColor,),
      10.widthBox,
      title!.text.size(18).fontFamily(semibold).color(whiteColor).make(),
    ],
  ).box.rounded.color(primary).shadowSm.size(width, height).make();
}