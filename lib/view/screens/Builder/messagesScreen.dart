import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessagesScreen extends StatelessWidget {
   MessagesScreen({Key? key}) : super(key: key);
  final Stream<DocumentSnapshot<Map<String, dynamic>>> builder =
      FirebaseFirestore.instance
          .collection('builder')
          .doc(FirebaseAuth.instance.currentUser!.uid).collection("chats").doc("") 
          .snapshots();

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Message"));
  }
}
