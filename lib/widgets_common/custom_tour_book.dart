// ignore_for_file: use_build_context_synchronously

import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/views/home_screen/home.dart';
import 'package:explorergocustomer/widgets_common/custom_textfeild.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';
import 'package:intl/intl.dart';
// ignore: constant_identifier_names
enum SdkType { LIVE }
class CustomTourBook extends StatefulWidget {
  
  // final String? title;
  // final dynamic data;
  const CustomTourBook({super.key});

  @override
  State<CustomTourBook> createState() => _CustomTourBookState();
}

  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  var controller = Get.put(ProductController());

class _CustomTourBookState extends State<CustomTourBook> {
  
    var selectedDate = DateTime.now();

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
      } else if (controller.bookingNumberController.text.length > 11) {
        VxToast.show(context, msg: "Please Try Vaild Number");
      } else if (controller.quantity < 1) {
        VxToast.show(context, msg: "Minimum number of traveler is 1");
      }else {
        controller.confirmOrderController(controller.bookinglocationController.text, controller.bookingdateController.text,'','Will be updated after tour confirmation.','Will be updated after tour confirmation.','Will be updated after tour confirmation.');
        Get.offAll(()=>const Home());
        VxToast.show(context, showTime: 5000, msg: "Booking Reserved!");
      }
    }
  }

  @override
  void initState() {
    controller.bookingdateController.text = DateFormat('yyyy-MM-dd').format(selectedDate).toString();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser!.displayName != null) {
      controller.bookingNameController.text = auth.currentUser!.displayName!;
    }
    controller.bookingEmailController.text = auth.currentUser!.email!;

    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: 'Create your custom tour'.text.fontFamily(bold).color(highEmphasis).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                customTextFeild(
                  title: "Location",
                  hint: "Enter your destination",
                  prefixIcon: const Icon(Icons.location_city_outlined),
                  controller: controller.bookinglocationController
                ),
                customTextFeild(title: name, hint: nameHint, prefixIcon: const Icon(Icons.verified_user_rounded), controller: controller.bookingNameController),
                5.heightBox,
                customTextFeild(title: email, hint: emailHint, prefixIcon: const Icon(Icons.email_outlined), controller: controller.bookingEmailController),
                5.heightBox,
                customTextFeild(title: "Mobile", hint: "Enter your mobile number.", prefixIcon: const Icon(Icons.mobile_friendly_outlined),controller: controller.bookingNumberController, keytype: TextInputType.number, maxLength: 11),
                5.heightBox,
                customTextFeild(
                  title: "Date",
                  hint: '',
                  controller: controller.bookingdateController,
                  readOnly: true,
                  prefixIcon: const Icon(Icons.calendar_today),
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                Obx(
                  () => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "Number of travellers: ".text.semiBold.size(18).make(),
                          5.widthBox,
                          IconButton(onPressed: (){
                            controller.decressQuantity();
                          },
                            icon: const Icon(Icons.remove)
                          ),
                          5.widthBox,
                          controller.quantity.value.text.size(18).color(darkFontGrey).make(),
                          IconButton(onPressed: (){
                            controller.increseQuantity(int.parse(20.toString()));
                          },
                            icon: const Icon(Icons.add)
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(color: fontGrey,),
                "Dear User, our representatives will reach out to you shortly with a tailored tour plan that perfectly aligns with your preferences. Please kindly complete the information form provided. Thank you!".text.center.color(fontGrey).make(),
                10.heightBox,
                controller.isloading.value == true ? const CircularProgressIndicator() : myButton(
                  buttonSize: 20.0,
                  color: primary,
                  textColor: whiteColor,
                  title: "Confirm Booking",
                  onPress: (){
                    controller.isloading(true);
                    vaildation(context);
                  }
                ),
              ],
            ),
          ),
        )
      )
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
        controller.bookingdateController.text = formattedDate;
      });
    }
  }
}