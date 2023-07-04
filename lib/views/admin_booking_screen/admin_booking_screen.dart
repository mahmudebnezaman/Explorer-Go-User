import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/lists.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/views/admin_booking_screen/bookings_listviewbuilder.dart';

import '../../widgets_common/appbar.dart';

class AdminBookingScreen extends StatefulWidget {
  const AdminBookingScreen({Key? key}) : super(key: key);

  @override
  State<AdminBookingScreen> createState() => _AdminBookingScreenState();
}

class _AdminBookingScreenState extends State<AdminBookingScreen> {
  @override
  void initState() {
    super.initState();
    switchCategory("Upcoming");
  }

  void switchCategory(title) {
    productMethod = FireStoreServices.adminGetBookings(title);
  }

  bool subcat = false;
  var controller = Get.put(ProductController());
  dynamic productMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: appBarWidget(title: "Bookings"),
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
                  (index) => bookingStatus[index]
                      .text
                      .fontFamily(semibold)
                      .color(darkFontGrey)
                      .size(16)
                      .makeCentered()
                      .box
                      .color(lightGrey)
                      .padding(const EdgeInsets.all(8))
                      .margin(const EdgeInsets.symmetric(horizontal: 16))
                      .roundedSM
                      .shadowSm
                      .make()
                      .onTap(() {
                    subcat = true;
                    switchCategory(bookingStatus[index]);
                    setState(() {});
                  }),
                ),
              ),
            ),
            20.heightBox,
            StreamBuilder(
              stream: productMethod,
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: loadingIndicator(),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Column(
                    children: [
                      50.heightBox,
                      Image.asset(
                        icJourney,
                        color: darkFontGrey,
                        height: 120,
                      ),
                      "No bookings made yet!"
                          .text
                          .size(25)
                          .semiBold
                          .center
                          .color(darkFontGrey)
                          .make(),
                    ],
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return Expanded(
                    child: bookingListViewBuilder(data: data),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
