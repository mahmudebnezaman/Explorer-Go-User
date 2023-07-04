import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/lists.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/views/admin_events_screen/edit_event.dart';
import 'package:explorergocustomer/views/admin_home_screen/admin_home.dart';

class AdminEventDetails extends StatefulWidget {
  
  final String? title;
  final dynamic data;
  const AdminEventDetails({super.key, this.title, this.data});

  @override
  State<AdminEventDetails> createState() => _AdminEventDetailsState();
}
class _AdminEventDetailsState extends State<AdminEventDetails> {
  
  @override
  Widget build(BuildContext context) {

     var controller = Get.put(ProductController());
    

    return Scaffold(
      appBar: AppBar(
        title: widget.title!.text.size(18).semiBold.color(highEmphasis).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 350,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                    aspectRatio: 16/9,
                    autoPlay: true,
                    height: 216,
                    enlargeCenterPage: true,
                    itemCount: widget.data['e_images'].length,
                    itemBuilder: (context,index){
                      return Image.network(widget.data['e_images'][index], height: 216, width: 384,
                    fit: BoxFit.cover,
                    ).box.rounded.outerShadow.clip(Clip.antiAlias).margin(const EdgeInsets.all(2)).make();
                  }),
                    
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        '${widget.data['duration']}'.text.fontFamily(regular).size(20).color(fontGrey).make(),
                        'Sailing: ${widget.data['e_date']}'.text.fontFamily(regular).size(20).color(fontGrey).make(),
                      ],
                    ),
                    Row(
                      children: [
                        "BDT".text.color(primary).fontFamily(regular).size(20).make(),
                        2.widthBox,
                        '${widget.data['e_price']}'.numCurrency.text.color(primary).fontFamily(regular).size(20).make(),
                        ' per person'.text.color(primary).fontFamily(regular).size(10).make(),
                        ],
                    ),
                    
                    2.heightBox,
                    Row(
                      children: [
                        const Icon(Icons.location_pin, size: 20, color: primary,),
                        '${widget.data['e_location']}'.text.color(fontGrey).fontFamily(regular).size(20).make(),
                        ],
                      ),
                    if (widget.data['is_featured'] == true ) 'Featured'.text.semiBold.color(Colors.green).make(),
                  ],
                ).box.white.roundedSM.padding(const EdgeInsets.all(12)).margin(const EdgeInsets.symmetric(horizontal: 4)).outerShadow.make(),
              ),
              10.heightBox,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: eventTitleImage.length,
                itemBuilder: (BuildContext context, int index){
                  var txt = eventTitleList[index];
                  return ListTile(
                    leading: Image.asset(eventTitleImage[index], color: highEmphasis, height: 24,),
                    title: txt.text.fontFamily(semibold).size(18).color(highEmphasis).make(),
                    trailing: const Icon(Icons.arrow_drop_down),
                  ).box.roundedSM.margin(const EdgeInsets.symmetric(vertical: 4)).white.shadowSm.make().onTap(() {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: SizedBox(
                          height: context.height,
                          width: context.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(txt,
                                  style: const TextStyle(color: highEmphasis, fontSize: 20, fontFamily: bold),),
                                  IconButton(onPressed: ()=> Get.back(), icon: const Icon(Icons.close_rounded))
                                ],
                              ),
                              5.heightBox,
                               Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: '${widget.data[txt]}'.text.make()
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                }
              ),
              60.heightBox,
            ],
          ),
        ),
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: [

          //edit button
          FloatingActionButton(
            heroTag: null,  
            onPressed: (){
              controller.titleController.text = widget.data['e_title'].toString();
              controller.durationController.text = widget.data['duration'].toString();
              controller.sailingController.text = widget.data['e_date'].toString();
              controller.priceController.text = widget.data['e_price'].toString();
              controller.locationController.text = widget.data['e_location'].toString();
              controller.overviewController.text = widget.data['Overview'].toString();
              controller.pickupNoteController.text = widget.data['Pickup Note'].toString();
              controller.timingController.text = widget.data['Timing'].toString();
              controller.itineraryController.text = widget.data['Itinerary'].toString();
              controller.inclusionController.text = widget.data['Inclusion & Exclusion'].toString();
              controller.descripctionController.text = widget.data['Description'].toString();
              controller.aditioninfoController.text = widget.data['Additional Information'].toString();
              controller.travelTipsController.text = widget.data['Travel Tips'].toString();
              controller.optionsController.text = widget.data['Options'].toString();
              controller.policyController.text = widget.data['Policy'].toString();
              Get.off(()=> EditEventScreen(data: widget.data,));
            },
            backgroundColor: primary,
            child: const Icon(Icons.edit),
          ),
          10.heightBox,

          //add featured button
          FloatingActionButton(
          heroTag: null,
          onPressed: (){
            if (widget.data['is_featured'] == true) {
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
                          controller.removeFeatured(widget.data.id);
                          VxToast.show(context, msg: "Event removed from featured");
                          // Get.back();
                          Get.off(()=>const AdminHome());
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
                          controller.addFeatured(widget.data.id);
                          VxToast.show(context, msg: "Event added to featured");
                          Get.off(()=>const AdminHome());
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          backgroundColor: primary,
          child: Image.asset(icFeature, color: whiteColor, height: 30),
          ),
          10.heightBox,

          //delete button
          FloatingActionButton(
          heroTag: null,
          onPressed: (){
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
                        controller.removeEvent(widget.data.id);
                        VxToast.show(context, msg: 'Event Deleted Successfully');
                        Get.off(()=> const AdminHome());
                      },
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: primary,
          child: const Icon(Icons.delete),
          ),
        ],
      )
    );
  }
}