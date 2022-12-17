import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/constant.dart';
import 'package:housingapp/models/builder_Model.dart';
import 'package:housingapp/view/screens/Builder/MyProperties.dart';
import 'package:housingapp/view/screens/Builder/builder_landingPage.dart';
import 'package:housingapp/view/screens/Builder/builderprofile.dart';
import '../Landing_screen.dart';

class BuilderProfileEdit extends StatefulWidget {
  BuilderModel? builder;

  BuilderProfileEdit({this.builder, Key? key}) : super(key: key);
  @override
  State<BuilderProfileEdit> createState() => _BuilderProfileState();
}

class _BuilderProfileState extends State<BuilderProfileEdit> {
  // Map<String, dynamic>? data;
  @override
  void initState() {
    super.initState();
    // FutureBuilder<DocumentSnapshot>(
    //     future: builder.get(),
    //     builder:
    //         (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    //       if (snapshot.hasError) {
    //         return const Text("Something went wrong");
    //       }

    //       if (snapshot.hasData && !snapshot.data!.exists) {
    //         return const Text("Document does not exist");
    //       }

    //       if (snapshot.connectionState == ConnectionState.done) {
    //         data = snapshot.data!.data() as Map<String, dynamic>;
    //         _nameController.text = data!['name'];
    //         _emailController.text = data!['email'];
    //       }
    //       return CircularProgressIndicator();
    //     });
    if (widget.builder != null) {
      _nameController.text = widget.builder!.name;
      _emailController.text = widget.builder!.email;
      _phoneController.text = widget.builder!.ph_no;
      _companyNameController.text = widget.builder!.company_name;
      _reraNoController.text = widget.builder!.rera_no;
    }
  }

  //final String documentId;
  DocumentReference<Map<String, dynamic>> builder = FirebaseFirestore.instance
      .collection('builder')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _reraNoController = TextEditingController();

  //GetUserName(@required this.documentId);
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.black,
          actions: [
            Center(
                child: GestureDetector(
              onTap: () {
                editProfile(
                    _nameController.text,
                    _emailController.text,
                    _phoneController.text,
                    _reraNoController.text,
                    _companyNameController.text,
                    widget.builder!);
                showSnackBar(context, "Edited");
                Navigator.pop(context);
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return IamBuilder(
                    currentPage: 4,
                  );
                }));
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Save',
                  style: TextStyle(
                      fontSize: 20, decoration: TextDecoration.underline),
                ),
              ),
            ))
          ],
        ),
        body: true
            ? SingleChildScrollView(
                child: Stack(children: [
                SizedBox(
                  width: width,
                  child: Container(
                    child: Image.asset(
                      'assets/vectors/polygon.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      child: Image.asset(
                        'assets/vectors/rectangle1.png',
                        fit: BoxFit.cover,
                      ),
                      width: width,
                    ),
                    Image.asset(
                      // 'assets/images/navigation/image 1.png',
                      'assets/vectors/profile.png',
                      width: 110,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: width - 40,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.0,
                              color: const Color.fromARGB(255, 224, 224, 224),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12.0)
                                    //                 <--- border radius here
                                    ),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Personal Details',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 18.0),
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                              TextField(
                                controller: _nameController,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 18.0),
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                              TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 18.0),
                                child: Text(
                                  'Phone',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                              TextField(
                                keyboardType: TextInputType.phone,
                                controller: _phoneController,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 30.0),
                                child: Text(
                                  'Company Details',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 18.0),
                                child: Text(
                                  'Rera',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                              TextField(
                                controller: _reraNoController,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 18.0),
                                child: Text(
                                  'Company',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                              TextField(
                                controller: _companyNameController,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ]))
            : CircularProgressIndicator());
  }

  void editProfile(String name, String email, String phone, String rera,
      String companyName, BuilderModel builderModel) async {
    BuilderModel builderModel1 = BuilderModel(
        name: name,
        email: email,
        ph_no: phone,
        uid: builderModel.uid,
        rera_no: rera,
        profilePhoto: builderModel.profilePhoto,
        company_name: companyName,
        company_registration_no: builderModel.company_registration_no,
        company_add: builderModel.company_add,
        gst_invoice: builderModel.gst_invoice,
        city: builderModel.city,
        adhaar_photo: builderModel.adhaar_photo,
        rera_photo: builderModel.rera_photo,
        isAgent: builderModel.isAgent,
        isBuilder: builderModel.isBuilder,
        isVerified: builderModel.isVerified);
    await firestore
        .collection('builder')
        .doc(builderModel.uid)
        .update(builderModel1.toJson());
    // .add(property.toJson());
  }

  showSnackBar(BuildContext context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
