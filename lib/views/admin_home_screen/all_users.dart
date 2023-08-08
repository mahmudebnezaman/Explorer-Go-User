import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';
import 'package:explorergocustomer/controllers/auth_controller.dart';
import 'package:explorergocustomer/services/firestore_services.dart';
import 'package:explorergocustomer/widgets_common/appbar.dart';

class AllUsersScreen extends StatefulWidget {
  const AllUsersScreen({super.key});

  @override
  State<AllUsersScreen> createState() => _AllUsersScreenState();
}

class _AllUsersScreenState extends State<AllUsersScreen> {

  var controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: 'All Users'
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder(
        stream: FireStoreServices.getAllUser(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
            
          } else if (snapshot.data!.docs.isEmpty){
            return Center(
              child: Column(
                children: [
                  const Icon(Icons.close, color: highEmphasis, size: 120,),
                  "No users registered yet!".text.size(20).color(darkFontGrey).make(),
                ],
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index){
                return ListTile(
                    leading: data[index]['imageUrl'] == '' ? Image.asset(icUser,fit: BoxFit.cover,height: 50,width: 50, color: fontGrey,).box.clip(Clip.antiAlias).roundedFull.border(color: whiteColor, width: 2).white.shadow3xl.make() 
                          : Image.network(data[index]['imageUrl'],fit: BoxFit.cover,height: 50,width: 50).box.clip(Clip.antiAlias).roundedFull.white.shadow3xl.make(),
                    title: '${data[index]['name']}'.text.size(18).color(highEmphasis).make(),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        '${data[index]['email']}'.text.size(16).color(fontGrey).make(),
                        '${data[index]['role']}'.text.size(16).color(data[index]['role'] == 'admin' ? primary : Colors.green).make(),
                      ],
                    ),
                    trailing: const Icon(Icons.more_vert_rounded).onTap(() {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Change Users Role"),
                            content: const Text("Are you sure you want to change this users role?"),
                            actions: [
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              TextButton(
                                child: const Text("Confirm"),
                                onPressed: () {
                                  data[index]['role'] == 'admin' ? controller.editRoleAsUser(data[index].id) : controller.editRoleAsAdmin(data[index].id);
                                  VxToast.show(context, msg: "Users role Changed");
                                  Get.back();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }),
                );
              }
            );
          }
        }
      )
      ),
    );
  }
}