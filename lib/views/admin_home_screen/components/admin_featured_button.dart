import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/views/admin_blogs_screen/admin_blogs_screen.dart';
import 'package:explorergocustomer/views/admin_booking_screen/admin_booking_screen.dart';
import 'package:explorergocustomer/views/admin_events_screen/admin_events_screen.dart';
import 'package:explorergocustomer/views/admin_home_screen/all_users.dart';
import 'package:explorergocustomer/widgets_common/dashboard_button.dart';

Widget featuredButton({String? title, icon}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset(icon,width: 110,height: 80,fit: BoxFit.cover,).box.clip(Clip.antiAlias).roundedSM.outerShadowLg.make(),
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.roundedSM.padding(const EdgeInsets.all(4)).width(110).height(110).margin(const EdgeInsets.symmetric(horizontal: 4)).make();
}

Widget dashboard(){

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StreamBuilder(
            stream: FireStoreServices.getEvents("All"),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty){
                return dashboardButton(context, title: "Events", count: "0", icon: icTodaysDeal);
              } else {
                var data = snapshot.data!.docs;
                return dashboardButton(context, title: "Events", count: '${data.length}', icon: icTodaysDeal);
              }
            }
          ).onTap(() {
            Get.to(()=> const AdminEventScreen());
          }),
          StreamBuilder(
            stream: FireStoreServices.adminGetBookings("Upcoming"),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty){
                return dashboardButton(context, title: bookings, count: "0", icon: icSuitcase);
              } else {
                var data = snapshot.data!.docs;
                return dashboardButton(context, title: bookings, count: '${data.length}', icon: icSuitcase);
              }
            }
          ).onTap(() {
            Get.to(()=> const AdminBookingScreen());
          })
        ],
      ),
      10.heightBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StreamBuilder(
            stream: FireStoreServices.getAllUser(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty){
                return dashboardButton(context, title: 'Users', count: "0", icon: icUser);
              } else {
                var data = snapshot.data!.docs;
                return dashboardButton(context, title: 'Users', count: '${data.length}', icon: icUser);
              }
            }
          ).onTap(() {
            Get.to(()=> const AllUsersScreen());
          }),
          StreamBuilder(
            stream: FireStoreServices.getBlogs("All"),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty){
                return dashboardButton(context, title: blogs, count: "0", icon: icBlog);
              } else {
                var data = snapshot.data!.docs;
                return dashboardButton(context, title: blogs, count: '${data.length}', icon: icBlog);
              }
            }
          ).onTap(() {
            Get.to(()=> const AdminBlogScreen());
          })
        ],
      ),
    ],
  );
}