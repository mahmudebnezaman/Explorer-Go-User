import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/widgets_common/custom_tour_book.dart';

Widget customTour(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Image.asset(icCustomTour, height: 50,),
      "Customize your tour plan...".text.size(18).semiBold.color(highEmphasis).make(),
      Image.asset(icRight,color: textfieldGrey,height: 12)
    ],
  ).box.white.padding(const EdgeInsets.all(8)).roundedSM.outerShadow.make().onTap(() {Get.to(()=> const CustomTourBook());});
}