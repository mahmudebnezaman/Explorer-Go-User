import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/widgets_common/custom_textfeild.dart';
import 'package:explorergocustomer/widgets_common/details_textfield.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';

class EditBookingDetail extends StatefulWidget {

  final dynamic data;
  const EditBookingDetail({super.key, this.data});

  @override
  State<EditBookingDetail> createState() => _EditBookingDetailState();
}

class _EditBookingDetailState extends State<EditBookingDetail> {

  final controller = Get.find<ProductController>();
    
  @override
  void initState() {
    super.initState();
    controller.bookingTitleController.text = widget.data['trip_name'].toString();
    controller.bookingSailingController.text = widget.data['e_date'].toString();
    controller.bookingTravNumController.text = widget.data['traveler_count'].toString();
    controller.bookingPriceController.text = widget.data['total_price'].toString();
    controller.bookingLocationController.text = widget.data['location'].toString();
    controller.bookingPickupNoteController.text = widget.data['Pickup Note'].toString();
    controller.bookingItineraryController.text = widget.data['Itinerary'].toString();
    controller.bookingTravNameController.text = widget.data['traveler_name'].toString();
    controller.bookingTravEmailController.text = widget.data['traveler_email'].toString();
    controller.bookingTravContactController.text = widget.data['traveler_mobile'].toString();
  }

  @override
  Widget build(BuildContext context) {
    
    return Obx(
      ()=> Scaffold(
          appBar: AppBar(
            title: "Update Booking Details".text.semiBold.make(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTextFeild(title: "Event title", hint: "Enter a short title", controller: controller.bookingTitleController),
                  customTextFeild(title: "Name", hint: "Enter Travelers Name", prefixIcon: const Icon(Icons.verified_user_rounded), controller: controller.bookingTravNameController),
                  5.heightBox,
                  customTextFeild(title: email, hint: "Enter Travelers Email", prefixIcon: const Icon(Icons.email_outlined), controller: controller.bookingTravEmailController),
                  5.heightBox,
                  customTextFeild(title: "Mobile", hint: "Enter travelers mobile number.", prefixIcon: const Icon(Icons.mobile_friendly_outlined),controller: controller.bookingTravContactController, keytype: TextInputType.number, maxLength: 11),
                  customTextFeild(title: "Number of Travelers", hint: "ex: 0000", controller: controller.bookingTravNumController),
                  customTextFeild(title: "Sailing", hint: "ex: Everyday or 3rd March", controller: controller.bookingSailingController),
                  customTextFeild(title: "Price", hint: "ex: 5000", controller: controller.bookingPriceController),
                  customTextFeild(title: "Location", hint: "ex: Dhaka, Bangladesh", controller: controller.bookingLocationController),
                  detailsTextField(title: "Pick Up Note", hint: 'Details', controller: controller.bookingPickupNoteController),
                  detailsTextField(title: "Itinerary", hint: 'Details', controller: controller.bookingItineraryController),
                  5.heightBox,
                  controller.isloading.value ? Center(child: loadingIndicator()) : myButton(
                    title: "Update Booking Details",
                    buttonSize: 20.0,
                    color: primary,
                    textColor: whiteColor,
                    onPress: () async {
                      controller.isloading(true);
                      controller.updateOrderController(widget.data.id);
                      Get.back();
                    }
                  ).box.width(context.screenWidth).make(),
                  5.heightBox,
                ],
              ),
            ),
        )
      ),
    );
  }
}
        