import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constant.dart';
import '../Landing_screen.dart';

class AdminLogoutScreen extends StatefulWidget {
  const AdminLogoutScreen({Key? key}) : super(key: key);

  @override
  State<AdminLogoutScreen> createState() => _AdminLogoutScreenState();
}

class _AdminLogoutScreenState extends State<AdminLogoutScreen> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
     // bottomSheet: Bottomsheet(),
      body: Center(child:    MaterialButton(
          child: const Text("Sign Out"),
          onPressed: () {
            authController.signOut();
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LandingScreen()));
           // Navigator.popUntil(context, ModalRoute.withName('landingscreen'));
          }),)
    );
  }
}

