import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/lists.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/blogcontroller.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/views/blog_screen/blog_view.dart';


// import 'item_details.dart';

class BlogScreen extends StatefulWidget {

  final String? title;

  const BlogScreen({super.key, this.title});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
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
      
      appBar: AppBar(
        title: "Blogs".text.fontFamily(bold).color(highEmphasis).make(),
      ),

      body:
        SafeArea(
          child: Padding(
          padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      })
                    ),
                  ),
                ),
                20.heightBox,
                //item container
                StreamBuilder(
                  stream: blogMethod,
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(!snapshot.hasData){
                      return Center(
                        child: loadingIndicator(),
                      );
                    } else if (snapshot.data!.docs.isEmpty){
                      return Center(
                        child: Column(
                          children: [
                            Image.asset(icDepressed, color: darkFontGrey, height: 120,),
                            "Seems Like No Blogs Written yet!".text.color(darkFontGrey).make(),
                          ],
                        ),
                      );
                    } else {
                      var data = snapshot.data!.docs;
                      return Expanded(child:GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisSpacing: 4, crossAxisSpacing: 4, mainAxisExtent: 250), itemBuilder: (context,index){
                
                          controller.checkIfFav(data[index]);
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Image.network(data[index]['blogimglinks'][0],width: double.infinity, height: 180,fit: BoxFit.fitWidth,).box.roundedSM.clip(Clip.antiAlias).make(),
                                  //   Align(
                                  //     alignment: Alignment.topRight,
                                  //     child: 
                                  //     controller.isFave.value ? const Icon(Icons.favorite, color: redColor, size: 30,).box.padding(const EdgeInsets.all(8)).margin(const EdgeInsets.all(4)).color(darkFontGreyHalfOpacity).rounded.make().onTap(() {
                                  //     if(controller.isFave.value){
                                  //       controller.removeFromWishlist(data[index].id, context);
                                  //     } else {
                                  //       controller.addToWishlist(data[index].id, context);
                                  //     }
                                  //   }) :
                                  //   const Icon(Icons.favorite_border_outlined, color: whiteColor, size: 30,).box.padding(const EdgeInsets.all(8)).margin(const EdgeInsets.all(4)).color(darkFontGreyHalfOpacity).rounded.make().onTap(() {
                                  //   if(controller.isFave.value){
                                  //     controller.removeFromWishlist(data[index].id, context);
                                  //   } else {
                                  //     controller.addToWishlist(data[index].id, context);
                                  //   }
                                  // })),
                                    ]
                                ),
                                const Spacer(),
                                '${data[index]['blogtitle']}'.text.overflow(TextOverflow.ellipsis).maxLines(1).fontFamily(bold).size(16).color(highEmphasis).make(),
                                '${data[index]['blogdetail']}'.text.overflow(TextOverflow.ellipsis).maxLines(1).fontFamily(regular).size(16).color(fontGrey).make(),
                              ],
                            ).box.white.roundedSM.padding(const EdgeInsets.all(12)).margin(const EdgeInsets.symmetric(horizontal: 4)).outerShadow.make().onTap(() {
                              controller.checkIfFav(data[index]);
                              Get.to(()=> BlogDetails(title: '${data[index]['blogtitle']}', data: data[index],));
                            })
                          );
                        },
                      ),);
                    }
                  },
                ),
            ]
          ),
        ),
      ),
    );
  }
}