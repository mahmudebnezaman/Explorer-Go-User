import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/lists.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/views/admin_events_screen/tools/drop_down_category.dart';
import 'package:explorergocustomer/views/admin_events_screen/tools/event_images.dart';
import 'package:explorergocustomer/widgets_common/custom_textfeild.dart';
import 'package:explorergocustomer/widgets_common/details_textfield.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';

class AddEvent extends StatelessWidget {
  const AddEvent({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProductController>();

    var detailTextFeildControllers = [controller.overviewController,controller.pickupNoteController,controller.timingController,controller.itineraryController,controller.inclusionController,controller.descripctionController,controller.aditioninfoController,controller.travelTipsController,controller.optionsController,controller.policyController];

    return Obx(
      ()=> Scaffold(
        appBar: AppBar(
          title: "Add a new event".text.semiBold.make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextFeild(title: "Event title", hint: "Enter a short title", controller: controller.titleController),
                5.heightBox,
                "Add Images:".text.color(highEmphasis).semiBold.size(16).make(),
                "Note: First image will be cover image*".text.color(fontGrey).semiBold.size(12).make(),
                10.heightBox,
                eventImages(),
                5.heightBox,
               customTextFeild(title: "Duration", hint: "ex: 3 days 2 nights", controller: controller.durationController),
               customTextFeild(title: "Sailing", hint: "ex: Everyday or 3rd March", controller: controller.sailingController),
               customTextFeild(title: "Price", hint: "ex: 5000", controller: controller.priceController),
               customTextFeild(title: "Location", hint: "ex: Dhaka, Bangladesh", controller: controller.locationController),
                5.heightBox,
                "Category:".text.color(highEmphasis).semiBold.size(16).make(),
                const DropdownButtonCategory(),
                for(int i=0; i<eventTitleList.length; i++)
                  detailsTextField(title: eventTitleList[i], hint: 'Details', controller: detailTextFeildControllers[i]),
                5.heightBox,
                controller.isloading.value ? Center(child: loadingIndicator()) : myButton(
                  title: "Confirm post",
                  buttonSize: 20.0,
                  color: primary,
                  textColor: whiteColor,
                  onPress: () async {
                    controller.isloading(true);
                    await controller.newUploadImages();
                    // ignore: use_build_context_synchronously
                    await controller.uploadEvent(context);
                    
                    Get.back();
                  }
                ).box.width(context.screenWidth).make(),
                5.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}