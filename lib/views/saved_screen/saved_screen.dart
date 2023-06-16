import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/widgets_common/event_gridview_builder.dart';


class SavedScreen extends StatelessWidget {

  final String? title;
  
  const SavedScreen({super.key, Key? required, this.title });

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductController());
    //  var catTitle = null;

    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Saved".text.fontFamily(bold).color(highEmphasis).make(),
        ),
        body: StreamBuilder(
          stream: FireStoreServices.getSaved(auth.currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty){
              return Center(
                child: "You have nothing on your saved list".text.color(darkFontGrey).make(),
              );
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.heightBox,
                    //item container
                    Expanded(
                      child: eventGridviewBuilder(data, controller)
                    )
                  ]),
                );
              }
          },
        )
    );
  }
}
