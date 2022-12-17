import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/constant.dart';
import 'package:housingapp/models/builder_Model.dart';
import 'package:housingapp/view/screens/Builder/edit_profile.dart';
import '../Landing_screen.dart';

class BuilderProfile extends StatefulWidget {
  BuilderModel? builder;

  BuilderProfile({this.builder, Key? key}) : super(key: key);
  @override
  State<BuilderProfile> createState() => _BuilderProfileState();
}

class _BuilderProfileState extends State<BuilderProfile> {
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
    if (widget.builder == null) {
      builder;
    }
  }

  //final String documentId;
  final Stream<DocumentSnapshot<Map<String, dynamic>>> builder =
      FirebaseFirestore.instance
          .collection('builder')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _reraNoController = TextEditingController();
  late BuilderModel _model;
  //GetUserName(@required this.documentId);
  
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // final Stream<QuerySnapshot> _usersStream =
    // FirebaseFirestore.instance.collection('builder').snapshots();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.black,
          actions: [
            Center(
                child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => BuilderProfileEdit(
                            builder: widget.builder == null
                                ? BuilderModel(
                                    name: _model.name,
                                    email: _model.email,
                                    ph_no: _model.ph_no,
                                    uid: _model.uid,
                                    rera_no: _model.rera_no,
                                    profilePhoto: _model.profilePhoto,
                                    company_name: _model.company_name,
                                    company_registration_no:
                                        _model.company_registration_no,
                                    company_add: _model.company_add,
                                    gst_invoice: _model.gst_invoice,
                                    city: _model.city,
                                    adhaar_photo: _model.adhaar_photo,
                                    rera_photo: _model.rera_photo,
                                    isAgent: _model.isAgent,
                                    isBuilder: _model.isBuilder,
                                    isVerified: _model.isVerified)
                                : widget.builder!,
                          )),
                );
              },
              child: const Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Edit',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20, decoration: TextDecoration.underline),
                ),
              ),
            ))
          ],
        ),
        body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: builder,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: const CircularProgressIndicator());
              }

              _nameController.text = snapshot.data!['name'];
              _emailController.text = snapshot.data!['email'];
              _phoneController.text = snapshot.data!['ph_no'];
              _companyNameController.text = snapshot.data!['company_name'];
              _reraNoController.text = snapshot.data!['rera_no'];
              _model = BuilderModel(
                  name: snapshot.data!['name'],
                  email: snapshot.data!['email'],
                  ph_no: snapshot.data!['ph_no'],
                  uid: snapshot.data!['uid'],
                  rera_no: snapshot.data!['rera_no'],
                  profilePhoto: snapshot.data!['profilePhoto'],
                  company_name: snapshot.data!['company_name'],
                  company_registration_no:
                      snapshot.data!['company_registration_no'],
                  company_add: snapshot.data!['company_add'],
                  gst_invoice: snapshot.data!['gst_invoice'],
                  city: snapshot.data!['city'],
                  adhaar_photo: snapshot.data!['adhaar_photo'],
                  rera_photo: snapshot.data!['rera_photo'],
                  isAgent: snapshot.data!['isAgent'],
                  isBuilder: snapshot.data!['isBuilder'],
                  isVerified: snapshot.data!['isVerified']);
              // _nameController.text = widget.builder!.name;
              // _emailController.text = widget.builder!.email;
              // _phoneController.text = widget.builder!.ph_no;
              // _companyNameController.text = widget.builder!.company_name;
              // _reraNoController.text = widget.builder!.rera_no;
              return SingleChildScrollView(
                  child: Stack(children: [
                SizedBox(
                  width: width,
                  child: Image.asset(
                    'assets/vectors/polygon.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      child: Image.asset(
                        'assets/vectors/rectangle1.png',
                        fit: BoxFit.contain,
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
                             const Text(
                                'Personal Details',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                             const Padding(
                                padding: EdgeInsets.only(top: 18.0),
                                child: Text(
                                  'Name',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                              TextField(
                                enabled: false,
                                controller: _nameController,
                              ),
                             const Padding(
                                padding: EdgeInsets.only(top: 18.0),
                                child: Text(
                                  'Email',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                              TextField(
                                enabled: false,
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                              ),
                             const Padding(
                                padding: EdgeInsets.only(top: 18.0),
                                child: Text(
                                  'Phone',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                              TextField(
                                enabled: false,
                                keyboardType: TextInputType.phone,
                                controller: _phoneController,
                              ),
                             const Padding(
                                padding: EdgeInsets.only(top: 30.0),
                                child: Text(
                                  'Company Details',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                             const Padding(
                                padding: EdgeInsets.only(top: 18.0),
                                child: Text(
                                  'Rera',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                              TextField(
                                enabled: false,
                                controller: _reraNoController,
                              ),
                             const Padding(
                                padding: EdgeInsets.only(top: 18.0),
                                child: Text(
                                  'Company',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18),
                                ),
                              ),
                              TextField(
                                enabled: false,
                                controller: _companyNameController,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.popUntil(
                            context, (Route<dynamic> route) => route.isFirst);
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => LandingScreen()),
                        );
                      },
                      child: Container(
                          width: 100,
                          margin: const EdgeInsets.only(bottom: 20),
                          height: 30,
                          decoration: BoxDecoration(
                              // color: Color.fromARGB(27,235, 23, 36),
                              // color: Color(0xEEEB1724),
                              // rgba(235, 23, 36, 0.27)
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:const [
                                Icon(
                                  Icons.logout_outlined,
                                  color: Color(0xFFFF0000),
                                ),
                                Text("Logout",
                                    style: TextStyle(
                                        color: Color(0xFFFF0000),
                                        decoration: TextDecoration.underline))
                              ])),
                    )
                  ],
                ),
              ]));
            }));
  }
}
