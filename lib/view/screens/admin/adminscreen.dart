import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constant.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  bool isAdm = false;

  void isAdmin() async {
    DocumentSnapshot userDoc = await firestore
        .collection('admin')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    bool check = (userDoc.data()! as dynamic)['isAdmin'];

    if (check) {
      setState(() {
        isAdm = check;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    isAdmin();

    return Scaffold(
      //  backgroundColor: Colors.black87,
      body: isAdm == true
          ? const AdminMainScreen()
          : SafeArea(
              child: Column(
              children: [
                const Text('No admin found'),
                MaterialButton(
                    child: const Text("Go Back 👈"),
                    onPressed: () {
                      authController.signOut();
                      Navigator.popUntil(
                          context, ModalRoute.withName('landingscreen'));
                    })
              ],
            )),
    );
  }
}

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({Key? key}) : super(key: key);

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int pageIdx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: Text('Housing App'),
      //   centerTitle: true,
      // ),
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
            label: 'Builder',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people, size: 30),
            label: 'Agents',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 30),
            label: 'Logout',
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: adminpages[pageIdx],
        ),
      ),
    );
  }
}
