// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';


class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  _PrivacyScreenState createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy")),
      body: StreamBuilder(
        stream: firestore.collection('t&c').where('id', isEqualTo: 'privacypolicy').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return Center(child: loadingIndicator());
          } else {
            var data = snapshot.data!.docs[0];
            return Padding(
              padding: const EdgeInsets.all(24),
              child: ListView(
                children: [
                  '${data['dtls']}'.text.size(15).justify.make()
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
