// ignore_for_file: use_build_context_synchronously

import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/lists.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/views/home_screen/home.dart';
import 'package:explorergocustomer/widgets_common/custom_textfeild.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

// ignore: constant_identifier_names
enum SdkType { LIVE }
class EventDetails extends StatefulWidget {
  
  final String? title;
  final dynamic data;
  const EventDetails({super.key, this.title, this.data});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

  String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  RegExp regExp = RegExp(p);

  var controller = Get.put(ProductController());

class _EventDetailsState extends State<EventDetails> {

  void vaildation(context, dataId) async {
    if (controller.bookingEmailController.text.isEmpty && controller.bookingNameController.text.isEmpty && controller.bookingNumberController.text.isEmpty) {
      VxToast.show(context, msg: "Please fill up all the feilds");
    } else {
      if (controller.bookingEmailController.text.isEmpty) {
        VxToast.show(context, msg: "Email feild is Empty");
      } else if (controller.bookingNameController.text.isEmpty) {
        VxToast.show(context, msg: "Name feild is Empty");
      } else if (controller.bookingNumberController.text.isEmpty) {
        VxToast.show(context, msg: "Number feild is Empty");
      } else if (!regExp.hasMatch(controller.bookingEmailController.text)) {
        VxToast.show(context, msg: "Please Try Vaild Email ");
      } else if (controller.bookingNumberController.text.length < 11) {
        VxToast.show(context, msg: "Please Try Vaild Number");
      } else if (controller.bookingNumberController.text.length > 11) {
        VxToast.show(context, msg: "Please Try Vaild Number");
      } else if (controller.quantity < 1) {
        VxToast.show(context, msg: "Minimum number of traveler is 1");
      }else {
        sslCommerzGeneralCall();
      }
    }
  }

  final ScrollController _scrollController = ScrollController();
  bool showFloatingButton = true; // Added variable to control visibility of floating action button

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // Reached the bottom of the screen
      setState(() {
        showFloatingButton = false;
      });
    } else {
      setState(() {
        showFloatingButton = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    controller.bookingNameController.text = auth.currentUser!.displayName!;
    controller.bookingEmailController.text = auth.currentUser!.email!;

    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: widget.title!.text.fontFamily(bold).color(highEmphasis).make(),
          actions: [
            Obx(
              ()=> controller.isFave.value ? const Icon(Icons.favorite, color: redColor, size: 30,).box.margin(const EdgeInsets.only( right: 12)).make().onTap(() {
                if(controller.isFave.value){
                  controller.removeFromWishlist(widget.data.id, context);
                } else {
                  controller.addToWishlist(widget.data.id, context);
                }
              }) :
              const Icon(Icons.favorite_border_outlined, color: highEmphasis, size: 30,).box.margin(const EdgeInsets.only( right: 12)).make().onTap(() {
                if(controller.isFave.value){
                  controller.removeFromWishlist(widget.data.id, context);
                } else {
                  controller.addToWishlist(widget.data.id, context);
                }
              }),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 320,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VxSwiper.builder(
                      aspectRatio: 16/9,
                      autoPlay: true,
                      height: 216,
                      enlargeCenterPage: true,
                      itemCount: widget.data['e_images'].length,
                      itemBuilder: (context,index){
                        return Image.network(widget.data['e_images'][index], height: 200, width: 384,
                      fit: BoxFit.cover,
                      ).box.rounded.outerShadow.clip(Clip.antiAlias).margin(const EdgeInsets.all(2)).make();
                    }),
                      
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.timelapse, color: fontGrey,),
                              2.widthBox,
                              '${widget.data['duration']}'.text.fontFamily(regular).size(18).color(fontGrey).make(),
                            ],
                          ),
                          'Sailing: ${widget.data['e_date']}'.text.fontFamily(regular).size(18).color(fontGrey).make(),
                        ],
                      ),
                      Row(
                        children: [
                          "BDT".text.color(primary).fontFamily(regular).size(20).make(),
                          2.widthBox,
                          '${widget.data['e_price']}'.numCurrency.text.color(primary).fontFamily(regular).size(20).make(),
                          ' per person'.text.color(primary).fontFamily(regular).size(10).make(),
                          ],
                      ),
                      
