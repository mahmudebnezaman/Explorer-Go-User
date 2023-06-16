import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/services/firestore_services.dart';

Widget getPromotinalProducts(){
  return StreamBuilder(
    stream: FireStoreServices.getPromotionalProducts(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
      if(!snapshot.hasData){
        return Center(
          child: loadingIndicator(),
        );
      }else {
        var data = snapshot.data!.docs;
        return VxSwiper.builder(
          aspectRatio: 16/9,
            autoPlay: true,
            height: 150,
            enlargeCenterPage: true,
            itemCount: data[0]['promotinal_image'].length,
            itemBuilder: (context,index){
              return Image.network(data[0]['promotinal_image'][index], height: 140, width: 384,
              fit: BoxFit.cover,
              ).box.rounded.outerShadow.clip(Clip.antiAlias).margin(const EdgeInsets.all(2)).make();
            });
      }
    }
  );
}