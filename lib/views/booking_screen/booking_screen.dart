import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/lists.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/views/booking_screen/booking_details.dart';
import 'package:explorergocustomer/views/categories_screen/category_details.dart';
import 'package:explorergocustomer/widgets_common/custom_event.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';


class BookingScreen extends StatefulWidget {

  const BookingScreen({super.key, Key? required});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  void initState(){
    super.initState();
    switchCategory("Upcoming");
  }

   switchCategory(title){
    productMethod = FireStoreServices.getBookings(title);
   }

    bool subcat = false;
    var controller = Get.put(ProductController());
    dynamic productMethod;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "My Bookings".text.fontFamily(bold).color(highEmphasis).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                   children: List.generate(
                    bookingStatus.length,
                    (index) => bookingStatus[index].text.fontFamily(semibold).color(darkFontGrey).size(16).makeCentered().box.color(lightGrey).padding(const EdgeInsets.all(8)).margin(const EdgeInsets.symmetric(horizontal: 16)).roundedSM.shadowSm.make().onTap(() {
                      subcat = true;
                      switchCategory(bookingStatus[index]);
                      setState(() {});
                  })),
                ),
              ),
              20.heightBox,
              StreamBuilder(
                stream: productMethod,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: loadingIndicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty){
                    return Column(
                      children: [
                        50.heightBox,
                        Image.asset(icJourney, color: darkFontGrey, height: 120,),
                        "You haven't started any trips yet - let's change that".text.size(25).semiBold.center.color(darkFontGrey).make(),
                        10.heightBox,
                        myButton(
                          buttonSize: 20.0,
                          color: primary,
                          textColor: whiteColor,
                          title: "Upcoming Events",
                          onPress: (){
                            Get.to(()=> const CategoryDetails(title: "All"));
                          }
                        ).box.width(context.screenWidth).make(),
                        10.heightBox,
                        "OR".text.color(darkFontGreyHalfOpacity).semiBold.make(),
                        10.heightBox,
                        customTour()
                      ],
                    );
                  } else {
                    var data = snapshot.data!.docs;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index){
                        return ListTile(
                          leading: data[index]['img_url'] == '' ? Image.asset(icRiver, width: 80, height: 100, fit: BoxFit.cover,).box.clip(Clip.antiAlias).roundedSM.make() : Image.network(data[index]['img_url'], width: 80, height: 100, fit: BoxFit.cover,).box.clip(Clip.antiAlias).roundedSM.make(),
                          title: '${data[index]['trip_name']}'.text.fontFamily(bold).size(16).color(highEmphasis).make(),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'Sailing: ${data[index]['e_date']}'.text.fontFamily(regular).size(14).color(fontGrey).make(),
                              '${data[index]['status']}'.text.fontFamily(regular).size(14).color(data[index]['status'] == 'Pending' ? Colors.blue : data[index]['status'] == 'Cancelled' ?Colors.red : Colors.green).make()
                            ],
                          ),
                          trailing: Image.asset(icRight, height: 20, color: lightGreyHalfOpacity,),
                        ).box.roundedSM.white.padding(const EdgeInsets.all(8)).margin(const EdgeInsets.only(bottom: 10)).shadowSm.make().onTap(() {Get.to(()=> BookingDetails(data: data[index], title: data[index]['trip_name'],));});
                      }
                    );
                  }
                },
              ),
            ],
          ),
        )
    );
  }
}
