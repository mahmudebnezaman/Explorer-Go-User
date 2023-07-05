import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:explorergocustomer/consts/consts.dart';

class NetworkController extends GetxController {
   final Connectivity _connectivity = Connectivity();

   @override
   void onInit(){
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
   }

   void _updateConnectionStatus(ConnectivityResult connectivityResult){
    if (connectivityResult == ConnectivityResult.none){
      Get.rawSnackbar(
        messageText: 'PLEASE CONNECT TO THE INTERNET'.text.white.size(14).semiBold.make(),
        isDismissible: false,
        duration: const Duration(days: 1),
        backgroundColor: Colors.red,
        icon: const Icon(Icons.wifi_off, color: whiteColor,size: 35,),
        margin: EdgeInsets.zero,
        snackStyle: SnackStyle.GROUNDED
      );
    }else{
      if (Get.isSnackbarOpen){
        Get.closeCurrentSnackbar();
      }
    }
   }
}
