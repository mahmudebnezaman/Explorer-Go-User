import 'package:explorergocustomer/consts/consts.dart';

Widget detailsTextField({
  required String? title,
  required String? hint,
  Widget? prefixIcon,
  controller,
}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      "$title:".text
          .color(highEmphasis)
          .semiBold
          .size(16)
          .make(),
      5.heightBox,
      TextFormField(
        maxLines: null,
        // expands: expan == true ? true : false,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius:BorderRadius.circular(12),
          ),
          prefixIcon: prefixIcon,
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
            fontSize: 14,
          ),
          hintText: hint,
          isDense: true,
          fillColor: whiteColor,
          filled: true,
        ),
      ),
      5.heightBox,
    ],
  );
}