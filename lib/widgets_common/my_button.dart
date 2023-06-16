import 'package:explorergocustomer/consts/consts.dart';

Widget myButton({onPress, color, textColor, String? title , buttonSize}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress,
    child: title!.text.color(textColor).size(buttonSize).fontFamily(bold).make(),
  );
}