import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/widgets_common/event_listviewbuilder.dart';

Widget getPopularEvents(){

  return StreamBuilder(
    stream: FireStoreServices.getEvents("All"),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      if(!snapshot.hasData){
        return Center(
          child: loadingIndicator(),
        );
      } else if (snapshot.data!.docs.isEmpty){
        return Column(
          children: [
            Image.asset(icDepressed, color: darkFontGrey, height: 120,),
            "Seems Like There is no Popular Event".text.color(darkFontGrey).make(),
          ],
        );
      } else {
        var data = snapshot.data!.docs;
        data = data.sortedBy((a, b) => b['e_wishlist'].length.compareTo(a['e_wishlist'].length));
        return eventListViewBuilder(data: data);
      }
    }
  );
}