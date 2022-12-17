import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:housingapp/view/screens/Builder/chatScreen.dart';
import 'package:housingapp/view/screens/Landing_screen.dart';
import 'controllers/auth_controller.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(MaterialApp(
    // home: ChatScreen(),
    home: const LandingScreen(),
    debugShowCheckedModeBanner: false,
    initialRoute: 'landingscreen',
    routes: {
      'landingscreen': (context) => LandingScreen(),
    },
  ),); // Authentication_screen()
}
