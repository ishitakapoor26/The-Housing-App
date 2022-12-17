import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:housingapp/view/screens/Landing_screen.dart';
import 'package:housingapp/view/widgets/snackBar.dart';
import 'package:housingapp/view/widgets/valid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import '../../../../constant.dart';
import '../widgets/banner.dart';
import '../widgets/text_input_field.dart';
import 'agent_login.dart';

enum TypeOfAgent { institution, individual }

TypeOfAgent _typeOfAgent = TypeOfAgent.individual;

class AgentSignupScreenExtended extends StatefulWidget {
  AgentSignupScreenExtended(
      {required this.agentId,
      required this.phone,
      required this.username,
      Key? key})
      : super(key: key);
  late String agentId;
  late String username;
  late String phone;
  @override
  State<AgentSignupScreenExtended> createState() =>
      _AgentSignupScreenExtendedState();
}

class _AgentSignupScreenExtendedState extends State<AgentSignupScreenExtended> {
  bool isLoading = false;
  bool _isBraiChecked = false;
  int percent = 0;
  bool _isCreoChecked = false;
  String? focusarea;
  List<String> associations = ["BRAI", "CREA"];
  final TextEditingController _companyAddController = TextEditingController();
  final TextEditingController _companyWebController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyPANController = TextEditingController();
  final TextEditingController _rera_noController = TextEditingController();
  final TextEditingController _individualPANController =
      TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _companyReraNoController =
      TextEditingController();

