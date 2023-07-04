import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/lists.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/views/admin_events_screen/add_event.dart';
import 'package:explorergocustomer/widgets_common/appbar.dart';
import 'package:explorergocustomer/widgets_common/event_listviewbuilder.dart';


class AdminEventScreen extends StatefulWidget {

  final String? title;
  
  const AdminEventScreen({super.key, Key? required, this.title });

  @override
  State<AdminEventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<AdminEventScreen> {

  bool isMenuOpen = false;

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
      appBar: appBarWidget(
        title: "Events"
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
                    ],
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return eventListViewBuilder(data: data);
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Get.to(()=> const AddEvent());
      },
        backgroundColor: primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}

