import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/views/categories_screen/event_details.dart';

Widget eventGridviewBuilder (data, controller){
  return GridView.builder(
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: data.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 4, crossAxisSpacing: 4, mainAxisExtent: 300), itemBuilder: (context,index){

      controller.checkIfFav(data[index]);
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(data[index]['e_images'][0],width: double.infinity, height: 100,fit: BoxFit.cover,).box.roundedSM.clip(Clip.antiAlias).make(),
                Align(
                  alignment: Alignment.topRight,
                  child: 
                  controller.isFave.value ? const Icon(Icons.favorite, color: redColor, size: 30,).box.padding(const EdgeInsets.all(8)).margin(const EdgeInsets.all(4)).color(darkFontGreyHalfOpacity).rounded.make().onTap(() {
                  if(controller.isFave.value){
                    controller.removeFromWishlist(data[index].id, context);
                  } else {
                    controller.addToWishlist(data[index].id, context);
                  }
                }) :
                const Icon(Icons.favorite_border_outlined, color: whiteColor, size: 30,).box.padding(const EdgeInsets.all(8)).margin(const EdgeInsets.all(4)).color(darkFontGreyHalfOpacity).rounded.make().onTap(() {
                if(controller.isFave.value){
                  controller.removeFromWishlist(data[index].id, context);
                } else {
                  controller.addToWishlist(data[index].id, context);
                }
              })),
                ]
            ),
            const Spacer(),
            '${data[index]['e_title']}'.text.fontFamily(bold).size(16).color(highEmphasis).make(),
            '${data[index]['duration']}'.text.fontFamily(regular).size(16).color(fontGrey).make(),
            'Sailing: ${data[index]['e_date']}'.text.fontFamily(regular).size(16).color(fontGrey).make(),
            Row(
              children: [
                "BDT".text.color(primary).fontFamily(regular).size(16).make(),
                2.widthBox,
                '${data[index]['e_price']}'.numCurrency.text.color(primary).fontFamily(regular).size(16).make(),
                ],
            ),
            'per person'.text.color(primary).fontFamily(regular).size(10).make(),
            2.heightBox,
            Row(
              children: [
                const Icon(Icons.location_pin, size: 14, color: primary,),
                Expanded(child: '${data[index]['e_location']}'.text.color(fontGrey).fontFamily(regular).size(14).make()),
              ],
            ),
          ],
        ).box.white.roundedSM.padding(const EdgeInsets.all(12)).margin(const EdgeInsets.symmetric(horizontal: 4)).outerShadow.make().onTap(() {
          controller.checkIfFav(data[index]);
          Get.to(()=> EventDetails(title: '${data[index]['e_title']}', data: data[index]));
        })
      );
    },
  );
}