  // GlobalKey _globalKey = Form();
  final _globalKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _companyAddController.dispose();
    _companyPANController.dispose();
    _rera_noController.dispose();
    _companyWebController.dispose();
    _companyReraNoController.dispose();
    _companyNameController.dispose();
    _individualPANController.dispose();
    _experienceController.dispose();
  }

  @override
  void initState() {
    super.initState();
    panmultiImages = null;
    panpickedimages = null;
    percent = 0;
    isLoading = false;
    reramultiImages = null;
    rerapickedimages = null;
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
                    // Stack(
                    //   children: [
                    //     const CircleAvatar(
                    //       radius: 64,
                    //       // backgroundImage: NetworkImage(
                    //       //   'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'),
                    //       backgroundColor: Colors.white,
                    //       child: Icon(
                    //         Icons.person,
                    //         size: 100,
                    //       ),
                    //     ),
                    //     Positioned(
                    //       bottom: -10,
                    //       left: 80,
                    //       child: IconButton(
                    //         onPressed: () async {
                    //           authController.pickImage();
                    //         },
                    //         icon: const Icon(
                    //           Icons.add_a_photo,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 15,
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 18.0, right: 18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Text("Are you an :"),
                          ListTile(
                            title: Text("Individual"),
                            leading: Radio<TypeOfAgent>(
                                value: TypeOfAgent.individual,
                                groupValue: _typeOfAgent,
                                onChanged: (v) {
                                  setState(() {
                                    _typeOfAgent = v!;
                                  });
                                }),
                          ),
                          ListTile(
                            title: Text("Institution"),
                            leading: Radio<TypeOfAgent>(
                                value: TypeOfAgent.institution,
                                groupValue: _typeOfAgent,
                                onChanged: (v) {
                                  setState(() {
                                    _typeOfAgent = v!;
                                  });
                                }),
                          ),
                          Visibility(
                            visible: _typeOfAgent == TypeOfAgent.institution,
                            child: Column(
                              children: [
                                CustomTextInput(
                                    prefixIcon: Image.asset(
                                      "assets/vectors/user.png",
                                      height: 10.0,
                                      width: 30,
                                    ),
                                    controller: _companyNameController,
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return "Company Name Not Valid";
                                      }
                                    },
                                    obscureText: false,
                                    hintTtext: "Company Name"),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextInput(
                                    prefixIcon: Image.asset(
                                      "assets/vectors/mail.png",
                                      height: 10.0,
                                      width: 30,
                                    ),
                                    controller: _companyAddController,
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return "Company Address Not Valid";
                                      }
                                    },
                                    obscureText: false,
                                    hintTtext: "Company Address"),
                                const SizedBox(
                                  height: 15,
                                ),
                                CustomTextInput(
                                    prefixIcon: Image.asset(
                                      "assets/vectors/mail.png",
                                      height: 10.0,
                                      width: 30,
                                    ),
                                    controller: _companyWebController,
                                    validator: (v) {
                                      if (v!.isEmpty) {
                                        return "Company Website Not Valid";
                                      }
                                    },
                                    obscureText: false,
                                    hintTtext: "Company Website"),
                                const SizedBox(
                                  height: 15,
                                ),
                                // CustomTextInput(
                                //     prefixIcon: Image.asset(
                                //       "assets/vectors/mail.png",
                                //       height: 10.0,
                                //       width: 30,
                                //     ),
                                //     controller: _companyPANController,
                                //     validator: (v) {
                                //       if (v!.isEmpty) {
                                //         return "Company PAN Not Valid";
                                //       }
                                //     },
                                //     obscureText: false,
                                //     hintTtext: "Company PAN"),
                                SelectRera(),
                                const SizedBox(
                                  height: 15,
                                ),
                                SelectPAN()
                                // CustomTextInput(
                                //     prefixIcon: const Icon(Icons.security),
                                //     controller: _companyReraNoController,
                                //     validator: (v) {
                                //       if (v!.isEmpty) {
                                //         return "Company Rera cannot be empty";
                                //       }
                                //     },
                                //     obscureText: false,
                                //     hintTtext: "Company Rera No"),
                              ],
                            ),
                          ),
                          Visibility(
                              visible: _typeOfAgent == TypeOfAgent.individual,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CustomTextInput(
                                      prefixIcon: const Icon(Icons.security),
                                      controller: _experienceController,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return "Experience can not be empty";
                                        }
                                        if (v.contains(RegExp("[a-z]"))) {
                                          return "Experience cannot letters";
                                        }
                                        if (v.contains(RegExp("[A-Z]"))) {
                                          return "Experience cannot letters";
                                        }
                                      },
                                      obscureText: false,
                                      hintTtext: "Years Of Experience"),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  // CustomTextInput(
                                  //     prefixIcon: Image.asset(
                                  //       "assets/vectors/mail.png",
                                  //       height: 10.0,
                                  //       width: 30,
                                  //     ),
                                  //     controller: _individualPANController,
                                  //     validator: (v) {
                                  //       if (v!.isEmpty) return "PAN Not Valid";
                                  //     },
                                  //     obscureText: false,
                                  //     hintTtext: "PAN Number"),
                                  SelectRera(),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  SelectPAN(),
                                ],
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextInput(
                              prefixIcon: const Icon(Icons.security),
                              controller: _rera_noController,
                              validator: (v) {
                                // if (!isEmailValid(v!)) return "Email Not Valid";
                                // if ((v!.contains(RegExp(
                                //         r'^(?:[+0][1-9])?[0-9]{10,12}$'))) ||
                                //     v.length != 10) {
                                //   return "Phone Number not valid";
                                // }
                                if (v!.isEmpty) return "Rera cannot be empty";
                              },
                              obscureText: false,
                              hintTtext: "Rera No"),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              autofocus: true,
                              borderRadius: BorderRadius.circular(30),
                              elevation: 5,
                              dropdownColor: Colors.blue[50],
                              focusColor: Colors.white,
                              value: focusarea,
                              //elevation: 5,
                              style: const TextStyle(color: Colors.white),
                              iconEnabledColor: Colors.black,
                              items: <String>[
                                'Bangalore East',
                                'Bangalore West',
                                'Bangalore North',
                                'Bangalore South'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                );
                              }).toList(),
                              hint: const Text(
                                "Focus Area",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  focusarea = value!;
                                });
                              },
                            ),
                          ),
                          Column(
                            children: [
                              CheckboxListTile(
                                title: Text("BRAI"),
                                value: _isBraiChecked,
                                onChanged: (val) {
                                  setState(() {
                                    _isBraiChecked = val!;
                                  });
                                },
                              ),
                              CheckboxListTile(
                                title: Text("CREA"),
                                value: _isCreoChecked,
                                onChanged: (val) {
                                  setState(() {
                                    _isCreoChecked = val!;
                                  });
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    isLoading
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
                              if (_typeOfAgent == TypeOfAgent.individual) {
                                if (rerapickedimages == null) {
                                  showSnackBar(
                                      context, "Rera Image not uploaded");
                                  return;
                                }
                                if (panpickedimages == null) {
                                  showSnackBar(
                                      context, "PAN Image not uploaded");
                                  return;
                                }
                              } else if (_typeOfAgent ==
                                  TypeOfAgent.institution) {
                                if (rerapickedimages == null) {
                                  showSnackBar(
                                      context, "Rera Image not uploaded");
                                  return;
                                }
                                if (panpickedimages == null) {
                                  showSnackBar(
                                      context, "PAN Image not uploaded");
                                  return;
                                }
                              }
                              if (_globalKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                  percent = 20;
                                });
                                reramultiImages = await multiImageUpload(
                                  rerapickedimages!,
                                  "Agent Rera",
                                  widget.username,
                                  widget.phone,
                                );
                                setState(() {
                                  percent = 50;
                                });
                                panmultiImages = await multiImageUpload(
                                  panpickedimages!,
                                  "Agent PAN",
                                  widget.username,
                                  widget.phone,
                                );
                                setState(() {
                                  percent = 70;
                                });
                                List<String>? associations;
                                if (_isBraiChecked) {
                                  if (_isCreoChecked) {
                                    associations = ['BRAI', "CREA"];
                                  } else {
                                    associations = ['BRAI'];
                                  }
                                }
                                response = await authController
                                    .register_agent_advanced(
                                        widget.agentId,
                                        _rera_noController.text,
                                        reramultiImages![0],
                                        _experienceController.text,
                                        _typeOfAgent == TypeOfAgent.individual
                                            ? "individual"
                                            : "institution",
                                        _companyNameController.text,
                                        _companyAddController.text,
                                        _companyWebController.text,
                                        // _companyPANController.text,
                                        panmultiImages![0],
                                        focusarea,
                                        associations,
                                        context);
                                setState(() {
                                  percent = 90;
                                });

                                if (response.isEmpty ||
                                    response.contains("Error")) {
                                  showSnackBar(
                                      context, "Some error occured. Try again");

                                  // ScaffoldMessenger.of(context)
                                  //     // ..removeCurrentMaterialBanner()
                                  //     .showMaterialBanner(showMaterialBanner(
                                  //         context,
                                  //         "Some error occured. Try again",
                                  //         "error"));
                                  // await Future.delayed(Duration(seconds: 3));
                                  // ScaffoldMessenger.of(context)
                                  //     .removeCurrentMaterialBanner();
                                  return;
                                }
                                await Future.delayed(Duration(seconds: 1));
                                setState(() {
                                  isLoading = false;
                                  percent = 100;
                                });

                                showSnackBar(context,
                                    "Account Created Succusfully. You can login once you are verified.");

                                // ScaffoldMessenger.of(context)
                                //     .showMaterialBanner(showMaterialBanner(
                                //         context,
                                //         "Account Created Succusfully. You can login once you are verified.",
                                //         "success"));
                                Navigator.popUntil(context,
                                    ModalRoute.withName('landingscreen'));

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginAgentScreen()));
                                // await Future.delayed(Duration(seconds: 3));
                                // ScaffoldMessenger.of(context)
                                //     .removeCurrentMaterialBanner();
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

class SelectPAN extends StatefulWidget {
  @override
  State<SelectPAN> createState() => _SelectPANState();
}

List<String>? panmultiImages;
List<XFile>? panpickedimages;

class _SelectPANState extends State<SelectPAN> {
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
                panpickedimages = await pickImage();
                // images= pickedimages;
                if (panpickedimages != null && panpickedimages!.isNotEmpty) {
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
                        const Text('Upload PAN'),
                      ],
                    )),
              ),
            ),
            panpickedimages != null
                ? Wrap(
                    children: panpickedimages!
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

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    Key? key,
    required TextEditingController controller,
    required String hintTtext,
    required bool obscureText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    required String? Function(String?) validator,
  })  : _controller = controller,
        _text = hintTtext,
        _validator = validator,
        _obscureText = obscureText,
        _prefixIcon = prefixIcon,
        _suffixIcon = suffixIcon,
        super(key: key);

  final TextEditingController _controller;
  final String _text;
  final bool _obscureText;
  final Widget? _prefixIcon;
  final Widget? _suffixIcon;
  final String? Function(String?) _validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: _validator,
      obscureText: _obscureText,
      controller: _controller,
      decoration: InputDecoration(
          hintText: _text,
          filled: true,
          fillColor: Colors.grey[300],
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          prefixIcon: _prefixIcon,
          suffixIcon: _suffixIcon),
    );
  }
}
