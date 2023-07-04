import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/lists.dart';
import 'package:explorergocustomer/controllers/blogcontroller.dart';
import 'package:explorergocustomer/views/admin_blogs_screen/admin_blog_view.dart';
import 'package:explorergocustomer/views/admin_blogs_screen/edit_blogs.dart';
// import 'package:explorergocustomer/views/blogs_screen/blog_view.dart';
// import 'package:explorergocustomer/views/blogs_screen/edit_blogs.dart';
Widget blogListViewBuilder({data}){
  
  var blogController = Get.put(BlogController());
  return ListView.builder(
    shrinkWrap: true,
    physics: const BouncingScrollPhysics(),
    itemCount: data.length,
    itemBuilder: (context, index){
      return ListTile(
        leading: Image.network(data[index]['blogimglinks'][0], width: 80, height: 100, fit: BoxFit.cover,).box.clip(Clip.antiAlias).roundedSM.make(),
        title: '${data[index]['blogtitle']}'.text.fontFamily(bold).size(16).color(highEmphasis).make(),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           if (data[index]['is_featured'] == true ) 'Featured'.text.semiBold.color(Colors.green).make(),
          ],
        ),
        trailing: PopupMenuButton<int>(
          itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: [
                    Image.asset(
                      icFeature, height: 25,
                      color: data[index]['is_featured'] == true ? Colors.green : darkFontGrey,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      data[index]['is_featured'] == true ? "Remove Featured" : popMenuTitles[0],
                      style: TextStyle(
                        color: data[index]['is_featured'] == true ? Colors.green : darkFontGrey,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    const Icon(
                      Icons.edit,
                      color: darkFontGrey,
                    ),
                    const SizedBox(width: 5),
                    Text(popMenuTitles[1]),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: [
                    const Icon(
                      Icons.delete,
                      color: darkFontGrey,
                    ),
                    const SizedBox(width: 5),
                    Text(popMenuTitles[2]),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 0:
                  if (data[index]['is_featured'] == true) {
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
                                blogController.removeFeatured(data[index].id);
                                VxToast.show(context, msg: "Blog removed from featured");
                                Get.back();
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
                                blogController.addFeatured(data[index].id);
                                VxToast.show(context, msg: "Blog added to featured");
                                Get.back();
                              },
                            ),
                          ],
                        );
                      },
                    );
                    
                  }
                  break;
                case 1:
                  blogController.titleController.text = data[index]['blogtitle'].toString();
                  blogController.blogdetailController.text = data[index]['blogdetail'].toString();
                  blogController.locationController.text = data[index]['bloglocation'].toString();
                  Get.to(()=> EditBlogScreen(data: data[index]));
                  break;
                case 2:
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
                              blogController.removeblog(data[index].id);
                              VxToast.show(context, msg: 'Blog Deleted Successfully');
                              Get.back();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  break;
                default:
              }
            },
            icon: const Icon(Icons.more_vert_rounded),
          ),
        onTap: (){
          Get.to(()=> AdminBlogDetails(title: '${data[index]['blogtitle']}', data: data[index],));
        },
      );
    }
  );
}