import 'package:explorergocustomer/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

AppBar appBarWidget (
  {String? title}
){
  return AppBar(
    automaticallyImplyLeading: false,
    title: title!.text.bold.size(20).make(),
    actions: [
      Center(child: intl.DateFormat('EEE, MMM d, ''yy').format(DateTime.now()).text.color(darkFontGrey).make()
      ),
      12.widthBox
    ],
  );
}