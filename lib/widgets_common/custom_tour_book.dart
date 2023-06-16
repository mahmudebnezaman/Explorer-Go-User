import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/widgets_common/custom_textfeild.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';

import 'package:intl/intl.dart';

class CustomTourBook extends StatefulWidget {
  const CustomTourBook({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CustomTourBookState createState() => _CustomTourBookState();
}

String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  var controller = Get.put(ProductController());

  void vaildation(context) async {
    if (controller.bookingEmailController.text.isEmpty && controller.bookingNameController.text.isEmpty && controller.bookingNumberController.text.isEmpty) {
      VxToast.show(context, msg: "Please fill up all the feilds");
    } else {
      if (controller.bookingEmailController.text.isEmpty) {
      VxToast.show(context, msg: "Email feild is Empty");
    } else if (controller.bookingNameController.text.isEmpty) {
      VxToast.show(context, msg: "Name feild is Empty");
    } else if (controller.bookingNumberController.text.isEmpty) {
      VxToast.show(context, msg: "Number feild is Empty");
    } else if (!regExp.hasMatch(controller.bookingEmailController.text)) {
      VxToast.show(context, msg: "Please Try Vaild Email ");
    } else if (controller.bookingNumberController.text.length < 11) {
      VxToast.show(context, msg: "Please Try Vaild Number");
    } else if (controller.quantity < 1) {
      VxToast.show(context, msg: "Minimum number of traveler is 1");
    }else {
      // signinButtonPress();
    }
    }
  }


class _CustomTourBookState extends State<CustomTourBook> {
  var selectedDate = DateTime.now();
  final dateController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return Scaffold(
      appBar: AppBar(
        title: "Customize your tour plan...".text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextFeild(
              title: "Location",
              hint: "Enter your destination",
              prefixIcon: const Icon(Icons.location_city_outlined),
            ),
            5.heightBox,
            customTextFeild(
              title: name,
              hint: nameHint,
              prefixIcon: const Icon(Icons.verified_user_rounded),
            ),
            5.heightBox,
            customTextFeild(
              title: email,
              hint: emailHint,
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            5.heightBox,
            customTextFeild(
              title: "Mobile",
              hint: "Enter your mobile number.",
              prefixIcon: const Icon(Icons.mobile_friendly_outlined),
              keytype: TextInputType.number,
            ),
            5.heightBox,
            customTextFeild(
              title: "Date",
              hint: '',
              controller: dateController,
              readOnly: true,
              prefixIcon: const Icon(Icons.calendar_today),
              onTap: () {
                _selectDate(context);
              },
            ),
            5.heightBox,
            Obx(() => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        "Number of travellers: ".text.semiBold.size(18).make(),
                        5.widthBox,
                        IconButton(
                          onPressed: () {
                            controller.decressQuantity();
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        5.widthBox,
                        controller.quantity.value.text
                            .size(18)
                            .color(darkFontGrey)
                            .make(),
                        IconButton(
                          onPressed: () {
                            controller.increseQuantity(0);
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    10.heightBox,
                    myButton(
                      buttonSize: 20.0,
                      color: primary,
                      textColor: whiteColor,
                      title: "Confirm Booking",
                      onPress: () {
                        vaildation(context);
                      },
                    ),
                    10.heightBox,
                    // getPromotinalProducts(),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2024),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate); // Format the date
        dateController.text = formattedDate;
      });
    }
  }
}
