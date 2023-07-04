import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/views/admin_booking_screen/admin_booking_details.dart';

Widget bookingListViewBuilder({data}){
  
  return ListView.builder(
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    itemCount: data.length,
    itemBuilder: (context, index){
      var docid = data[index].id;
      return ListTile(
       leading: data[index]['img_url'] == '' ? Image.asset(icRiver, width: 80, height: 100, fit: BoxFit.cover,).box.clip(Clip.antiAlias).roundedSM.make() : Image.network(data[index]['img_url'], width: 80, height: 100, fit: BoxFit.cover,).box.clip(Clip.antiAlias).roundedSM.make(),
        title: '${data[index]['trip_name']}'.text.fontFamily(bold).size(16).color(highEmphasis).make(),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Sailing: ${data[index]['e_date']}'.text.fontFamily(regular).size(14).color(fontGrey).make(),
            '${data[index]['status']}'.text.fontFamily(regular).size(14).color(data[index]['status'] == 'Pending' ? Colors.blue : data[index]['status'] == 'Cancelled' ?Colors.red : Colors.green).make()
          ],
        ),
        trailing: Image.asset(icRight, height: 20, color: lightGreyHalfOpacity,),
        onTap: (){
          Get.to(()=> AdminBookingDetails(dataid: docid));
        },
      ).box.margin(const EdgeInsets.only(bottom: 8)).make();
    }
  );
}