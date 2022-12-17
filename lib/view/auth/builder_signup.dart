import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/view/screens/Builder/UploadProperties.dart';
import 'package:housingapp/view/widgets/valid.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../constant.dart';
import '../widgets/text_input_field.dart';
import 'package:housingapp/view/widgets/snackBar.dart';

String city = 'Bangalore';

class BuilderSignupScreen extends StatefulWidget {
  BuilderSignupScreen({Key? key}) : super(key: key);

  @override
  State<BuilderSignupScreen> createState() => _BuilderSignupScreenState();
}

class _BuilderSignupScreenState extends State<BuilderSignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _ph_noController = TextEditingController();
  final TextEditingController _leadManagementController =
      TextEditingController();
  final TextEditingController _rera_noController = TextEditingController();
  final TextEditingController _c_nameController = TextEditingController();
  final TextEditingController _c_addController = TextEditingController();
  final TextEditingController _gst_invoiceController = TextEditingController();
  final TextEditingController _c_reg_noController = TextEditingController();
  bool _isLoading = false;
  bool checkForEmpty() {
    if (_emailController.text.isEmpty || !isEmailValid(_emailController.text)) {
      showSnackBar(context, "Email not valid");
      return false;
    }
    if (_passwordController.text.isEmpty) {
      showSnackBar(context, "Password not valid");
      return false;
    }
    if (_usernameController.text.isEmpty) {
      showSnackBar(context, "User name not valid");
      return false;
    }
    if (_ph_noController.text.isEmpty ||
        !isMobileNumberValid(_ph_noController.text)) {
      showSnackBar(context, "Phone Number not valid");
      return false;
    }
    if (_leadManagementController.text.isEmpty ||
        !isURLValid(_leadManagementController.text)) {
      showSnackBar(context, "Lead Management not valid ");
      return false;
    }
    if (_rera_noController.text.isEmpty) {
      showSnackBar(context, "Rera Number not valid");
      return false;
    }
    if (_c_nameController.text.isEmpty) {
      showSnackBar(context, "Company Name not valid");
      return false;
    }
    if (_c_addController.text.isEmpty) {
      showSnackBar(context, "Company Address not valid");
      return false;
    }
    if (_gst_invoiceController.text.isEmpty) {
      showSnackBar(context, "GST Number not valid");
      return false;
    }
    if (_c_reg_noController.text.isEmpty) {
      showSnackBar(context, "Company Reg Number not valid");
      return false;
    }
    if (rerapickedimages == null) {
      showSnackBar(context, "Rera Images Not found. Try Again.");
      return false;
    }
    if (adhaarpickedimages == null) {
      showSnackBar(context, "Aadhar Images Not found. Try Again.");
      return false;
    }
    if (authController.profilePhoto == null) {
      showSnackBar(context, "Profile Photo Not found. Try Again.");
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _c_addController.dispose();
    _c_nameController.dispose();
    super.dispose();
  }

  bool _showPass = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.white,
        //   child: Icon(
        //     Icons.camera_alt,
        //     color: buttonColor2,
        //   ),
        //   onPressed: () async {
        //     authController.pickImage();
        //   },
        // ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Housing App',
                style: TextStyle(
                  fontSize: 35,
                  color: buttonColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Text(
                'Builder Register',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 64,
                    // backgroundImage: NetworkImage(
                    //   'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 100,
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                      onPressed: () async {
                        authController.pickImage();
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                child: Column(
                  children: [
                    TextFieldInput(
                      hintText: 'Username',
                      textInputType: TextInputType.text,
                      textEditingController: _usernameController,
                      // isPass: true,
                      prefixIcon: Image.asset(
                        "assets/vectors/user.png",
                        height: 10.0,
                        width: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldInput(
                      hintText: 'Email',
                      textInputType: TextInputType.text,
                      textEditingController: _emailController,
                      // isPass: true,
                      prefixIcon: Image.asset(
                        "assets/vectors/mail.png",
                        height: 10.0,
                        width: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldInput(
                      hintText: 'Enter your password',
                      textInputType: TextInputType.text,
                      textEditingController: _passwordController,
                      isPass: !_showPass,
                      prefixIcon: Image.asset(
                        "assets/vectors/icon.png",
                        height: 10.0,
                        width: 30,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showPass = !_showPass;
                          });
                        },
                        child: Image.asset(
                          "assets/vectors/eye.png",
                          height: 10.0,
                          width: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldInput(
                      hintText: 'Phone',
                      textInputType: TextInputType.text,
                      textEditingController: _ph_noController,
                      // isPass: true,
                      prefixIcon: Image.asset(
                        "assets/vectors/call_calling.png",
                        height: 10.0,
                        width: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 50, left: 50.0),
                        child: CityButton()),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldInput(
                      hintText: 'Lead Management Link',
                      textInputType: TextInputType.text,
                      textEditingController: _leadManagementController,
                      // isPass: true,

                      prefixIcon: Image.asset(
                        "assets/vectors/lead_management.png",
                        height: 10.0,
                        width: 30,
                      ),
                    ),
                    SelectAdhaar(),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldInput(
                        hintText: 'Rera No',
                        textInputType: TextInputType.text,
                        textEditingController: _rera_noController,
                        // isPass: true,
                        prefixIcon: const Icon(Icons.security)),
                    const SizedBox(
                      height: 15,
                    ),
                    SelectRera(),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldInput(
                      hintText: 'Company Name',
                      textInputType: TextInputType.text,
                      textEditingController: _c_nameController,
                      // isPass: true,/
                      prefixIcon: Image.asset(
                        "assets/vectors/company_name.png",
                        height: 10.0,
                        width: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldInput(
                      hintText: 'Company Reg No',
                      textInputType: TextInputType.text,
                      textEditingController: _c_reg_noController,
                      // isPass: true,/
                      prefixIcon: Image.asset(
                        "assets/vectors/company_reg.png",
                        height: 10.0,
                        width: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldInput(
                      hintText: 'Company Address',
                      textInputType: TextInputType.text,
                      textEditingController: _c_addController,
                      // isPass: true,/
                      prefixIcon: Image.asset(
                        "assets/vectors/company_address.png",
                        height: 10.0,
                        width: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldInput(
                      hintText: 'GST Invoice',
                      textInputType: TextInputType.text,
                      textEditingController: _gst_invoiceController,
                      // isPass: true,/
                      prefixIcon: Image.asset(
                        "assets/vectors/gst.png",
                        height: 10.0,
                        width: 30,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () async {
                  if (!checkForEmpty()) {
                    // showSnackBar(context, "All Fields are not filled in");
                    return;
                  }
                  setState(() {
                    _isLoading = true;
                  });
                  reramultiImages = await multiImageUpload(
                    rerapickedimages!,
                    "Builder Rera",
                    _usernameController.text,
                    _ph_noController.text,
                  );
                  adhaarmultiImages = await multiImageUpload(
                    adhaarpickedimages!,
                    "Builder Adhaar",
                    _usernameController.text,
                    _ph_noController.text,
                  );
                  authController.register_builder(
                      _usernameController.text,
                      _emailController.text,
                      _ph_noController.text,
                      _passwordController.text,
                      _rera_noController.text,
                      authController.profilePhoto,
                      _c_nameController.text,
                      _c_reg_noController.text,
                      _c_addController.text,
                      _gst_invoiceController.text,
                      "Bangalore",
                      adhaarmultiImages!,
                      reramultiImages!,
                      false,
                      true,
                      false,
                      context);
                  setState(() {
                    _isLoading = false;
                  });
                  showSnackBar(context, 'Registeration Successful');
                  Navigator.pop(context);
                },
                child: Container(
                  width: 200,
                  height: 60,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: ShapeDecoration(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    color: buttonColor2,
                  ),
                  child: Center(
                    child: !_isLoading
                        ? Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          )
                        : CircularProgressIndicator(
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
              // InkWell(
              //   onTap: () async {
              //     setState(() {
              //       _isLoading = true;
              //     });
              //     reramultiImages = await multiImageUpload(
              //       rerapickedimages!,
              //       "Builder Rera",
              //       _usernameController.text,
              //       _ph_noController.text,
              //     );
              //     adhaarmultiImages = await multiImageUpload(
              //       adhaarpickedimages!,
              //       "Builder Adhaar",
              //       _usernameController.text,
              //       _ph_noController.text,
              //     );
              //     authController.register_builder(
              //         _usernameController.text,
              //         _emailController.text,
              //         _ph_noController.text,
              //         _passwordController.text,
              //         _rera_noController.text,
              //         authController.profilePhoto,
              //         _c_nameController.text,
              //         _c_reg_noController.text,
              //         _c_addController.text,
              //         _gst_invoiceController.text,
              //         "Bangalore",
              //         adhaarmultiImages!,
              //         reramultiImages!,
              //         false,
              //         true,
              //         false);
              //     setState(() {
              //       _isLoading = false;
              //     });
              //     showSnackBar(context, 'Registeration Successful');
              //     Navigator.pop(context);
              //   },
              //   child: Container(
              //     width: 200,
              //     height: 60,
              //     alignment: Alignment.center,
              //     padding: const EdgeInsets.symmetric(vertical: 12),
              //     decoration: ShapeDecoration(
              //       shape: const RoundedRectangleBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(40)),
              //       ),
              //       color: buttonColor2,
              //     ),
              //     child: const Text(
              //       'Register',
              //       style: TextStyle(
              //           fontSize: 20,
              //           fontWeight: FontWeight.w700,
              //           color: Colors.white),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   String city;
  //   return Scaffold(
  //     body: SafeArea(
  //       child: SingleChildScrollView(
  //         scrollDirection: Axis.vertical,
  //         child: Container(
  //           alignment: Alignment.center,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 'Housing App',
  //                 style: TextStyle(
  //                   fontSize: 35,
  //                   color: buttonColor,
  //                   fontWeight: FontWeight.w900,
  //                 ),
  //               ),
  //               const Text(
  //                 'Builder Register',
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   fontWeight: FontWeight.w700,
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 25,
  //               ),
  //               Stack(
  //                 children: [
  //                   const CircleAvatar(
  //                     radius: 64,
  //                     // backgroundImage: NetworkImage(
  //                     //   'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
  //                     backgroundColor: Colors.white,
  //                     child: Icon(
  //                       Icons.person,
  //                       size: 100,
  //                     ),
  //                   ),
  //                   Positioned(
  //                     bottom: -10,
  //                     left: 80,
  //                     child: IconButton(
  //                       onPressed: () => authController.pickImage(),
  //                       icon: const Icon(
  //                         Icons.add_a_photo,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 margin: const EdgeInsets.symmetric(horizontal: 20),
  //                 child: TextInputField(
  //                   controller: _usernameController,
  //                   labelText: 'Username',
  //                   icon: Icons.person,
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               //                     TextFieldInput(
  //               //                       hintText: 'Email',
  //               //                       textInputType: TextInputType.text,
  //               //                       textEditingController: _emailController,
  //               //                       isPass: true,
  //               //                       prefixIcon: Image.asset(
  //               //                         "assets/vectors/mail.png",
  //               //                         height: 10.0,
  //               //                         width: 30,
  //               //                       ),
  //               //                     ),
  //               Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 margin: const EdgeInsets.symmetric(horizontal: 20),
  //                 child: TextInputField(
  //                   controller: _emailController,
  //                   labelText: 'Email',
  //                   icon: Icons.email,
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 margin: const EdgeInsets.symmetric(horizontal: 20),
  //                 child: TextInputField(
  //                   controller: _passwordController,
  //                   labelText: 'Password',
  //                   icon: Icons.lock,
  //                   isObscure: true,
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 margin: const EdgeInsets.symmetric(horizontal: 20),
  //                 child: TextInputField(
  //                   controller: _ph_noController,
  //                   labelText: 'Phone',
  //                   icon: Icons.phone,
  //                   //     isObscure: true,
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               Padding(
  //                   padding: const EdgeInsets.only(right: 50, left: 50.0),
  //                   child: CityButton()),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               SelectAdhaar(),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 margin: const EdgeInsets.symmetric(horizontal: 20),
  //                 child: TextInputField(
  //                   controller: _rera_noController,
  //                   labelText: 'Rera No',
  //                   icon: Icons.security,
  //                   //  isObscure: true,
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               SelectRera(),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 margin: const EdgeInsets.symmetric(horizontal: 20),
  //                 child: TextInputField(
  //                   controller: _c_nameController,
  //                   labelText: 'Company Name',
  //                   icon: Icons.location_city,
  //                   //    isObscure: true,
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 margin: const EdgeInsets.symmetric(horizontal: 20),
  //                 child: TextInputField(
  //                   controller: _c_reg_noController,
  //                   labelText: 'Company Reg No',
  //                   icon: Icons.document_scanner,
  //                   //   isObscure: true,
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 margin: const EdgeInsets.symmetric(horizontal: 20),
  //                 child: TextInputField(
  //                   controller: _c_addController,
  //                   labelText: 'Company Add',
  //                   icon: Icons.navigation,
  //                   //      isObscure: true,
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               Container(
  //                 width: MediaQuery.of(context).size.width,
  //                 margin: const EdgeInsets.symmetric(horizontal: 20),
  //                 child: TextInputField(
  //                   controller: _gst_invoiceController,
  //                   labelText: 'Gst Invoice',
  //                   icon: Icons.file_copy,
  //                   //     isObscure: true,
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               Container(
  //                 width: MediaQuery.of(context).size.width - 40,
  //                 height: 50,
  //                 decoration: BoxDecoration(
  //                   color: buttonColor,
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(5),
  //                   ),
  //                 ),
  //                 child: InkWell(
  //                   onTap: () async {
  //                     setState(() {
  //                       _isLoading = true;
  //                     });
  //                     reramultiImages = await multiImageUpload(
  //                       rerapickedimages!,
  //                       "Builder Rera",
  //                       _usernameController.text,
  //                       _ph_noController.text,
  //                     );
  //                     adhaarmultiImages = await multiImageUpload(
  //                       adhaarpickedimages!,
  //                       "Builder Adhaar",
  //                       _usernameController.text,
  //                       _ph_noController.text,
  //                     );
  //                     authController.register_builder(
  //                         _usernameController.text,
  //                         _emailController.text,
  //                         _ph_noController.text,
  //                         _passwordController.text,
  //                         _rera_noController.text,
  //                         authController.profilePhoto,
  //                         _c_nameController.text,
  //                         _c_reg_noController.text,
  //                         _c_addController.text,
  //                         _gst_invoiceController.text,
  //                         "Bangalore",
  //                         adhaarmultiImages!,
  //                         reramultiImages!,
  //                         false,
  //                         true,
  //                         false);
  //                     setState(() {
  //                       _isLoading = false;
  //                     });
  //                     showSnackBar(context, 'Registeration Successful');
  //                     Navigator.pop(context);
  //                   },
  //                   child: Center(
  //                     child: !_isLoading
  //                         ? Text(
  //                             'Register',
  //                             style: TextStyle(
  //                               fontSize: 20,
  //                               fontWeight: FontWeight.w700,
  //                             ),
  //                           )
  //                         : CircularProgressIndicator(
  //                             color: Colors.white,
  //                           ),
  //                   ),
  //                 ),
  //               ),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   const Text(
  //                     'Already have an account? ',
  //                     style: TextStyle(
  //                       fontSize: 20,
  //                     ),
  //                   ),
  //                   InkWell(
  //                     onTap: () => Navigator.pop(context),
  //                     child: Text(
  //                       'Login',
  //                       style: TextStyle(fontSize: 20, color: buttonColor),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(
  //                 height: 15,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}

class CityButton extends StatefulWidget {
  const CityButton({Key? key}) : super(key: key);

  @override
  State<CityButton> createState() => _CityButtonState();
}

class _CityButtonState extends State<CityButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      autofocus: true,
      borderRadius: BorderRadius.circular(30),
      elevation: 5,
      dropdownColor: Colors.blue[50],
      focusColor: Colors.white,
      value: city,
      //elevation: 5,
      style: const TextStyle(color: Colors.white),
      iconEnabledColor: Colors.black,
      items:
          <String>['Bangalore'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      hint: const Text(
        "Select City",
        style: TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      onChanged: (String? value) {
        setState(() {
          city = value!;
        });
        // print(city);
      },
    );
  }
}

class SelectAdhaar extends StatefulWidget {
  @override
  State<SelectAdhaar> createState() => _SelectAdhaarState();
}

List<String>? adhaarmultiImages;
List<XFile>? adhaarpickedimages;

class _SelectAdhaarState extends State<SelectAdhaar> {
  List<String>? imageAddress;
  List<XFile>? images;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                adhaarpickedimages = await pickImage();
                // images= pickedimages;
                if (adhaarpickedimages != null &&
                    adhaarpickedimages!.isNotEmpty) {
                  // multiImages = await multiImageUploader(_images);
                  setState(() {});
                }
              },
              //   height: 20,
              child: DottedBorder(
                color: Color(0xFF674FF0), //color of dotted/dash line
                strokeWidth: 1, //thickness of dash/dots
                dashPattern: [15, 15],
                child: Container(
                    // padding: EdgeInsets.all(10),
                    height: 50,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        // color: Color(0xFFD9D9D940),

                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "assets/vectors/upload_rera.png",
                          // height: 10.0,
                          // width: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        // Spacer(),
                        const Text('Upload Adhaar (Both Sides)'),
                      ],
                    )),
              ),
            ),
            adhaarpickedimages != null
                ? Wrap(
                    children: adhaarpickedimages!
                        .map(
                          (e) => Image.file(
                            File(e.path),
                            height: 200,
                            width: 200,
                            //   width: 200,
                          ),
                        )
                        .toList(),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class SelectRera extends StatefulWidget {
  @override
  State<SelectRera> createState() => _SelectReraState();
}

List<String>? reramultiImages;
List<XFile>? rerapickedimages;

class _SelectReraState extends State<SelectRera> {
  List<String>? imageAddress;
  List<XFile>? images;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () async {
                rerapickedimages = await pickImage();
                // images= pickedimages;
                if (rerapickedimages != null && rerapickedimages!.isNotEmpty) {
                  // multiImages = await multiImageUploader(_images);
                  setState(() {});
                }
              },
              child: DottedBorder(
                color: Color(0xFF674FF0), //color of dotted/dash line
                radius: Radius.circular(10),
                strokeWidth: 1, //thickness of dash/dots
                dashPattern: [11, 15],
                child: Container(
                    // padding: EdgeInsets.all(10),
                    height: 50,
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        // color: Color(0xFFD9D9D940),
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "assets/vectors/upload_rera.png",
                          // height: 10.0,
                          // width: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        // Spacer(),
                        const Text('Upload Rera'),
                      ],
                    )),
              ),
            ),
            rerapickedimages != null
                ? Wrap(
                    children: rerapickedimages!
                        .map(
                          (e) => Image.file(
                            File(e.path),
                            height: 200,
                            width: 200,
                            //   width: 200,
                          ),
                        )
                        .toList(),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

// Future<List<XFile>> pickImage() async {
//   List<XFile>? _images = await ImagePicker().pickMultiImage();
//   if (_images != null && _images.isNotEmpty) {
//     return _images;
//   }
//   return [];
// }

