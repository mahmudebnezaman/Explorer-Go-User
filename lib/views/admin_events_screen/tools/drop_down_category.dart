import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/lists.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';

class DropdownButtonCategory extends StatefulWidget {
  const DropdownButtonCategory({super.key});

  @override
  State<DropdownButtonCategory> createState() => _DropdownButtonCategoryState();
}

class _DropdownButtonCategoryState extends State<DropdownButtonCategory> {
  String dropdownValue = categoriesTitles.first;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
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
      items: categoriesTitles.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: value.text.semiBold.size(18).make(),
        );
      }).toList(),
    );
  }
}