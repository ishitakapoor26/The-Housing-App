import 'dart:math';

import 'package:flutter/material.dart';
import 'package:housingapp/models/properties.dart';
import 'package:housingapp/view/screens/Builder/PropertydetailScreen.dart';
import 'package:housingapp/view/screens/Builder/builderprofile.dart';
import 'package:housingapp/view/widgets/snackBar.dart';

class TypeOfProperty extends StatelessWidget {
  List listOfProperties;
  TypeOfProperty({required this.listOfProperties, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: ListView(
          children: [
            tileWidget("2BHK", context),
            tileWidget("3BHK", context),
            tileWidget("Duplex", context),
            tileWidget("House", context),
          ],
        ),
      ),
    );
  }

  Properties? findProperty(String type) {
    for (Properties element in listOfProperties) {
      if (element.type.toUpperCase() == type.toUpperCase()) {
        return element;
      }
    }
    return null;
  }

  Widget tileWidget(type, context) {
    return Column(
      children: [
        ListTile(
          title: Text(type),
          trailing: Icon(Icons.arrow_right),
          onTap: () {
            print(type);
            Properties? _property = findProperty(type);
            if (_property == null) {
              //show snackbar
              showSnackBar(context, "No property for $type");
            } else {
              // Navigator.push(
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PropertyDetailScreen(
                        data: _property,
                      )
                  //DetailsPage(propertyDetail: propertyDetail, usersStream: usersStream),
                  ));
              // ),
            }
          },
        ),
        Container(
            width: double.infinity,
            height: .5,
            decoration: BoxDecoration(color: Colors.black)),
      ],
    );
  }
}
