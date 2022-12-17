// import 'package:flutter/material.dart';
// import 'loginpage.dart';
// import 'registrationscreen.dart';
//
//
// class Authentication_screen extends StatelessWidget {
//   @override
//
//   Widget build(BuildContext context) {
//     final solgan = Padding(
//         padding: EdgeInsets.all(15.0),
//         child: Text(
//           'Get the Best Properties here',
//           style: TextStyle(
//               fontWeight: FontWeight.w400, color: Colors.brown, fontSize: 40.0),
//           textAlign: TextAlign.center,
//         ));
//
//     final registerButton = Padding(
//       padding: EdgeInsets.symmetric(vertical: 16.0),
//       child: SizedBox(
//         width: 150,
//         height: 40,
//         child: MaterialButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => RegistrationScreen()),
//            );
//           },
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(24),
//           ),
//           padding: EdgeInsets.all(12),
//           color: Colors.brown,
//           child: Text(
//             'Register now',
//             style: TextStyle(color: Colors.white, fontSize: 12.0),
//           ),
//         ),
//       ),
//     );
//     final agentbutton = Padding(
//         padding: EdgeInsets.symmetric(vertical: 16.0),
//         child: SizedBox(
//             height: 40,
//             width: 5,
//             child: MaterialButton(
//                 elevation: 100,
//                 hoverColor: Colors.brown,
//                 onPressed: () {
//
//                   // Navigator.push(context,MaterialPageRoute(builder: (context)=>AgentLandingPage()));
//                 },
//                 child: Stack(
//                   children: <Widget>[
//                     Align(
//                       alignment: Alignment.center,
//                       child: Text(
//                         "Login As a Agent or Builder",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.black),
//                       ),
//                     ),
//                   ],
//                 ),
//                 color: Colors.white,
//                 shape: new RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(24.0)
//                 )
//             ))
//     );
//     final loginbutton = Padding(
//       padding: EdgeInsets.symmetric(vertical: 16.0),
//       child: SizedBox(
//         width: 150,
//         height: 40,
//         child: MaterialButton(
//           onPressed: () {
//               Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => LoginScreen()),
//            );
//           },
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(24),
//           ),
//           padding: EdgeInsets.all(12),
//           color: Colors.brown,
//           child: Text(
//             'Login',
//             style: TextStyle(color: Colors.white, fontSize: 12.0),
//           ),
//         ),
//       ),
//     );
//
//     final phonebutton = Padding(
//         padding: EdgeInsets.symmetric(vertical: 16.0),
//         child: SizedBox(
//             height: 40,
//             width: 10,
//             child: MaterialButton(
//                 onPressed: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(builder: (context) => LoginWithPhone()),
//                   // );
//                 },
//                 child: Stack(
//                   children: <Widget>[
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Icon(Icons.mail, color: Colors.blue,),
//                     ),
//                     Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           "Login With Otp",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(color: Colors.blue),
//                         ),
//                     ),
//                   ],
//                 ),
//                 color: Colors.white,
//                 shape: new RoundedRectangleBorder(
//                     borderRadius: new BorderRadius.circular(24.0)
//                 )
//             ))
//     );
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // resizeToAvoidBottomPadding: false,
//       resizeToAvoidBottomInset: true,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Container(
//               height: MediaQuery
//                   .of(context)
//                   .size
//                   .height,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     height: MediaQuery
//                         .of(context)
//                         .size
//                         .height / 2,
//                     decoration: BoxDecoration(
//                       // image: DecorationImage(
//                       //     image: AssetImage("assets/img1.jpg"),
//                       //     fit: BoxFit.scaleDown),
//                     ),
//                   ),
//                   ListView(
//                     shrinkWrap: true,
//                     padding: EdgeInsets.only(right: 10.0, left: 10.0),
//                     children: <Widget>[
//                       solgan,
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: <Widget>[loginbutton, registerButton],
//                       ),
//                       phonebutton,
//                     agentbutton,
//
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
