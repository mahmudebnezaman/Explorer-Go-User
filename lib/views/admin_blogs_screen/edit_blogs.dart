import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/blogcontroller.dart';
import 'package:explorergocustomer/views/admin_blogs_screen/tools/blog_cat_dropdown.dart';
import 'package:explorergocustomer/views/admin_blogs_screen/tools/edit_blog_images.dart';
import 'package:explorergocustomer/widgets_common/custom_textfeild.dart';
import 'package:explorergocustomer/widgets_common/details_textfield.dart';
import 'package:explorergocustomer/widgets_common/my_button.dart';

class EditBlogScreen extends StatefulWidget {
  final dynamic data;
  const EditBlogScreen({super.key, this.data});

  @override
  State<EditBlogScreen> createState() => _EditBlogScreenState();
}

class _EditBlogScreenState extends State<EditBlogScreen> {
  @override
  Widget build(BuildContext context) {

    var controller = Get.put(BlogController());

    return Obx(
      ()=> Scaffold(
        appBar: AppBar(
          title: "Update blog".text.semiBold.make(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customTextFeild(title: "Blog title", hint: "Enter a short title", controller: controller.titleController),
                  5.heightBox,
                  "Add Images:".text.color(highEmphasis).semiBold.size(16).make(),
                  "Note: First image will be cover image*".text.color(fontGrey).semiBold.size(12).make(),
                  10.heightBox,
                  editBlogImages(widget.data),
                  5.heightBox,
                  customTextFeild(title: "Location", hint: "ex: Dhaka, Bangladesh", controller: controller.locationController),
                  5.heightBox,
                  "Category:".text.color(highEmphasis).semiBold.size(16).make(),
                  "Please check the category properly it will change everytime you edit the event*".text.size(10).color(redColor).make(),
                  const BlogDropdownButtonCategory(),
                  5.heightBox,
                  detailsTextField(title: 'Blog Details', hint: 'Enter your blogs details briefly here!',controller: controller.blogdetailController),
                  5.heightBox,
                  controller.isloading.value ? Center(child: loadingIndicator()) : myButton(
                    title: "Update",
                    buttonSize: 20.0,
                    color: primary,
                    textColor: whiteColor,
                    onPress: () async {
                      controller.isloading(true);
                      await controller.newUploadImages();
                      // ignore: use_build_context_synchronously
                      await controller.updateblog(context, widget.data.id);
                      
                      Get.back();
                    }
                  ).box.width(context.screenWidth).make(),
                  5.heightBox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}