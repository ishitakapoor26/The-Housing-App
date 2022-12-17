import 'package:flutter/material.dart';
import 'package:housingapp/view/auth/agent_login.dart';
import 'package:housingapp/view/auth/adminloginscreen.dart';
import '../../../constant.dart';
import '../auth/builder_login.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                // onSecondaryLongPressEnd: (LongPressEndDetails k){
                //   Navigator.of(context).push(
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               AdminScreen())
                //   );
                // },
                onLongPressEnd: (LongPressEndDetails k) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AdminLoginScreen()));
                },
                child: Text(
                  'Housing App',
                  style: TextStyle(
                    fontSize: 35,
                    color: buttonColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 3,
                  height: 60,
                  decoration: BoxDecoration(
                    color: textColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              //    MyNavigationBar(),
                              LoginBuilderScreen()
                          // BuilderLoginScreen(),
                          ),
                    ),
                    child: const Center(
                      child: Text(
                        'Builder',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: textColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) =>
                              //  IamAgent()
                              LoginAgentScreen()
                          // AgentLoginScreen(),
                          ),
                    ),
                    child: const Center(
                      child: Text(
                        'Channel Partner',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
              const SizedBox(
                width: 35,
              ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             const Text(
              //               'Don\'t have an account? ',
              //               style: TextStyle(
              //                 fontSize: 20,
              //               ),
              //             ),
              //             InkWell(
              //               onTap: () {
              // },
              //
              //               child: Text(
              //                 'Register',
              //                 style: TextStyle(fontSize: 20, color: buttonColor),
              //               ),
              //             ),
              //           ],
              //         ),
            ],
          ),
          SizedBox(
            height: 30,
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
    );
  }
}
