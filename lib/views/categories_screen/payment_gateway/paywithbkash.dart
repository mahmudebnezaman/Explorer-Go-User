import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
class PayWithBkash extends StatefulWidget {
  final dynamic dataId;

  const PayWithBkash({Key? key, required this.dataId}) : super(key: key);

  @override
  State<PayWithBkash> createState() => _PayWithBkashState();
}

class _PayWithBkashState extends State<PayWithBkash> {

  @override
  Widget build(BuildContext context) {
  
    var controller = Get.find<ProductController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icBkash, height: 120,).box.shadowSm.roundedSM.padding(const EdgeInsets.symmetric(horizontal: 20)).white.makeCentered().onTap(() {
              controller.confirmOrderController(widget.dataId);
              VxToast.show(context, msg: 'Booking Placed for approval');  
            })
          ],
        )
      ),
    );
  }
}