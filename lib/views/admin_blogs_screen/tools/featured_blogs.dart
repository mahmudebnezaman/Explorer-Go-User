import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/widgets_common/blog_listviewbuilder.dart';

Widget getFeaturedBlogs(){
  return StreamBuilder(
    stream: FireStoreServices.getFeaturedBlogs(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      if(!snapshot.hasData){
        return Center(
          child: loadingIndicator(),
        );
      } else if (snapshot.data!.docs.isEmpty){
        return Center(
          child: Column(
            children: [
              Image.asset(icDepressed, color: darkFontGrey, height: 120,),
              "Seems Like You Did not Adedd any featured Event".text.color(darkFontGrey).make(),
            ],
          ),
        );
      } else {
        var data = snapshot.data!.docs;
        return blogListViewBuilder(data: data);
      }
    }
  );
}