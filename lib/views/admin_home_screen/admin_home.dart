import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/controllers/home_controller.dart';
import 'package:explorergocustomer/views/admin_blogs_screen/admin_blogs_screen.dart';
import 'package:explorergocustomer/views/admin_booking_screen/admin_booking_screen.dart';
import 'package:explorergocustomer/views/admin_events_screen/admin_events_screen.dart';
import 'package:explorergocustomer/views/admin_home_screen/admin_home_screen.dart';
import 'package:explorergocustomer/views/profile_screen/profile_screen.dart';

class AdminHome extends StatefulWidget {


  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  DateTime timeBackPressed =DateTime.now();

  @override
  Widget build(BuildContext context) {

     // home controller
    var controller = Get.put(HomeController());

    var navBarItem = [
      BottomNavigationBarItem(icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(icon: Image.asset(icBlog, width: 26, color: bottomNavGrey,), label: blogs,),
      BottomNavigationBarItem(icon: Image.asset(icTodaysDeal, width: 26,color: bottomNavGrey), label: 'Events'),
      BottomNavigationBarItem(icon: Image.asset(icSuitcase, width: 26, color: bottomNavGrey,), label: bookings),
      BottomNavigationBarItem(icon: Image.asset(icProfile, width: 26), label: profile),
    ];

    var navBody = [
      const AdminHomeScreen(),
      const AdminBlogScreen(),
      const AdminEventScreen(),
      const AdminBookingScreen(),
      const ProfileScreen(),
    ]; 

    return WillPopScope(
      onWillPop: () async {
        if (controller.currentNavIndex.value == 0) {
          var difference = DateTime.now().difference(timeBackPressed);
          var isExitWarning = difference>= const Duration(seconds: 2);
          timeBackPressed = DateTime.now();
          if (isExitWarning){
          VxToast.show(context, msg: 'Press again to Exit!');
          return false;
        }else{
          return true;
        }}
        else{
          setState((){
            controller.currentNavIndex.value = 0 ;
          });
          return false;
        }

      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(()=>
              Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value)
                ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(()=>
          BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: primary,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            type: BottomNavigationBarType.fixed,
            items: navBarItem,
            onTap: (value){
              controller.currentNavIndex.value=value;
            },
            ),
        ),
      ),
    );
  }
}