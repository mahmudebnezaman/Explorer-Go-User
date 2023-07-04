import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/widgets_common/event_listviewbuilder.dart';

Widget getFeaturedEvents(){
  return StreamBuilder(
    stream: FireStoreServices.getFeaturedProducts(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      if(!snapshot.hasData){
        return Center(
          child: loadingIndicator(),
        );
      } else if (snapshot.data!.docs.isEmpty){
        return Column(
          children: [
            Image.asset(icDepressed, color: darkFontGrey, height: 120,),
            "Seems Like You Did not Adedd any featured Event".text.color(darkFontGrey).make(),
          ],
        );
      } else {
        var data = snapshot.data!.docs;
        return eventListViewBuilder(data: data);
      }
    }
  );
}