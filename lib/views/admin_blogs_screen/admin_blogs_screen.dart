import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/lists.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/blogcontroller.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/views/admin_blogs_screen/add_blogs_screen.dart';
import 'package:explorergocustomer/widgets_common/appbar.dart';
import 'package:explorergocustomer/widgets_common/blog_listviewbuilder.dart';


class AdminBlogScreen extends StatefulWidget {

  final String? title;
  
  const AdminBlogScreen({super.key, Key? required, this.title });

  @override
  State<AdminBlogScreen> createState() => _AdminBlogScreenState();
}

class _AdminBlogScreenState extends State<AdminBlogScreen> {

  bool isMenuOpen = false;

  @override
  void initState(){
    super.initState();
    switchCategory(widget.title);
  }
  
   switchCategory(title){
    blogMethod = FireStoreServices.getBlogs(title);
   }

    bool subcat = false;
    var controller = Get.put(BlogController());
    dynamic blogMethod;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: appBarWidget(
        title: "Blogs"
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
               children: List.generate(
                blogCategoriesTitles.length,
                (index) => blogCategoriesTitles[index].text.fontFamily(semibold).color(darkFontGrey).size(16).makeCentered().box.color(lightGrey).padding(const EdgeInsets.all(8)).margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.shadowSm.make().onTap(() {
                  subcat = true;
                  switchCategory(blogCategoriesTitles[index]);
                  setState(() {});
                })),
              ),
            ),
            20.heightBox,
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: StreamBuilder(
                stream: blogMethod,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: loadingIndicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty){
                    return Column(
                      children: [
                        Image.asset(icDepressed, color: darkFontGrey, height: 120,),
                        "Seems Like No Blogs Written Yet!!".text.color(darkFontGrey).make(),
                      ],
                    );
                  } else {
                    var data = snapshot.data!.docs;
                    return blogListViewBuilder(data: data);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        controller.titleController.clear();
        controller.blogdetailController.clear();
        controller.blogImagesList= RxList<dynamic>.generate(6, (index) => null);
        controller.blogImagesLinks.clear();
        controller.category.clear();
        controller.locationController.clear();
        Get.to(()=> const AddBlogScreen());
      },
        backgroundColor: primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}



