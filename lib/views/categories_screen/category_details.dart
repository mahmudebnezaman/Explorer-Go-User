import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/lists.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/widgets_common/custom_event.dart';
import 'package:explorergocustomer/widgets_common/event_gridview_builder.dart';


class CategoryDetails extends StatefulWidget {

  final String? title;
  
  const CategoryDetails({super.key, Key? required, this.title });

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState(){
    super.initState();
    switchCategory(widget.title);
  }

   switchCategory(title){
    productMethod = FireStoreServices.getEvents(title);
   }

    bool subcat = false;
    var controller = Get.put(ProductController());
    dynamic productMethod;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Categories".text.fontFamily(bold).color(highEmphasis).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                   children: List.generate(
                    categoriesTitles.length,
                    (index) => categoriesTitles[index].text.fontFamily(semibold).color(darkFontGrey).size(16).makeCentered().box.color(lightGrey).padding(const EdgeInsets.all(8)).margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.shadowSm.make().onTap(() {
                      subcat = true;
                      switchCategory(categoriesTitles[index]);
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
                        Image.asset(icDepressed, color: darkFontGrey, height: 120,),
                        "Seems Like No Upcoming Events".text.color(darkFontGrey).make(),
                        10.heightBox,
                        customTour()
                      ],
                    );
                  } else {
                    var data = snapshot.data!.docs;
                    return eventGridviewBuilder(data, controller);
                  }
                },
              ),
            ],
          ),
        )
    );
  }
}
