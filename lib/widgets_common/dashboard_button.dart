import 'package:explorergocustomer/consts/consts.dart';

Widget dashboardButton(context, {String? title, String? count, icon}){
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title!.text.size(16).white.semiBold.make(),
            count!.text.size(16).white.make(),
          ],
        )),
      Image.asset(icon, width: 40, color: whiteColor,)
    ],
  ).box.color(primary).rounded.size(size.width*0.4,80).padding(const EdgeInsets.all(8)).make();
}