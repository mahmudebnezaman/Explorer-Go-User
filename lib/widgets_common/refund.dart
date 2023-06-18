// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explorergocustomer/consts/consts.dart';
import 'package:explorergocustomer/consts/loading_indicator.dart';


class RefundScreen extends StatefulWidget {
  const RefundScreen({Key? key}) : super(key: key);

  @override
  _RefundScreenState createState() => _RefundScreenState();
}

class _RefundScreenState extends State<RefundScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Refund & cancellation")),
      body: StreamBuilder(
        stream: firestore.collection('t&c').where('id', isEqualTo: 'refund&cancellation').snapshots(),
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
