
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/view/screens/Agent/BuilderDetailPage.dart';

import '../../widgets/resuable_cards.dart';

class BuilderInformation extends StatefulWidget {
  @override
  _BuilderInformationState createState() => _BuilderInformationState();
}

class _BuilderInformationState extends State<BuilderInformation> {
  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('builder').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(1.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => BuilderDetailScreen(data: data,)));
                  },
                  child: ReusableDetailcard(
                      profile: data['profilePhoto'],
                      fullname: data['name'],
                      ph_no: "${data['ph_no']}",
                      email: "${data['email']}"),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
