import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/view/screens/Builder/agent_page.dart';
import 'package:housingapp/view/screens/Builder/builderprofile.dart';

import '../../widgets/resuable_cards.dart';

class AgentInformation extends StatefulWidget {
  @override
  _AgentInformationState createState() => _AgentInformationState();
}

class _AgentInformationState extends State<AgentInformation> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('agent').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: AppBar(),
       appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => BuilderProfile()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.person),
                    Text('Profile'),
                    SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
            )
          ],
          backgroundColor: Colors.white,
          foregroundColor: Colors.redAccent,
          title: Text('Housing App'),
          centerTitle: true,
          //    leading: Icon(Icons.add,
          //  color: Colors.black,),
        ),
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
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AgentPageBuilder(
                        // profilePhoto = data['profilePhoto'],
                        name: data['name'],
                        phone: (data['ph_no']),
                        rera: data['rera_no'],
                        email: data['email'],
                        profilePhoto: data['profilePhoto'],
                      );
                    }));
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
