import 'package:explorergocustomer/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/services/firestore_services.dart';

Widget editEventImages(data){

  var controller = Get.find<ProductController>();

  return StreamBuilder(
    stream: FireStoreServices.getPromotionalProducts(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      if(!snapshot.hasData){
        return Center(
          child: loadingIndicator(),
        );
      }else{
        // var data = snapshot.data!.docs;  
        return GridView.builder(
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
            return 
              Stack(
                children: [
                  Obx(
                    ()=> Align(
                      alignment: Alignment.topCenter,
                      child:
                      data['e_images'][index] != '' && controller.eventImagesList[index] == null ? Image.network(data['e_images'][index], fit: BoxFit.cover,height: 100,)
                      : Image.file(controller.eventImagesList[index])
                    ),
                  ), 
                  Align(
                    alignment: Alignment.topRight,
                    child: const Icon(Icons.edit, color: darkFontGrey).box.height(28).width(28).roundedFull.color(lightGreyHalfOpacity).make().onTap(() {
                      controller.pickImage(index, context);
                    })
                  ),
                ],
              ).box.white.shadowSm.roundedSM.clip(Clip.antiAlias).make();

          }
        );
      }
    }
  );
}