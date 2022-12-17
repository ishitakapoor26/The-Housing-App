import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:housingapp/view/screens/Builder/builder_landingPage.dart';
import 'package:housingapp/constant.dart';
import 'package:housingapp/view/auth/builder_signup.dart';
import '../screens/Builder/UploadProperties.dart';
import '../../controllers/auth_methods.dart';
import '../widgets/text_input_field.dart';
import 'package:housingapp/view/widgets/snackBar.dart';

class LoginBuilderScreen extends StatefulWidget {
  const LoginBuilderScreen({Key? key}) : super(key: key);

  @override
  _LoginBuilderScreenState createState() => _LoginBuilderScreenState();
}

class _LoginBuilderScreenState extends State<LoginBuilderScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

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
    if (!isEmailValid(_emailController.text)) {
      showSnackBar(context, "Email not valid");
      return;
    }
    // else
    if (_passwordController.text.isEmpty) {
      showSnackBar(context, "Enter valid password");
      return;
    }
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      // Navigator.pop(context);

      Navigator.popUntil(context, ModalRoute.withName('landingscreen'));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => IamBuilder()),
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

  bool _buttonPressed = true;
  bool _showPass = false;
  // void buttonPressed() {
  //   print(_emailController.text);
  //   if (isEmailValid(_emailController.text)) {
  //     setState(() {
  //       // _emailPressed = true;
  //       _buttonPressed = false;
  //     });
  //     return;
  //   }
  // if (isMobileNumberValid(_emailController.text)) {
  //   print(_emailController.text);
  //   _numberController.verifyPhoneNumber(_emailController.text);
  //   setState(() {
  //     _phonePressed = true;
  //     _buttonPressed = false;
  //   });
  // }
  // }

  bool isEmailValid(String email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                  Column(children: [
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
                      height: 8,
                    ),
                    const Text(
                      "Forgot Password",
                      style: const TextStyle(
                        fontSize: 12,
                        color: textColor,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Container(
                            child: !_isLoading
                                ? const Text(
                                    'Log in',
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Center(
                                  child: const CircularProgressIndicator(
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
                          onTap: loginUser,
                        ),
                      ],
                    ),
                  ]),
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
                  //               Navigator.of(context).pushReplacement(
                  //                 MaterialPageRoute(
                  //                     builder: (context) => const IamAgent()),
                  //               );
                  //             } catch (e) {
                  //               print("Not verified");
                  //             }
                  //           },
                  //           child: const Text("Verify OTP")),
                  //     ],
                  //   ),
                  // ),
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
                            builder: (context) => BuilderSignupScreen(),
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     resizeToAvoidBottomInset: false,
  //     body: SafeArea(
  //       child: Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 32),
  //         width: double.infinity,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Flexible(
  //               child: Container(),
  //               flex: 2,
  //             ),
  //             Text(
  //               'Housing App',
  //               style: TextStyle(
  //                 fontSize: 35,
  //                 color: buttonColor,
  //                 fontWeight: FontWeight.w900,
  //               ),
  //             ),
  //             const Text(
  //               'Builder Login',
  //               style: TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.w700,
  //               ),
  //             ),
  //             const SizedBox(height: 45),
  //             TextFieldInput(
  //               hintText: 'Enter your email',
  //               textInputType: TextInputType.emailAddress,
  //               textEditingController: _emailController,
  //               prefixIcon: const Icon(Icons.mail),
  //               suffixIcon: Image.asset(
  //                 "assets/vectors/eye.png",
  //                 height: 10.0,
  //                 width: 30,
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 24,
  //             ),
  //             TextFieldInput(
  //               hintText: 'Enter your password',
  //               textInputType: TextInputType.text,
  //               textEditingController: _passwordController,
  //               prefixIcon: Image.asset(
  //                 "assets/vectors/icon.png",
  //                 height: 10.0,
  //                 width: 30,
  //               ),
  //               suffixIcon: Image.asset(
  //                 "assets/vectors/eye.png",
  //                 height: 10.0,
  //                 width: 30,
  //               ),
  //               isPass: true,
  //             ),
  //             const SizedBox(
  //               height: 24,
  //             ),
  //             InkWell(
  //               child: Container(
  //                 child: !_isLoading
  //                     ? const Text(
  //                         'Log in',
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold, fontSize: 18),
  //                       )
  //                     : const CircularProgressIndicator(
  //                         color: Colors.white,
  //                       ),
  //                 width: double.infinity,
  //                 alignment: Alignment.center,
  //                 padding: const EdgeInsets.symmetric(vertical: 12),
  //                 decoration: ShapeDecoration(
  //                   shape: const RoundedRectangleBorder(
  //                     borderRadius: const BorderRadius.all(Radius.circular(4)),
  //                   ),
  //                   color: buttonColor,
  //                 ),
  //               ),
  //               onTap: loginUser,
  //             ),
  //             const SizedBox(
  //               height: 12,
  //             ),
  //             Flexible(
  //               child: Container(),
  //               flex: 2,
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Container(
  //                   child: const Text(
  //                     'Dont have an account?',
  //                   ),
  //                   padding: const EdgeInsets.symmetric(vertical: 8),
  //                 ),
  //                 GestureDetector(
  //                   onTap: () => Navigator.of(context).push(
  //                     MaterialPageRoute(
  //                       builder: (context) => BuilderSignupScreen(),
  //                     ),
  //                   ),
  //                   child: Container(
  //                     child: const Text(
  //                       ' Signup.',
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     padding: const EdgeInsets.symmetric(vertical: 8),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
