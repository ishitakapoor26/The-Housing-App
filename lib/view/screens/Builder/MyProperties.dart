import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/models/properties.dart';
import 'package:housingapp/view/screens/Builder/builderprofile.dart';
import 'package:housingapp/view/screens/Builder/type_property.dart';
import '../../../models/builder_Model.dart';
import 'PropertydetailScreen.dart';

class BuilderPropertyPage extends StatefulWidget {
  const BuilderPropertyPage({Key? key}) : super(key: key);

  @override
  State<BuilderPropertyPage> createState() => _BuilderPropertyPage();
}

class _BuilderPropertyPage extends State<BuilderPropertyPage> {
  Map<String, List> _properties = {};
  @override
  void initState() {
    super.initState();
    getProperties();
  }

  Future<Map<String, List>> getProperties() async {
    await usersStream.forEach((element) {
      for (var element1 in element.docs) {
        print(element1['projectname']);
        setState(() {
          // _properties[element1['projectname']]?.add(element1);
          if (_properties[element1['projectname']] == null) {
            _properties[element1['projectname']] = [];
          }
          _properties[element1['projectname']]!
              .add(Properties.fromSnap(element1));
        });
      }
    });
    print(_properties);
    return _properties;
  }

  final Stream<QuerySnapshot> usersStream = FirebaseFirestore.instance
      .collection('builder')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('properties')
      .orderBy("projectname")
      .snapshots();
  // int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    print(_properties);
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => BuilderProfile()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.person),
                  Text('Profile'),
                  SizedBox(
                    height: 8,
                  )
                ],
              ),
            ),
          )
        ],
        backgroundColor: Colors.white,
        foregroundColor: Colors.redAccent,
        title: Text('Housing App'),
        centerTitle: true,
        //    leading: Icon(Icons.add,
        //  color: Colors.black,),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 5, right: 5),
        child: StreamBuilder<QuerySnapshot>(
          stream: usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: _properties.length,
                itemBuilder: (context, index) {
                  return PropertiesCard(
                      context,
                        _properties[_properties.keys.toList()[index]]!,
                      _properties.keys.toList()[index],
                      _properties[_properties.keys.toList()[index]]![0]
                          .image[0]);
                });
            // return ListView(
            //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
            //     Map<String, dynamic> data =
            //         document.data()! as Map<String, dynamic>;
            //     //  final PropertyDetail propertyModel ;
            //     return Padding(
            //         padding:
            //             const EdgeInsets.only(right: 8.0, left: 8, bottom: 8),
            //         child: PropertiesCard(context, document, usersStream,
            //             data['image'][0], data['type'], data['projectname'])
            //         // DetailCard(
            //         // document: document,
            //         // usersStream: usersStream,
            //         // image: data['image'][0],
            //         // title: data['type'],
            //         // name: data['projectname'],
            //         // ),
            //         );
            //   }).toList(),
            // );
          },
        ),
      ),
    );
  }
}

// class DetailCard extends StatelessWidget {
//   const DetailCard({
//     Key? key,
//     required this.usersStream,
//     required this.image,
//     required this.title,
//     required this.name,
//     required this.document,
//   }) : super(key: key);
//   final Stream<QuerySnapshot> usersStream;
//   //final PropertyDetail propertyDetail;
//   final String image;
//   final String title;
//   final DocumentSnapshot document;
//   final String name;
//   @override
//   Widget build(BuildContext context) {
//     // var data = (FirebaseFirestore.instance.collection("builder").doc('MSCf9WszspWuvMwOAHQil378woC3').collection('poperties').docs('').get().data() as dynamic)['name'];

//     return GestureDetector(
//       onTap: () => Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => PropertyDetailScreen(
//                   document: document,
//                 )
//             //DetailsPage(propertyDetail: propertyDetail, usersStream: usersStream),
//             ),
//       ),
//       child: Container(
//         width: 200,
//         padding: const EdgeInsets.all(16),
//         margin: const EdgeInsets.only(right: 8),
//         decoration: BoxDecoration(
//           color: Colors.grey.withOpacity(0.15),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image(
//                 height: 120,
//                 width: double.infinity,
//                 image: NetworkImage(image),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(
//               height: 12,
//             ),
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: const Color(0xffE5CE6A),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Center(
//                 child: Text(
//                   name,
//                   style: Theme.of(context).textTheme.subtitle2,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 6,
//             ),
//             Text(
//               title,
//               style: Theme.of(context).textTheme.subtitle1!.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Text(
//               " 5 rooms - 2500 square foots - 2 floors",
//               style: Theme.of(context).textTheme.caption!.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PropertyListScreen extends StatelessWidget {
//   PropertyListScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Housing App'),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child: Image.asset(
//                 "assets/user.png",
//                 width: 35,
//               ),
//             )
//           ],
//         ),
//         body: Obx(() {
//           if (controller.isLoading.value) {
//             return const Center(
//                 child: CircularProgressIndicator(
//               color: AppColors.theme,
//             ));
//           } else {
//             return controller.propertyList.isEmpty
//                 ? const Center(
//                     child: Text(
//                     'Nothing to show here...',
//                     style: TextStyle(fontSize: 18),
//                   ))
//                 : Padding(
//                     padding: const EdgeInsets.only(top: 8.0),
//                     child: ListView.builder(
//                         itemCount: 1,
//                         itemBuilder: (context, index) {
//                           return PropertiesCard(context);
//                         }),
//                   );
//           }
//           // }));
//         }));
// //}
//   }
// }

PropertiesCard(context,listOfProperties, name, image) {
  double width = MediaQuery.of(context).size.width;

  return GestureDetector(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => TypeOfProperty(
                listOfProperties: listOfProperties,
              )
          //DetailsPage(propertyDetail: propertyDetail, usersStream: usersStream),
          ),
    ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
      child: SizedBox(
        width: width,
        height: 300,
        child: Stack(alignment: Alignment.center, children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: SizedBox(
                // Image radius
                child: Image.network(image, fit: BoxFit.cover),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: width - 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // backgroundColor: Colors.transparent,
                        color: Colors.yellow.withOpacity(0.55),
                        shape: BoxShape.rectangle,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            name,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(top: 8.0),
                  //   child: Text(
                  //     type,
                  //     style: TextStyle(fontSize: 20, color: Colors.white),
                  //   ),
                  // ),
                  // const Padding(
                  //   padding: EdgeInsets.only(top: 5.0),
                  //   child: Text(
                  //     '3 BHk/4BHK - 1500Sqft',
                  //     style: TextStyle(fontSize: 20, color: Colors.white),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ]),
      ),
    ),
  );
}
