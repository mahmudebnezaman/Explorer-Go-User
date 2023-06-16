import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/lists.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/views/categories_screen/category_details.dart';
import 'package:explorergocustomer/views/home_screen/components/featured_blogs.dart';
import 'package:explorergocustomer/views/home_screen/components/featured_button.dart';
import 'package:explorergocustomer/views/home_screen/components/featured_event.dart';
import 'package:explorergocustomer/views/home_screen/components/promotional_swriper.dart';
import 'package:explorergocustomer/views/home_screen/components/sarch_screen.dart';
import 'package:explorergocustomer/widgets_common/custom_event.dart';
// import 'package:explorergocustomer/widgets_common/home_buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState(){
    super.initState();
    switchCategory(recomended);
  }

  switchCategory(title){
  upcomingEventMethod = FireStoreServices.getUpcomingEvents(title);
  }

  bool subcat = false;
  var controller = Get.put(ProductController());
  dynamic upcomingEventMethod;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Row(
                    children: [
                      "Hello, ".text.bold.color(highEmphasis).fontFamily(bold).size(30).make(),
                      "Explorer".text.bold.color(primary).fontFamily(bold).size(30).make(),
                    ],
                  ),
                Image.asset(icBell, height: 25, color: highEmphasis,)//notification bell
               ],),
               10.heightBox,
               TextField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(12),
                  ),
                  hintText: whereTo,
                  suffixIcon: IconButton(onPressed: (){
                    Get.to(SearchScreen(searchTitle: controller.searchController.text,));
                  }, icon: const Icon(Icons.search)),
                  hintStyle: const TextStyle(
                  fontFamily: semibold,
                  color: textfieldGrey,
                  fontSize: 16,
                  ),
                ),
                onSubmitted: (value) {
                  Get.to(SearchScreen(searchTitle: controller.searchController.text,));
                },
               ),// search feild
               10.heightBox,
               "Upcominig Events".text.semiBold.size(20).color(highEmphasis).make(),
               5.heightBox,
               Row(
                children: List.generate(eventTitles.length, (index) => eventTitles[index].text.size(16).color(darkFontGrey).make().box.margin(const EdgeInsets.only(right: 8)).make().onTap(() {
                      subcat = true;
                      switchCategory(eventTitles[index]);
                      setState(() {});
                  })),
                ),
                10.heightBox,
                getFeaturedEvents(upcomingEventMethod),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Categories".text.semiBold.size(20).color(highEmphasis).make(),
                    "See All".text.size(16).color(darkFontGrey).make().onTap(() {
                      Get.to(()=> const CategoryDetails(title: "All"));}
                    )
                  ],
                ),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(featuredList1.length,
                  (index) => featuredButton(
                    icon: featuredList1[index],
                    title: featuredTitles1[index]
                  ))
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(featuredList2.length,
                  (index) => featuredButton(
                    icon: featuredList2[index],
                    title: featuredTitles2[index], 
                  ))
                ),
                const Divider(),
                customTour(),
                const Divider(),
                getPromotinalProducts(),
                const Divider(),
                getFeaturedBlogs()
              ],
            ),
          )
        ),
      ),
    );
  }
}