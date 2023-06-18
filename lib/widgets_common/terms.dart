// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';


class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Terms & Conditions")),
      body: StreamBuilder(
        stream: firestore.collection('t&c').where('id', isEqualTo: 'termsandconditions').snapshots(),
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
