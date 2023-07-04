import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/controllers/blogcontroller.dart';
import 'package:explorergocustomer/views/admin_blogs_screen/edit_blogs.dart';
import 'package:explorergocustomer/views/admin_home_screen/admin_home.dart';

class AdminBlogDetails extends StatefulWidget {
  
  final String? title;
  final dynamic data;
  const AdminBlogDetails({super.key, this.title, this.data});

  @override
  State<AdminBlogDetails> createState() => _AdminBlogDetailsState();
}
class _AdminBlogDetailsState extends State<AdminBlogDetails> {
  
  @override
  Widget build(BuildContext context) {

     var controller = Get.put(BlogController());
    

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: widget.title!.text.size(18).semiBold.color(highEmphasis).make()
              ),
              5.heightBox,
              SizedBox(
                width: double.infinity,
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                    // aspectRatio: 16/9,
                    autoPlay: true,
                    height: 216,
                    enlargeCenterPage: true,
                    itemCount: widget.data['blogimglinks'].length,
                    itemBuilder: (context,index){
                      return Image.network(widget.data['blogimglinks'][index], height: 216, width: double.infinity,
                      fit: BoxFit.cover,
                      ).box.rounded.outerShadow.clip(Clip.antiAlias).margin(const EdgeInsets.all(2)).make();
                    }),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.location_pin, size: 20, color: primary,),
                        '${widget.data['bloglocation']}'.text.color(fontGrey).fontFamily(regular).size(20).make(),
                      ],
                    ),
                    if (widget.data['is_featured'] == true ) 'Featured'.text.semiBold.color(Colors.green).make(),
                  ],
                ).box.white.roundedSM.padding(const EdgeInsets.all(12)).margin(const EdgeInsets.symmetric(horizontal: 4)). outerShadow.make(),
              ),
              10.heightBox,
              '${widget.data['blogdetail']}'.text.make()
            ],
          ),
        ),
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: [

          //edit button
          FloatingActionButton(
            heroTag: null,  
            onPressed: (){
              controller.titleController.text = widget.data['blogtitle'].toString();
              controller.blogdetailController.text = widget.data['blogdetail'].toString();
              controller.locationController.text = widget.data['bloglocation'].toString();
              Get.off(()=> EditBlogScreen(data: widget.data,));
            },
            backgroundColor: primary,
            child: const Icon(Icons.edit),
          ),
          10.heightBox,

          //add featured button
          FloatingActionButton(
          heroTag: null,
          onPressed: (){
            if (widget.data['is_featured'] == true) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm Remove Featured"),
                    content: const Text("Are you sure you want to remove this blog as featured?"),
                    actions: [
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      TextButton(
                        child: const Text("Remove"),
                        onPressed: () {
                          controller.removeFeatured(widget.data.id);
                          VxToast.show(context, msg: "Blog removed from featured");
                          // Get.back();
                          Get.off(()=>const AdminHome());
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm Add Featured"),
                    content: const Text("Are you sure you want to add this blog as featured?"),
                    actions: [
                      TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      TextButton(
                        child: const Text("Add"),
                        onPressed: () {
                          controller.addFeatured(widget.data.id);
                          VxToast.show(context, msg: "Blog added to featured");
                          Get.off(()=>const AdminHome());
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          backgroundColor: primary,
          child: Image.asset(icFeature, color: whiteColor, height: 30),
          ),
          10.heightBox,

          //delete button
          FloatingActionButton(
          heroTag: null,
          onPressed: (){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Confirm Delete"),
                  content: const Text("Are you sure you want to delete this blog?"),
                  actions: [
                    TextButton(
                      child: const Text("Cancel"),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    TextButton(
                      child: const Text("Delete"),
                      onPressed: () {
                        controller.removeblog(widget.data.id);
                        VxToast.show(context, msg: 'Blog Deleted Successfully');
                        Get.off(()=> const AdminHome());
                      },
                    ),
                  ],
                );
              },
            );
          },
          backgroundColor: primary,
          child: const Icon(Icons.delete),
          ),
        ],
      )
    );
  }
}