                      2.heightBox,
                      Row(
                        children: [
                          const Icon(Icons.location_pin, size: 20, color: primary,),
                          '${widget.data['e_location']}'.text.color(fontGrey).fontFamily(regular).size(18).make(),
                          ],
                        ),
                    ],
                  ).box.white.roundedSM.padding(const EdgeInsets.all(12)).margin(const EdgeInsets.symmetric(horizontal: 4)).outerShadow.make(),
                ),
                
                10.heightBox,
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: eventIconList.length,
                  itemBuilder: (BuildContext context, int index){
                    var txt = eventTitleList[index];
                    return ListTile(
                      leading: Image.asset(eventIconList[index], color: highEmphasis, height: 24,),
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
                10.heightBox,
                customTextFeild(title: name, hint: nameHint, prefixIcon: const Icon(Icons.verified_user_rounded), controller: controller.bookingNameController),
                5.heightBox,
                customTextFeild(title: email, hint: emailHint, prefixIcon: const Icon(Icons.email_outlined), controller: controller.bookingEmailController),
                5.heightBox,
                customTextFeild(title: "Mobile", hint: "Enter your mobile number.", prefixIcon: const Icon(Icons.mobile_friendly_outlined),controller: controller.bookingNumberController, keytype: TextInputType.number, maxLength: 11),
                5.heightBox,
                Obx(
                  () => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "Number of travellers: ".text.semiBold.size(18).make(),
                          5.widthBox,
                          IconButton(onPressed: (){
                            controller.decressQuantity();
                            controller.calculateTotalPrice(int.parse(widget.data["e_price"]));
                          },
                            icon: const Icon(Icons.remove)
                          ),
                          5.widthBox,
                          controller.quantity.value.text.size(18).color(darkFontGrey).make(),
                          IconButton(onPressed: (){
                            controller.increseQuantity(int.parse(widget.data["available_seats"]));
                            controller.calculateTotalPrice(int.parse(widget.data["e_price"]));
                          },
                            icon: const Icon(Icons.add)
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: "(only ${widget.data["available_seats"]} seats avaiable hurry up!!!)".text.make()
                      ),
                      8.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "Total: ".text.semiBold.size(18).make(),
                          5.widthBox,
                          "BDT".text.color(primary).size(18).bold.make(),
                          5.widthBox,
                          controller.totalPrice.value.numCurrency.text.size(18).color(primary).bold.make(),
                        ],
                      )
                    ],
                  ),
                ),
                10.heightBox,
                myButton(
                  buttonSize: 20.0,
                  color: primary,
                  textColor: whiteColor,
                  title: "Confirm Booking",
                  onPress: (){
                    vaildation(context, widget.data.id);
                  }
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: showFloatingButton ? FloatingActionButton.extended(
          onPressed: (){
            scrollToBottom();
          },
          backgroundColor: primary,
          label: "Book Now".text.size(20).fontFamily(semibold).make(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7)
          )
          ) : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

    Future<void> sslCommerzGeneralCall() async {
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        //Use the ipn if you have valid one, or it will fail the transaction.
        ipn_url: "www.ipnurl.com",
        multi_card_name: "",
        currency: SSLCurrencyType.BDT,
        product_category: "Food",
        sdkType: SSLCSdkType.LIVE,
        store_id: "demotest",
        store_passwd: "qwerty",
        total_amount: controller.totalPrice.toDouble(),
        tran_id: DateTime.now().toString(),
      ),
    );
    try {
      SSLCTransactionInfoModel result = await sslcommerz.payNow();

      if (result.status!.toLowerCase() == "failed") {
        controller.confirmOrderController(widget.data['e_title'], widget.data['e_date']);
        Get.offAll(()=>const Home());
        VxToast.show(context, showTime: 5000, msg: "Booking Reserved!");
      } else if (result.status!.toLowerCase() == "closed") {
        VxToast.show(
          context,
          msg: "Payment Failed",
        );
      } else {
        VxToast.show(
          context,
            msg:"Transaction is ${result.status} and Amount is ${result.amount}"
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}