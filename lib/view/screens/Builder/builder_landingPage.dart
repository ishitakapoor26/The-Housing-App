import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/view/screens/Builder/MyProperties.dart';
import 'package:housingapp/view/screens/Builder/agent_list.dart';
import 'package:housingapp/view/screens/Builder/builder_connections.dart';
import 'package:housingapp/view/screens/Builder/builderprofile.dart';
import 'package:housingapp/models/builder_Model.dart';
import '../../../constant.dart';
import '../../widgets/custom_Icon.dart';
import '../Landing_screen.dart';
import 'UploadProperties.dart';

class IamBuilder extends StatefulWidget {
  IamBuilder({Key? key, this.currentPage}) : super(key: key);
  int? currentPage;
  @override
  _IamBuilderState createState() => _IamBuilderState();
}

class _IamBuilderState extends State<IamBuilder> {
  List pages = [
    BuilderPropertyPage(),
    AgentInformation(),
    //BuilderInformation(),
    //AddProperty(),
    UploadForm(),
    BuilderConnectionScreen(),
    // Text('Manage Projects'),
    BuilderProfile(
        // builder: BuilderModel.fromSnap(userDoc!))
        )
//  GetUserName()
  ];
  bool isVerified = false;
  DocumentSnapshot? userDoc;
  void is_Verified() async {
    userDoc = await firestore
        .collection('builder')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    bool check = (userDoc!.data()! as dynamic)['isVerified'];

    if (check) {
      setState(() {
        isVerified = check;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    is_Verified();
    if (widget.currentPage != null) {
      pageIdx = widget.currentPage!;
    }
  }

  int pageIdx = 0;
  showSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  DateTime? backbuttonpressedTime;
  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();
    bool backButton = backbuttonpressedTime == null ||
        currentTime.difference(backbuttonpressedTime!) > Duration(seconds: 3);
    if (backButton) {
      setState(() {
        backbuttonpressedTime = currentTime;
      });
      showSnackBar(
        context, "Double Click back button to exit app",
        // backgroundColor: Colors.black,
        // textColor: Colors.white
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            onTap: (value) {
              setState(() {
                pageIdx = value;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            currentIndex: pageIdx,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_work, size: 30),
                label: 'Properties',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people, size: 30),
                label: 'Agents',
              ),
              BottomNavigationBarItem(
                icon: CustomIcon(),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message, size: 30),
                label: 'Connection',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 30),
                label: 'Profile',
              ),
            ],
          ),
          body: isVerified == true
              ? SafeArea(
                  child: Center(
                    child: pages[pageIdx],
                  ),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'Verification is under process \n \t\t\t\t\t\t\t\t For more details \n \t\t\t\t\t\t\t\t contact Mr XYZ \n \t\t\t\t\t\t\t\t 6968569569 '),
                      MaterialButton(
                          child: Text("Go Back 👈"),
                          onPressed: () {
                            authController.signOut();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => LandingScreen()),
                            );
                            // Navigator.popUntil(
                            //     context, ModalRoute.withName('landingscreen'));
                          })
                    ],
                  ),
                )),
    );
  }
}
