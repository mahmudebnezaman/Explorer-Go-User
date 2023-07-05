import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/controllers/network_controller.dart';

class DependencyInjection {
  static void init(){
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}