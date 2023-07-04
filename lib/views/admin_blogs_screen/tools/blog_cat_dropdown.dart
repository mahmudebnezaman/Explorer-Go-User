import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/lists.dart';
import 'package:explorergocustomer/controllers/blogcontroller.dart';

class BlogDropdownButtonCategory extends StatefulWidget {
  const BlogDropdownButtonCategory({super.key});

  @override
  State<BlogDropdownButtonCategory> createState() => _BlogDropdownButtonCategoryState();
}

class _BlogDropdownButtonCategoryState extends State<BlogDropdownButtonCategory> {
  String dropdownValue = blogCategoriesTitles.first;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<BlogController>();
    return DropdownButton<String>(
      isExpanded: true,
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward_rounded),
      elevation: 16,
      style: const TextStyle(color: fontGrey),
      underline: Container(
        height: 2,
        color: primary,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
        
      controller.categoryValue.value = value!.toString();
      },
      items: blogCategoriesTitles.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: value.text.semiBold.size(18).make(),
        );
      }).toList(),
    );
  }
}