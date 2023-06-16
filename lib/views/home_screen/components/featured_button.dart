import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/views/categories_screen/category_details.dart';

Widget featuredButton({String? title, icon}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset(icon,width: 110,height: 80,fit: BoxFit.cover,).box.clip(Clip.antiAlias).roundedSM.outerShadowLg.make(),
      title!.text.fontFamily(semibold).semiBold.color(darkFontGrey).make(),
    ],
  ).box.roundedSM.padding(const EdgeInsets.all(4)).width(110).height(110).margin(const EdgeInsets.symmetric(horizontal: 4)).make().onTap(() {
    Get.to(()=> CategoryDetails(title: title));
  });
}