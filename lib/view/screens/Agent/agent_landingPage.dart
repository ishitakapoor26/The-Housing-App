import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../constant.dart';

class IamAgent extends StatefulWidget {
  const IamAgent({Key? key}) : super(key: key);

  @override
  State<IamAgent> createState() => _IamAgentState();
}

class _IamAgentState extends State<IamAgent> {
  bool isVerified= false;
  void is_Verified() async {
    DocumentSnapshot userDoc = await firestore
        .collection('agent')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    bool check = (userDoc.data()! as dynamic)['isVerified'];

    if (check) {
      setState(() {
        isVerified = check;
      });
    }
  }
  int pageIdx = 0;
  @override
  Widget build(BuildContext context) {
    is_Verified();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Housing App'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            pageIdx = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: pageIdx,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_work, size: 30),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people, size: 30),
            label: 'Builder',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 30),
            label: 'Properties',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 30),
            label: 'Leads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30),
            label: 'Profile',
          ),
        ],
      ),
      body:isVerified==true?  SafeArea(
        child: Center(
          child: agentpages[pageIdx],
        ),
      ):Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Verification is under process \n \t\t\t\t\t\t\t\t For more details \n \t\t\t\t\t\t\t\t contact Mr Sri Harsha \n \t\t\t\t\t\t\t\t sriharshabr@gmail.com '),
            ElevatedButton(
                child: Text("Log Out "),
                onPressed: () {
                  authController.signOut();
                  Navigator.popUntil(
                      context, ModalRoute.withName('landingscreen'));
                })
          ],
        ),
      )

    );
  }
}
