// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/views/admin_booking_screen/edit_booking.dart';
import 'package:explorergocustomer/widgets_common/appbar.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';

class AdminBookingDetails extends StatefulWidget {
  
  final String dataid;
  const AdminBookingDetails({super.key, required this.dataid});

  @override
  State<AdminBookingDetails> createState() => _AdminBookingDetailsState();
}


class _AdminBookingDetailsState extends State<AdminBookingDetails> {

  // dynamic bookingDetailStream = FireStoreServices.getBookingDetails(widget.dataid);
  var controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    var bookingTitle = ['Pickup Note', 'Itinerary'];
    var bookingTitleImage = [icRout, icItinerary];
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: appBarWidget(title: 'Bookinng Details'),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FireStoreServices.getBookingDetails(widget.dataid),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: loadingIndicator());
              } else {
                var data = snapshot.data!;
                return Column(
                  children: [
                    Text(
                      data['trip_name'],
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: highEmphasis),
                    ),
                    5.heightBox,
                    SizedBox(
                      width: double.infinity,
                      height: 380,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          data['img_url'] =='' ? Image.asset(icRiver, height: 200, width: 384,
                          fit: BoxFit.cover,
                          ).box.rounded.outerShadow.clip(Clip.antiAlias).margin(const EdgeInsets.all(2)).make():
                          Image.network(data['img_url'], height: 200, width: 384,
                          fit: BoxFit.cover,
                          ).box.rounded.outerShadow.clip(Clip.antiAlias).margin(const EdgeInsets.all(2)).make(),
                          
                          const Spacer(),
                          Row(
                            children: [
                              'Status: '.text.fontFamily(regular).size(18).color(fontGrey).make(),
                              '${data['status']}'.text.fontFamily(regular).size(18).color(data['status'] == 'Pending' ? Colors.blue : data['status'] == 'Cancelled' ?Colors.red : Colors.green).make(),
                            ],
                          ),
                          'Sailing: ${data['e_date']}'.text.fontFamily(regular).size(18).color(fontGrey).make(),
                          'Number of Travelers: ${data['traveler_count']}'.text.fontFamily(regular).size(18).color(fontGrey).make(),
                          Row(
                            children: [
                              "Total paid: BDT".text.color(primary).fontFamily(regular).size(18).make(),
                              2.widthBox,
                              '${data['total_price']}'.numCurrency.text.color(primary).fontFamily(regular).size(20).make(),
                              ],
                          ),
                          
                          2.heightBox,
                          Row(
                            children: [
                              const Icon(Icons.location_pin, size: 20, color: primary,),
                              Expanded(child: '${data['location']}'.text.color(fontGrey).fontFamily(regular).size(18).make()),
                              ],
                            ),
                          Expanded(child: 'Order ID: ${data.id}'.text.fontFamily(regular).size(18).color(fontGrey).make()),
                        ],
                      ).box.white.roundedSM.padding(const EdgeInsets.all(12)).margin(const EdgeInsets.symmetric(horizontal: 4)).outerShadow.make(),
                    ),
                    10.heightBox,
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'Travelers Info.'.text.size(20).bold.color(highEmphasis).make(),
                            const Divider(color: highEmphasis,thickness: 0.5),
                            Row(
                              children: [
                                'Name: '.text.size(18).semiBold.color(highEmphasis).make(),
                                '${data['traveler_name']}'.text.size(18).color(fontGrey).make(),
                              ],
                            ),
                            Row(
                              children: [
                                'Email: '.text.size(18).semiBold.color(highEmphasis).make(),
                                '${data['traveler_email']}'.text.size(18).color(fontGrey).make(),
                              ],
                            ),
                            Row(
                              children: [
                                'Contact Number: '.text.size(18).semiBold.color(highEmphasis).make(),
                                '${data['traveler_mobile']}'.text.size(18).color(fontGrey).make(),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    10.heightBox,
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: bookingTitle.length,
                      itemBuilder: (BuildContext context, int index){
                        var txt = bookingTitle[index];
                        return ListTile(
                          leading: Image.asset(bookingTitleImage[index], color: highEmphasis, height: 24,),
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
                                        child: '${data[txt]}'.text.make()
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
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(icPast, height:25,),5.widthBox,
                            "Past".text.size(18).semiBold.color(highEmphasis).make()
                          ],
                        ).box.white.width(context.screenWidth*.30).padding(const EdgeInsets.symmetric(vertical: 12)).shadowSm.roundedSM.make().onTap(() {
                              setState(() {
                                controller.pastooking(widget.dataid);
                              });
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(icConfirm, height:25,),5.widthBox,
                            "Confirm".text.size(18).semiBold.color(highEmphasis).make()
                          ],
                        ).box.white.width(context.screenWidth*.30).padding(const EdgeInsets.symmetric(vertical: 12)).shadowSm.roundedSM.make().onTap(() {
                              setState(() {
                                controller.confirmBooking(widget.dataid);
                              });
                            }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(icCancel, height:25,),5.widthBox,
                            "Cancel".text.size(18).semiBold.color(highEmphasis).make()
                          ],
                        ).box.white.width(context.screenWidth*.30).padding(const EdgeInsets.symmetric(vertical: 12)).shadowSm.roundedSM.make().onTap(() {
                              setState(() {
                                controller.cancelBooking(widget.dataid);
                              });
                            })
                      ],
                    ),
                    10.heightBox,
                    myButton(buttonSize: 20.0,
                    color: primary,
                    textColor: whiteColor,
                    title: "Edit Booking Details",
                    onPress: (){
                      Get.to(()=> EditBookingDetail(data: data,));
                    }),
                    10.heightBox
                  ],
                );
              }
            }
          ),
        ),
      ),
    );
  }
}