import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:housingapp/constant.dart';
import 'package:housingapp/models/properties.dart';
import 'package:housingapp/view/screens/Builder/UploadProperties.dart';

class PropertyDetailScreen extends StatelessWidget {
  PropertyDetailScreen({Key? key, required this.data}) : super(key: key);
  final Properties data;

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    List<String> images = [];
    List<Widget> sliderimages = [];
    for (var i in data.image) {
      //images.add(i);
      //images.add(i);
      sliderimages.add(Image.network(i));
    }
    List<String> amenities = [];
    for (var i in data.amenities) {
      amenities.add(i);
    }
    print(amenities);
    // for(var i in images){
    //   sliderimages.add(Image.network(i));
    // }
    // print(sliderimages.runtimeType);
    print(images.runtimeType);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            data.projectname,
            style: TextStyle(color: buttonColor),
          ),
          leading: Icon(
            Icons.add,
            color: Colors.transparent,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  Properties property = data;
                  print(property.address);
                  print(property.type);
                  print(property.uid);
                  //    MyNavigationBar(),
                  return UploadForm(
                    property: property,
                  );
                }));
              },
            )
          ],
          backgroundColor: Colors.black),
      body: SafeArea(
        child: Container(
          height: double.maxFinite,
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   data['projectname'],
                //   textAlign: TextAlign.center,
                // ),
                // Center(
                //   child: Text('${data['projectname']} Presents'
                //     ,style: TextStyle(
                //         color: Colors.black87,
                //       fontSize: 15
                //     ),
                //   ),
                // ),
                // Divider(
                //   color: Colors.black87,
                //   height: 2,
                // ),
                // SizedBox(height: 10,),
                ImageSlideshow(
                  // width: double.infinity,
                  height: 300,
                  initialPage: 0,
                  indicatorColor: Colors.blue,
                  indicatorBackgroundColor: Colors.grey,

                  children: sliderimages,

                  onPageChanged: (value) {
                    //  print('Page changed: $value');
                  },

                  autoPlayInterval: 3000,

                  isLoop: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            data.title,
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        '${data.city}',
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                              color: Colors.black.withOpacity(0.5),
                            ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: amenities
                              .map((String name) => Row(
                                    children: [
                                      Chip(
                                        backgroundColor: Colors.black12,
                                        avatar: CircleAvatar(
                                            child: Text(name.substring(0, 1))),
                                        label: Text(name),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      )
                                    ],
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            data.description,
                            textAlign: TextAlign.justify,
                            style:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.black.withOpacity(0.5),
                                      letterSpacing: 1.1,
                                      height: 1.4,
                                    ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
