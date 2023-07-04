import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/lists.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/views/admin_events_screen/edit_event.dart';
import 'package:explorergocustomer/views/admin_events_screen/event_details.dart';
// import 'package:explorergocustomer/views/events_screen/edit_event.dart';
// import 'package:explorergocustomer/views/events_screen/event_details.dart';

Widget eventListViewBuilder({data}){
  
    var productController = Get.put(ProductController());
  return ListView.builder(
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    itemCount: data.length,
    itemBuilder: (context, index){
      return ListTile(
        leading: Image.network(data[index]['e_images'][0], width: 80, height: 100, fit: BoxFit.cover,).box.clip(Clip.antiAlias).roundedSM.make(),
        title: '${data[index]['e_title']}'.text.fontFamily(bold).size(16).color(highEmphasis).make(),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                "BDT".text.color(primary).fontFamily(regular).size(16).make(),
                2.widthBox,
                '${data[index]['e_price']}'.numCurrency.text.color(primary).fontFamily(regular).size(16).make(),
              ],
            ),
            'Sailing: ${data[index]['e_date']}'.text.fontFamily(regular).size(14).color(fontGrey).make(),
            if (data[index]['is_featured'] == true ) 'Featured'.text.semiBold.color(Colors.green).make(),
          ],
        ),
        trailing: PopupMenuButton<int>(
          itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Image.asset(
                      icFeature, height: 25,
                      color: data[index]['is_featured'] == true ? Colors.green : darkFontGrey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      data[index]['is_featured'] == true ? "Remove Featured" : popMenuTitles[0],
                      style: TextStyle(
                        color: data[index]['is_featured'] == true ? Colors.green : darkFontGrey,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    const Icon(
                      Icons.edit,
                      color: darkFontGrey,
                    ),
                    const SizedBox(width: 5),
                    Text(popMenuTitles[1]),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    const Icon(
                      Icons.delete,
                      color: darkFontGrey,
                    ),
                    const SizedBox(width: 5),
                    Text(popMenuTitles[2]),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 0:
                  if (data[index]['is_featured'] == true) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm Remove Featured"),
                          content: const Text("Are you sure you want to remove this event as featured?"),
                          actions: [
                            TextButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            TextButton(
                              child: const Text("Remove"),
                              onPressed: () {
                                productController.removeFeatured(data[index].id);
                                VxToast.show(context, msg: "Event removed from featured");
                                Get.back();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirm Add Featured"),
                          content: const Text("Are you sure you want to add this event as featured?"),
                          actions: [
                            TextButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            TextButton(
                              child: const Text("Add"),
                              onPressed: () {
                                productController.addFeatured(data[index].id);
                                VxToast.show(context, msg: "Event added to featured");
                                Get.back();
                              },
                            ),
                          ],
                        );
                      },
                    );
                    
                  }
                  break;
                case 1:
                  productController.titleController.text = data[index]['e_title'].toString();
                  productController.durationController.text = data[index]['duration'].toString();
                  productController.sailingController.text = data[index]['e_date'].toString();
                  productController.priceController.text = data[index]['e_price'].toString();
                  productController.locationController.text = data[index]['e_location'].toString();
                  productController.overviewController.text = data[index]['Overview'].toString();
                  productController.pickupNoteController.text = data[index]['Pickup Note'].toString();
                  productController.timingController.text = data[index]['Timing'].toString();
                  productController.itineraryController.text = data[index]['Itinerary'].toString();
                  productController.inclusionController.text = data[index]['Inclusion & Exclusion'].toString();
                  productController.descripctionController.text = data[index]['Description'].toString();
                  productController.aditioninfoController.text = data[index]['Additional Information'].toString();
                  productController.travelTipsController.text = data[index]['Travel Tips'].toString();
                  productController.optionsController.text = data[index]['Options'].toString();
                  productController.policyController.text = data[index]['Policy'].toString();
                  Get.to(()=> EditEventScreen(data: data[index]));
                  break;
                case 2:
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Confirm Delete"),
                        content: const Text("Are you sure you want to delete this event?"),
                        actions: [
                          TextButton(
                            child: const Text("Cancel"),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                          TextButton(
                            child: const Text("Delete"),
                            onPressed: () {
                              productController.removeEvent(data[index].id);
                              VxToast.show(context, msg: 'Event Deleted Successfully');
                              Get.back();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  break;
                default:
              }
            },
            icon: const Icon(Icons.more_vert_rounded),
          ),
        onTap: (){
          Get.to(()=> AdminEventDetails(title: '${data[index]['e_title']}', data: data[index],));
        },
      );
    }
  );
}