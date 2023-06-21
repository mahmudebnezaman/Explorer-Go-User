import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/views/categories_screen/event_details.dart';

Widget getFeaturedEvents(stream){
  return StreamBuilder(
    stream: stream,
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
              "Seems Like No Upcoming Events".text.color(darkFontGrey).make(),
            ],
          ),
        );
      } else {
        var data = snapshot.data!.docs;
        return VxSwiper.builder(
          aspectRatio: 16/9,
            autoPlay: true,
            height: 216,
            enlargeCenterPage: true,
            itemCount: data.length>6 ? 6: data.length,
            itemBuilder: (context,index){
              return Image.network(data[index]['e_images'][0], height: 216, width: 384,
              fit: BoxFit.cover,
              ).box.rounded.outerShadow.clip(Clip.antiAlias).margin(const EdgeInsets.all(2)).make().onTap(() {
                Get.to(()=>EventDetails(data: data[index]));
              });
            });
      }
    }
  );
}