import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/view/screens/Agent/agentProfile.dart';
import 'package:housingapp/view/screens/Builder/MyProperties.dart';
import 'package:housingapp/view/screens/Builder/UploadProperties.dart';
import 'package:housingapp/view/screens/Builder/agent_list.dart';
import 'package:housingapp/view/screens/Builder/builder_connections.dart';
import 'package:housingapp/view/screens/admin/adminAgentscreen.dart';
import 'package:housingapp/view/screens/admin/adminBuilderscreen.dart';
import 'package:housingapp/view/screens/admin/logoutscreen.dart';
import 'package:image_picker/image_picker.dart';
import 'controllers/auth_controller.dart';
import 'package:housingapp/view/screens/Agent/agnet_dashboard.dart';
import 'package:housingapp/view/screens/Agent/builder_list.dart';
import 'package:housingapp/view/screens/Agent/lead_registration.dart';
import 'package:housingapp/view/screens/Agent/leads_list.dart';

List pages = [
  BuilderPropertyPage(),
  AgentInformation(),
  //BuilderInformation(),
  //AddProperty(),
  UploadForm(),
  BuilderConnectionScreen(),
  Text('Manage Projects'),
//  GetUserName()
];

List agentpages = [
//  BuilderDetailScreen(),
  AgentDashboard(),
  BuilderInformation(),
  Leadregistration(),
  Leadslist(),
  Agentprofile(),
];

List adminpages = [
  AdminBuilderScreen(),
  AdminAgentScreen(),
  AdminLogoutScreen()
];

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
var buttonColor2 = Color(0xFF660196);
const borderColor = Colors.grey;
const textColor = Color(0xFF0934CD);
var authController = AuthController.instance;

Future<List<XFile>> pickImage() async {
  List<XFile>? _images = await ImagePicker().pickMultiImage();
  if (_images != null && _images.isNotEmpty) {
    return _images;
  }
  return [];
}

String getImageName(XFile image) {
  return image.path.split("/").last;
}

Future<String> uploadOneImage(
    XFile image, String childd, String name, String ph) async {
  Reference db = firebaseStorage.ref().child(childd).child(
      '${name} ${ph} ${FirebaseAuth.instance.currentUser!.uid} ${getImageName(image)}');
  print(getImageName(image));
  await db.putFile(File(image.path));
  return db.getDownloadURL();
}

Future<List<String>> multiImageUpload(
    List<XFile> list, String child, String name, String ph) async {
  List<String> _path = [];

  for (XFile _images in list) {
    _path.add(await uploadOneImage(_images, child, name, ph));
  }
  return _path;
}
