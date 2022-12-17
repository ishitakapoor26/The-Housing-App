import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:housingapp/controllers/phone_number_auth_controller.dart';
import 'package:housingapp/view/screens/Agent/agent_landingPage.dart';
import 'package:housingapp/view/auth/agent_signup.dart';
import '../../constant.dart';
import '../../controllers/auth_methods.dart';
import '../screens/Builder/UploadProperties.dart';
import '../widgets/snackBar.dart';
import '../widgets/text_input_field.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class LoginAgentScreen extends StatefulWidget {
  const LoginAgentScreen({Key? key}) : super(key: key);

  @override
  _LoginAgentScreenState createState() => _LoginAgentScreenState();
}

class _LoginAgentScreenState extends State<LoginAgentScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  bool _buttonPressed = true;
  bool _emailPressed = false;
  bool _phonePressed = false;
  PhoneNumberController _numberController = PhoneNumberController();
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const IamAgent()),
      );

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  void buttonPressed() {
    print(_emailController.text);
    if (isEmailValid(_emailController.text)) {
      setState(() {
        _emailPressed = true;
        _buttonPressed = false;
      });
      return;
    }
    if (isMobileNumberValid(_emailController.text)) {
      print(_emailController.text);
      _numberController.verifyPhoneNumber(_emailController.text);
      setState(() {
        _phonePressed = true;
        _buttonPressed = false;
      });
    }
  }

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  bool isMobileNumberValid(String phoneNumber) {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    var regExp = new RegExp(regexPattern);

    if (phoneNumber.length == 0) {
      return false;
    } else if (regExp.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Flexible(
                  //   child: Container(),
                  //   flex: 2,
                  // ),
                  const SizedBox(height: 30),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 35,
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Login To Continue",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 28),
                  TextFieldInput(
                    hintText: 'Enter your email',
                    textInputType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.mail_outline_outlined),
                    textEditingController: _emailController,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Visibility(
                  //   visible: _buttonPressed,
                  //   child: ElevatedButton(
                  //       child: const Text("Login"), onPressed: buttonPressed),
                  // ),
                  Visibility(
                    // visible: _emailPressed,
                    child: Column(children: [
                      TextFieldInput(
                        hintText: 'Enter your password',
                        textInputType: TextInputType.text,
                        textEditingController: _passwordController,
                        isPass: true,
                        prefixIcon: Image.asset(
                          "assets/vectors/icon.png",
                          height: 10.0,
                          width: 30,
                        ),
                        suffixIcon: Image.asset(
                          "assets/vectors/eye.png",
                          height: 10.0,
                          width: 30,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Forgot Password",
                            style: const TextStyle(
                              fontSize: 12,
                              color: textColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Container(
                              transformAlignment: Alignment.center,
                              child: !_isLoading
                                  ? const Text(
                                      'Log in',
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                              width: 100,
                              height: 50,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: const ShapeDecoration(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(40)),
                                ),
                                color: const Color(0xFF660196),
                              ),
                            ),
                            onTap: () {
                              if (isEmailValid(_emailController.text)) {
                                loginUser();
                              } else {
                                showSnackBar(
                                    context, "Email Address not valid");
                              }
                            },
                          ),
                        ],
                      ),
                    ]),
                  ),
                  Visibility(
                    // TODO : make it _phonePressed for OTP based
                    visible: false,
                    // visible: _phonePressed,
                    child: Column(
                      children: [
                        TextFieldInput(
                            textEditingController: _otpController,
                            hintText: "Enter OTP",
                            textInputType: TextInputType.number),
                        ElevatedButton(
                            onPressed: () async {
                              print(_otpController.text);
                              try {
                                await _numberController
                                    .verifyOTP(_otpController.text);
                                print("Verified");
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const IamAgent()),
                                );
                              } catch (e) {
                                print("Not verified");
                              }
                            },
                            child: const Text("Verify OTP")),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // TextFieldInput(
                  //     textEditingController: _phoneNumberController,
                  //     hintText: "Enter Phone Number",
                  //     textInputType: TextInputType.number),
                  // ElevatedButton(
                  //     onPressed: () {
                  //       print(_phoneNumberController.text);
                  //       _numberController
                  //           .verifyPhoneNumber(_phoneNumberController.text);
                  //     },
                  //     child: Text("Login Using OTP")),
                  // Visibility(
                  //   visible: _phonePressed,
                  //   child: Column(
                  //     children: [
                  //       TextFieldInput(
                  //           textEditingController: _otpController,
                  //           hintText: "Enter OTP",
                  //           textInputType: TextInputType.number),
                  //       ElevatedButton(
                  //           onPressed: () async {
                  //             print(_otpController.text);
                  //             try {
                  //               await _numberController
                  //                   .verifyOTP(_otpController.text);
                  //               print("Verified");
                  //             } catch (e) {
                  //               print("Not verified");
                  //             }
                  //           },
                  //           child: Text("Verify OTP")),
                  //     ],
                  //   ),
                  // ),
                  // Flexible(
                  //   child: Container(),
                  //   flex: 2,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text(
                          'New User?',
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AgentSignupScreen(),
                          ),
                        ),
                        child: Container(
                          child: const Text(
                            ' Create an Account',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: textColor),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Expanded(child: Container()),
            Expanded(
              child: Align(
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
