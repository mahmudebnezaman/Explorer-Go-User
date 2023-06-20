// ignore_for_file: use_build_context_synchronously

import 'package:explorergocustomer/consts/consts.dart';


class BookingDetails extends StatefulWidget {
  
  final String? title;
  final dynamic data;
  const BookingDetails({super.key, this.title, this.data});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}


class _BookingDetailsState extends State<BookingDetails> {


  @override
  Widget build(BuildContext context) {
    var bookingTitle = ['Pickup Note', 'Itinerary'];
    var bookingTitleImage = [icRout, icItinerary];
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: widget.title!.text.fontFamily(bold).color(highEmphasis).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 380,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.data['img_url'] =='' ? Image.asset(icRiver, height: 200, width: 384,
                    fit: BoxFit.cover,
                    ).box.rounded.outerShadow.clip(Clip.antiAlias).margin(const EdgeInsets.all(2)).make():
                    Image.network(widget.data['img_url'], height: 200, width: 384,
                    fit: BoxFit.cover,
                    ).box.rounded.outerShadow.clip(Clip.antiAlias).margin(const EdgeInsets.all(2)).make(),
                    
                    const Spacer(),
                    Row(
                      children: [
                        'Status: '.text.fontFamily(regular).size(18).color(fontGrey).make(),
                        '${widget.data['status']}'.text.fontFamily(regular).size(18).color(widget.data['status'] == 'Pending' ? Colors.blue : widget.data['status'] == 'Cancelled' ?Colors.red : Colors.green).make(),
                      ],
                    ),
                    'Sailing: ${widget.data['e_date']}'.text.fontFamily(regular).size(18).color(fontGrey).make(),
                    'Number of Travelers: ${widget.data['traveler_count']}'.text.fontFamily(regular).size(18).color(fontGrey).make(),
                    Row(
                      children: [
                        "Total paid: BDT".text.color(primary).fontFamily(regular).size(18).make(),
                        2.widthBox,
                        '${widget.data['total_price']}'.numCurrency.text.color(primary).fontFamily(regular).size(20).make(),
                        ],
                    ),
                    
                    2.heightBox,
                    Row(
                      children: [
                        const Icon(Icons.location_pin, size: 20, color: primary,),
                        Expanded(child: '${widget.data['location']}'.text.color(fontGrey).fontFamily(regular).size(18).make()),
                        ],
                      ),
                    Expanded(child: 'Order ID: ${widget.data.id}'.text.fontFamily(regular).size(18).color(fontGrey).make()),
                  ],
                ).box.white.roundedSM.padding(const EdgeInsets.all(12)).margin(const EdgeInsets.symmetric(horizontal: 4)).outerShadow.make(),
              ),
              10.heightBox,
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'Travelers Info.'.text.size(20).bold.color(highEmphasis).make(),
                      const Divider(color: highEmphasis,thickness: 0.5),
                      Row(
                        children: [
                          'Name: '.text.size(18).semiBold.color(highEmphasis).make(),
                          '${widget.data['traveler_name']}'.text.size(18).color(fontGrey).make(),
                        ],
                      ),
                      Row(
                        children: [
                          'Email: '.text.size(18).semiBold.color(highEmphasis).make(),
                          '${widget.data['traveler_email']}'.text.size(18).color(fontGrey).make(),
                        ],
                      ),
                      Row(
                        children: [
                          'Contact Number: '.text.size(18).semiBold.color(highEmphasis).make(),
                          '${widget.data['traveler_mobile']}'.text.size(18).color(fontGrey).make(),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              10.heightBox,
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: bookingTitle.length,
                itemBuilder: (BuildContext context, int index){
                  var txt = bookingTitle[index];
                  return ListTile(
                    leading: Image.asset(bookingTitleImage[index], color: highEmphasis, height: 24,),
                    title: txt.text.fontFamily(semibold).size(18).color(highEmphasis).make(),
                    trailing: const Icon(Icons.arrow_drop_down),
                  ).box.roundedSM.margin(const EdgeInsets.symmetric(vertical: 4)).white.shadowSm.make().onTap(() {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: SizedBox(
                          height: context.height,
                          width: context.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(txt,
                                  style: const TextStyle(color: highEmphasis, fontSize: 20, fontFamily: bold),),
                                  IconButton(onPressed: ()=> Get.back(), icon: const Icon(Icons.close_rounded))
                                ],
                              ),
                              5.heightBox,
                               Expanded(
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: '${widget.data[txt]}'.text.make()
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}