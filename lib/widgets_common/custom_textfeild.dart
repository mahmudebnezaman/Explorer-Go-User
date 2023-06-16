import 'package:explorergocustomer/consts/consts.dart';

Widget customTextFeild({
  required String? title,
  required String? hint,
  Widget? prefixIcon,
  controller,
  keytype,
  readOnly = false,
  onTap,
  maxLength
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text
          .color(highEmphasis)
          .fontFamily(semibold)
          .size(20)
          .make(),
      5.heightBox,
      TextFormField(
        onTap: onTap,
        maxLength: maxLength,
        readOnly: readOnly,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
            fontSize: 20,
          ),
          hintText: hint,
          isDense: true,
          fillColor: whiteColor,
          filled: true,
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: highEmphasis)),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: primary),
          ),
        ),
        keyboardType: keytype,
      ),
      5.heightBox,
    ],
  );
}
