import 'package:explorergocustomer/consts/consts.dart';
// import 'package:explorergocustomer/views/blogs_screen/tools/featured_blogs.dart';
import 'package:explorergocustomer/views/admin_home_screen/components/admin_featured_button.dart';
import 'package:explorergocustomer/views/admin_home_screen/components/admin_featured_events.dart';
import 'package:explorergocustomer/views/admin_home_screen/components/admin_popular_events.dart';
import 'package:explorergocustomer/views/admin_home_screen/components/admin_promotions.dart';
import 'package:explorergocustomer/widgets_common/appbar.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: "Dashboard"),
      body: Padding(padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              dashboard(),
              10.heightBox,
              const Divider(),
              10.heightBox,
              "Featured Events".text.size(16).semiBold.color(darkFontGrey).make(),
              10.heightBox,
              getFeaturedEvents(),
              10.heightBox,
              "Popular Events".text.size(16).semiBold.color(darkFontGrey).make(),
              getPopularEvents(),
              10.heightBox,
              const Divider(),
              10.heightBox,
              "Active Promotions".text.size(16).semiBold.color(darkFontGrey).make(),
              10.heightBox,
              activePromotions(),
              const Divider(),
              10.heightBox,
              "Featured Blogs".text.size(16).semiBold.color(darkFontGrey).make(),
              10.heightBox,
              // getFeaturedBlogs(),
              10.heightBox,
            ],
          ),
        )
      ),
    );
  }
}