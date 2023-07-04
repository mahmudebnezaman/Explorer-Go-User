import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/home_controller.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';

Widget activePromotions(){

  var controller = Get.find<HomeController>();

  return StreamBuilder(
    stream: FireStoreServices.getPromotionalProducts(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      if(!snapshot.hasData){
        return Center(
          child: loadingIndicator(),
        );
      }else{
        var data = snapshot.data!.docs;
        var doc = data[0];
        return Column(
          children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                mainAxisExtent: 100
              ),
              itemBuilder: (context, index){
                return Obx(
                  ()=> Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: 
                        data[0]['promotinal_image'][index] == '' && controller.promotionalImagesList[index] == null ?
                        Image.asset(icAddImage, color: lightGrey, fit: BoxFit.cover,height: 100,)
                        : data[0]['promotinal_image'][index] != '' && controller.promotionalImagesList[index] == null ? 
                        Image.network(data[0]['promotinal_image'][index], fit: BoxFit.cover,height: 100,)
                        : Image.file(controller.promotionalImagesList[index], fit: BoxFit.cover,height: 100,)
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: const Icon(Icons.edit, color: darkFontGrey).box.height(28).width(28).roundedFull.color(lightGreyHalfOpacity).make().onTap(() {controller.pickImage(index, context);})
                      ),
                    ],
                  ).box.white.shadowSm.roundedSM.clip(Clip.antiAlias).make(),
                );
              }
            ),
            controller.isloading.value ? Center(child: loadingIndicator()) : myButton(
                title: 'Confirm to Add New Promotions',
                color: primary,
                textColor: whiteColor,
                onPress: ()async{
                  controller.isloading(true);
                  await controller.changePromotionalImages(doc);
                  // ignore: use_build_context_synchronously
                  await controller.updatePromotion(context, doc.id);
                }
              )
          ],
        );
      }
    }
  );
}