import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/views/blog_screen/blog_view.dart';


Widget getFeaturedBlogs(){
  return StreamBuilder(
    stream: FireStoreServices.getFeaturedBlogs(),
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
        return ListView.separated(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: data.length > 5 ? 5 : data.length,
          itemBuilder: (context, index){
            return ListTile(
              leading: Image.network(data[index]['blogimglinks'][0], width: 100, height: 100, fit: BoxFit.cover,).box.roundedSM.clip(Clip.antiAlias).make(),
              title: '${data[index]['blogtitle']}'.text.fontFamily(bold).size(16).color(highEmphasis).make(),
              subtitle: "See more...".text.color(darkFontGrey).overflow(TextOverflow.ellipsis).make(),
              onTap: (){
                Get.to(()=> BlogDetails(title: '${data[index]['blogtitle']}', data: data[index],));
              },
            );
          }, separatorBuilder: (BuildContext context, int index)=>const Divider(),
        );
      }
    }
  );
}