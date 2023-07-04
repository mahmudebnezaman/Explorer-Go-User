import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
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
  return Row(
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
      ),
      StreamBuilder(
        stream: FireStoreServices.getBookings("Upcoming"),
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
      ),
    ],
  );
}