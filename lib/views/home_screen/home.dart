import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/controllers/home_controller.dart';
import 'package:explorergocustomer/views/blog_screen/blog_screen.dart';

// import 'package:explorergocustomer/controllers/home_controller.dart';

import 'package:explorergocustomer/views/home_screen/home_screen.dart';
import 'package:explorergocustomer/views/profile_screen/profile_screen.dart';
import 'package:explorergocustomer/views/saved_screen/saved_screen.dart';
// import 'package:explorergocustomer/views/saved_screen/saved_screen.dart';

class Home extends StatefulWidget {


  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime timeBackPressed =DateTime.now();

  @override
  Widget build(BuildContext context) {

    // home controller
    var controller = Get.put(HomeController());

    var navBarItem = [
      BottomNavigationBarItem(icon: Image.asset(icHome, width: 26), label: home),
      BottomNavigationBarItem(icon: Image.asset(icBlog, width: 26, color: bottomNavGrey,), label: blogs,),
      BottomNavigationBarItem(icon: Image.asset(icHeart, width: 26,color: bottomNavGrey), label: saved),
      BottomNavigationBarItem(icon: Image.asset(icSuitcase, width: 26, color: bottomNavGrey,), label: bookings),
      BottomNavigationBarItem(icon: Image.asset(icProfile, width: 26), label: profile),
    ];

    var navBody = [
      const HomeScreen(),
      const BlogScreen(),
      const SavedScreen(),
      const ProfileScreen(),
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