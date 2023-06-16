import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/product_controller.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/widgets_common/custom_event.dart';
import 'package:explorergocustomer/widgets_common/event_gridview_builder.dart';

class SearchScreen extends StatefulWidget {
  final String searchTitle;

  const SearchScreen({Key? key, required this.searchTitle}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String srchtext = '';

  @override
  void initState() {
    super.initState();
    srchtext = widget.searchTitle;
  }

  @override
  Widget build(BuildContext context) {
    var productController = Get.find<ProductController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Column(
          children: [
            TextField(
              controller: productController.searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: whereTo,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      srchtext = productController.searchController.text;
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
                hintStyle: const TextStyle(
                  fontFamily: semibold,
                  color: textfieldGrey,
                  fontSize: 16,
                ),
              ),
              onSubmitted: (value) {
                setState(() {
                  srchtext = value;
                });
              },
            ),
            10.heightBox,
            FutureBuilder(
              future: FireStoreServices.searchProducts(srchtext),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                var data = snapshot.data?.docs;
                var filtered = data
                    ?.where((element) => element['e_title']
                        .toString()
                        .toLowerCase()
                        .contains(srchtext.toLowerCase()))
                    .toList();
                if (!snapshot.hasData) {
                  return Center(
                    child: loadingIndicator(),
                  );
                } else if (filtered!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          icDepressed,
                          color: darkFontGrey,
                          height: 120,
                        ),
                        "Seems Like No Upcoming Events"
                            .text
                            .color(darkFontGrey)
                            .make(),
                        10.heightBox,
                        customTour()
                      ],
                    ),
                  );
                } else {
                  return Expanded(
                    child: eventGridviewBuilder(filtered, productController),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
