import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/constant.dart';
import '../Landing_screen.dart';

class Agentprofile extends StatelessWidget {
  //final String documentId;
  //static String id = 'gus';

  //GetUserName(@required this.documentId);

  @override
  Widget build(BuildContext context) {
    DocumentReference<Map<String, dynamic>> builder =
    FirebaseFirestore.instance.collection('agent').doc(FirebaseAuth.instance.currentUser!.uid);

    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            FutureBuilder<DocumentSnapshot>(
              future: builder.get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                }

                if (snapshot.hasData && !snapshot.data!.exists) {
                  return const Text("Document does not exist");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    //    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(data['profilePhoto']),
                      ),
                      const SizedBox(height: 50),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Full Name: ${data['name']}"),
                          const SizedBox(
                            height: 15,
                          ),
                          Text("Phone: ${data['ph_no']}"),
                          const SizedBox(
                            height: 15,
                          ),
                          Text("Email: ${data['email']}"),
                          const SizedBox(
                            height: 15,
                          ),
                          Text("Rera No: ${data['rera_no']}"),
                          const SizedBox(
                            height: 15,
                          ),
                         // Text("Company Name: ${data['company_name']}"),
                          const SizedBox(
                            height: 15,
                          ),
                          //Text("Company Reg No: ${data['company_registration_no']}"),
                          const SizedBox(
                            height: 15,
                          ),
                        //  Text("Company Address: ${data['company_add']}"),
                          const SizedBox(
                            height: 15,
                          ),
                          //Text("Gst: ${data['gst_invoice']}"),
                        ],
                      ),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
            MaterialButton(
                child: Text("Sign Out"),
                onPressed: () {
                  authController.signOut();

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LandingScreen()));
                  //    Navigator.popUntil(context, ModalRoute.withName('landingscreen'));
                })
          ],
        ),
      ),
    );
  }
}
