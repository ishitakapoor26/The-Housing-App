import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:housingapp/view/auth/agent_signup2.dart';
import 'package:housingapp/view/widgets/snackBar.dart';
import 'package:housingapp/view/widgets/valid.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../constant.dart';
import '../widgets/text_input_field.dart';
import '../widgets/banner.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class AgentSignupScreen extends StatefulWidget {
  AgentSignupScreen({Key? key}) : super(key: key);

  @override
  State<AgentSignupScreen> createState() => _AgentSignupScreenState();
}

class _AgentSignupScreenState extends State<AgentSignupScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _renterPasswordController =
      TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _ph_noController = TextEditingController();

  final TextEditingController _rera_noController = TextEditingController();

  // GlobalKey _globalKey = Form();
  final _globalKey = GlobalKey<FormState>();
  File? _displayPicture;
  bool _isLoading = false;
  int percent = 0;
  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.camera_alt,
          color: buttonColor2,
        ),
        onPressed: () async {
          authController.pickImage();
        },
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Form(
                key: _globalKey,
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
                      'Agent Register',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    _displayPicture != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              _displayPicture!,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              await authController.pickImage();
                              setState(() {
                                _displayPicture =
                                    authController.pickedImage!.value;
                              });
                            },
                            child: Stack(
                              children: const [
                                CircleAvatar(
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
                                  child: Icon(
                                    Icons.add_a_photo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                      child: Column(
                        children: [
                          // TextFieldInput(
                          //   hintText: 'Username',
                          //   textInputType: TextInputType.text,
                          //   textEditingController: _usernameController,
                          //   isPass: true,
                          //   prefixIcon: Image.asset(
                          //     "assets/vectors/user.png",
                          //     height: 10.0,
                          //     width: 30,
                          //   ),
                          // ),
                          CustomTextInput(
                              prefixIcon: Image.asset(
                                "assets/vectors/user.png",
                                height: 10.0,
                                width: 30,
                              ),
                              controller: _usernameController,
                              validator: (v) {
                                if (v!.isEmpty) return "Username Not Valid";
                              },
                              obscureText: false,
                              hintTtext: "Username"),
                          const SizedBox(
                            height: 15,
                          ),
                          // TextFieldInput(
                          //   hintText: 'Email',
                          //   textInputType: TextInputType.text,
                          //   textEditingController: _emailController,
                          //   isPass: true,
                          //   prefixIcon: Image.asset(
                          //     "assets/vectors/mail.png",
                          //     height: 10.0,
                          //     width: 30,
                          //   ),
                          // ),
                          CustomTextInput(
                              prefixIcon: Image.asset(
                                "assets/vectors/mail.png",
                                height: 10.0,
                                width: 30,
                              ),
                              controller: _emailController,
                              validator: (v) {
                                if (!isEmailValid(v!)) return "Email Not Valid";
                              },
                              obscureText: false,
                              hintTtext: "Email"),

                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextInput(
                              prefixIcon: Image.asset(
                                "assets/vectors/icon.png",
                                height: 10.0,
                                width: 30,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  "assets/vectors/eye.png",
                                  height: 10.0,
                                  width: 30,
                                ),
                              ),
                              obscureText: true,
                              controller: _passwordController,
                              validator: (v) {
                                // if (!isEmailValid(v!)) return "Email Not Valid";
                                if ((v!.length < 8)) {
                                  return "Password must contain alteast 8 characters";
                                }
                                if (!(v.contains(RegExp("[0-9]")))) {
                                  return "Password must contain atleast one number";
                                }
                                if (!(v.contains(RegExp("[a-z]")))) {
                                  return "Password must contain atleast one small letter";
                                }
                                if (!(v.contains(RegExp("[A-Z]")))) {
                                  return "Password must contain atleast one capital letter";
                                }
                              },
                              hintTtext: "Enter your password"),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextInput(
                              prefixIcon: Image.asset(
                                "assets/vectors/icon.png",
                                height: 10.0,
                                width: 30,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  "assets/vectors/eye.png",
                                  height: 10.0,
                                  width: 30,
                                ),
                              ),
                              obscureText: true,
                              controller: _renterPasswordController,
                              validator: (v) {
                                // if (!isEmailValid(v!)) return "Email Not Valid";
                                if ((v! != _passwordController.text)) {
                                  return "Passwords so not match";
                                }
                              },
                              hintTtext: "Re enter your password"),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextInput(
                              prefixIcon: Image.asset(
                                "assets/vectors/call_calling.png",
                                height: 10.0,
                                width: 30,
                              ),
                              controller: _ph_noController,
                              validator: (v) {
                                // if (!isEmailValid(v!)) return "Email Not Valid";
                                if (!(v!.contains(RegExp(
                                        r'^(?:[+0][1-9])?[0-9]{10,12}$'))) ||
                                    v.length != 10) {
                                  return "Phone Number not valid";
                                }
                              },
                              obscureText: false,
                              hintTtext: "Phone"),
                          const SizedBox(
                            height: 15,
                          ),

                          // TextFieldInput(
                          //     hintText: 'Rera No',
                          //     textInputType: TextInputType.text,
                          //     textEditingController: _rera_noController,
                          //     isPass: true,
                          //     prefixIcon: const Icon(Icons.security)),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                    _isLoading
                        ? Center(
                            child: CircleAvatar(
                              radius: 40,
                              child: LiquidCircularProgressIndicator(
                                value: percent / 100,
                                valueColor: AlwaysStoppedAnimation(
                                    Color.fromARGB(255, 95, 125, 234)),
                                backgroundColor: Colors.white,
                                borderColor: Colors.black,
                                borderWidth: 0.8,
                                direction: Axis.vertical,
                                center: Text(percent.toString() + "%",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () async {
                              String response = "";
                              if(_displayPicture == null){
                                
                                  showSnackBar(context,
                                "Profile Picture is required");
                                return;
                              }
                              if (_globalKey.currentState!.validate()) {
                                setState(() {
                                  percent = 30;
                                  _isLoading = true;
                                });
                                response = await authController.register_agent(
                                    _usernameController.text,
                                    _emailController.text,
                                    _ph_noController.text,
                                    _passwordController.text,
                                    // _rera_noController.text,
                                    'bangalore',
                                    authController.profilePhoto,
                                    true,
                                    false,
                                    false,
                                    context) as String;
                                setState(() {
                                  percent = 80;
                                });
                                if (response.contains("Error")) {
                                  setState(() {
                                    // percent += 80;
                                    _isLoading = false;
                                  });
                                  showSnackBar(context,
                                      "Error in creating account. Please try again later");
                                  // ScaffoldMessenger.of(context).showMaterialBanner(
                                  //     showMaterialBanner(
                                  //         context,
                                  //         "Error in creating account. Please try again later",
                                  //         "error"));
                                  // await Future.delayed(Duration(seconds: 3));
                                  // ScaffoldMessenger.of(context)
                                  //     .removeCurrentMaterialBanner();
                                } else {
                                  await Future.delayed(Duration(seconds: 2));
                                  setState(() {
                                    percent = 100;
                                  });
                                  showSnackBar(context,
                                      "Account Created. Please fill in some extra details");

                                  // ScaffoldMessenger.of(context).showMaterialBanner(
                                  //     showMaterialBanner(
                                  //         context,
                                  //         "Account Created. Please fill in some extra details",
                                  //         "success"));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AgentSignupScreenExtended(
                                                  username:
                                                      _usernameController.text,
                                                  phone: _ph_noController.text,
                                                  agentId: response)));
                                  // await Future.delayed(Duration(seconds: 3));
                                  // ScaffoldMessenger.of(context)
                                  //     .removeCurrentMaterialBanner();
                                }
                              } else {
                                print("Not all feilds are done");
                              }
                            },
                            child: Container(
                              width: 200,
                              height: 60,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: ShapeDecoration(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                ),
                                color: buttonColor2,
                              ),
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ),
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
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFF8EAFCF),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(400),
                          topRight: Radius.circular(400))),
                  height: 400,
                  width: double.infinity,
                  // child: Image.asset(("assets/vectors/bubble2.gif")),
                  child: Column(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            "assets/vectors/building.png",
                            // height: 300,
                            // width: MediaQuery.of(context).size.width,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
