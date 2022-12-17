import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/view/auth/builder_signup.dart';
import 'package:housingapp/view/screens/Builder/MyProperties.dart';
import 'package:housingapp/view/screens/Builder/builder_landingPage.dart';
import 'package:housingapp/view/screens/Builder/builderprofile.dart';
import 'package:housingapp/view/widgets/snackBar.dart';
import 'package:image_picker/image_picker.dart';
import '../../../constant.dart';
import '../../../models/properties.dart';

class UploadProperty extends StatefulWidget {
  @override
  State<UploadProperty> createState() => _UploadPropertyState();
}

List<dynamic>? multiImages;
List<XFile>? pickedimages;
String? title;
List<dynamic>? editedImages;

class _UploadPropertyState extends State<UploadProperty> {
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
                pickedimages = await pickImage();
                // images= pickedimages;
                if (pickedimages != null && pickedimages!.isNotEmpty) {
                  // multiImages = await multiImageUploader(_images);
                  setState(() {});
                }
              },
              //   height: 20,
              // color: Colors.blue,
              child: DottedBorder(
                color: Color(0xFF674FF0), //color of dotted/dash line
                strokeWidth: 1, //thickness of dash/dots
                dashPattern: [15, 15],
                child: Container(
                    padding: EdgeInsets.all(20),
                    // width: MediaQuery.of(context).size.width,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage("assets/vectors/select_image.png"),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xFF674FF0),
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            height: 50,
                            width: 200,
                            child: const Text(
                              'Upload your Images',
                              style: TextStyle(color: Colors.white),
                            )),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )),
              ),
            ),
            pickedimages != null
                ? Wrap(
                    children: pickedimages!
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

Future<String> uploadOne(XFile image, String title) async {
  Reference db = firebaseStorage.ref().child('Properties').child(
      '${title} ${FirebaseAuth.instance.currentUser!.uid} ${getImageName(image)}');
  print(getImageName(image));
  await db.putFile(File(image.path));
  return db.getDownloadURL();
}

Future<List<String>> multiImageUploader(List<XFile> list) async {
  List<String> _path = [];

  for (XFile _images in list) {
    _path.add(await uploadOne(_images, title!));
  }
  return _path;
}

class UploadForm extends StatefulWidget {
  const UploadForm({this.property, Key? key}) : super(key: key);
  final Properties? property;
  @override
  State<UploadForm> createState() => _UploadFormState();
}

String? chosenValue;
String? projectname;

class _UploadFormState extends State<UploadForm> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController reraController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.property != null) {
      descriptionController.text = widget.property!.description;
      addressController.text = widget.property!.address;
      titleController.text = widget.property!.title;
      reraController.text = widget.property!.rera;
      cityController.text = widget.property!.city;
      projectname = widget.property!.projectname;
      chosenValue = widget.property!.type;
      amenities = widget.property!.amenities;
      multiImages = widget.property!.image;
    }
  }

  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    descriptionController.dispose();
    addressController.dispose();
    cityController.dispose();
    reraController.dispose();
    titleController.dispose();
  }

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
      // appBar:               widget.property != nul? AppBar():Container(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              widget.property != null
                  ? Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      // decoration: BoxDecoration(color: Colors.amber),
                      child: Text(
                        "Edit Property",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ))
                  : Container(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: DropdownButton<String>(
                  isExpanded: true,
                  autofocus: true,
                  borderRadius: BorderRadius.circular(30),
                  elevation: 5,
                  dropdownColor: Colors.blue[50],
                  focusColor: Colors.white,
                  value: projectname,
                  //elevation: 5,
                  style: const TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  items: <String>[
                    'The Sunrise',
                    'Elegant Altima',
                    'Future Shines',
                    'Holoraphic Homes'
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
                    "Project Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      projectname = value!;
                    });
                  },
                ),
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
                  value: chosenValue,
                  //elevation: 5,
                  style: const TextStyle(color: Colors.white),
                  iconEnabledColor: Colors.black,
                  items: <String>['2BHK', '3BHK', 'Duplex', 'House']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: const Text(
                    "Type of Property",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      chosenValue = value!;
                    });
                  },
                ),
              ),
              // TextField(
              //   controller: titleController,
              //   onChanged: (String value) {
              //     title = value;
              //   },
              //   cursorColor: Colors.amber,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     // hintText: 'Description',
              //     fillColor: Colors.amber,
              //     focusColor: Colors.amber,
              //     labelText: 'Title',
              //     prefixIcon: CircleAvatar(
              //       child: Text("T"),
              //     ),
              //     // icon: Icon(Icons.title, color: Colors.amber,),
              //   ),
              // ),
              const SizedBox(
                height: 10,
              ),
              Material(
                borderRadius: BorderRadius.circular(50),
                shadowColor: Colors.black,
                elevation: 5,
                child: TextField(
                  controller: titleController,
                  onChanged: (String value) {
                    title = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    // prefixIconConstraints: BoxConstraints(maxHeight: 40),
                    isCollapsed: false,
                    prefixIcon: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50)),
                      // backgroundImage:
                      //     AssetImage("assets/vectors/cityicon.png"),
                      child: Image(
                        image: AssetImage(
                          "assets/vectors/pin.png",
                        ),
                      ),
                    ),
                    hintText: "Title",
                    // hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                    // filled: true,
                    labelText: "Title",
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                        // borderSide: BorderSide.none,
                        gapPadding: 3,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                borderRadius: BorderRadius.circular(50),
                shadowColor: Colors.black,
                elevation: 5,
                child: TextField(
                  controller: reraController,
                  textAlign: TextAlign.center,
                  onChanged: (String value) {
                    title = value;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    // prefixIconConstraints: BoxConstraints(maxHeight: 40),
                    isCollapsed: false,
                    prefixIcon: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50)),
                      // backgroundImage:
                      //     AssetImage("assets/vectors/cityicon.png"),
                      child: Image(
                        image: AssetImage(
                          "assets/vectors/reraIcon1.png",
                        ),
                      ),
                    ),
                    hintText: "Rera",
                    // hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                    // filled: true,
                    labelText: "Rera",
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                        // borderSide: BorderSide.none,
                        gapPadding: 3,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                borderRadius: BorderRadius.circular(50),
                shadowColor: Colors.black,
                elevation: 5,
                child: TextField(
                  // maxLines: 5,
                  // scroll,
                  controller: descriptionController,
                  textAlign: TextAlign.center,
                  onChanged: (String value) {
                    title = value;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    // prefixIconConstraints: BoxConstraints(maxHeight: 40),
                    isCollapsed: false,
                    prefixIcon: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50)),
                      // backgroundImage:
                      //     AssetImage("assets/vectors/cityicon.png"),
                      child: Image(
                        image: AssetImage(
                          "assets/vectors/cityIcon1.png",
                        ),
                      ),
                    ),

                    hintText: "Descripion",
                    // hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                    // filled: true,
                    labelText: "Descripion",
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                        // borderSide: BorderSide.none,
                        gapPadding: 3,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                borderRadius: BorderRadius.circular(50),
                shadowColor: Colors.black,
                elevation: 5,
                child: TextField(
                  controller: addressController,
                  textAlign: TextAlign.center,
                  onChanged: (String value) {
                    title = value;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    // prefixIconConstraints: BoxConstraints(maxHeight: 40),
                    isCollapsed: false,
                    prefixIcon: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50)),
                      // backgroundImage:
                      //     AssetImage("assets/vectors/cityicon.png"),
                      child: Image(
                        image: AssetImage(
                          "assets/vectors/pin.png",
                        ),
                      ),
                    ),
                    hintText: "Address",
                    // hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                    // filled: true,
                    labelText: "Address",
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                        // borderSide: BorderSide.none,
                        gapPadding: 3,
                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Material(
                borderRadius: BorderRadius.circular(50),
                shadowColor: Colors.black,
                elevation: 5,
                child: TextField(
                  controller: cityController,
                  onChanged: (String value) {
                    title = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                    // prefixIconConstraints: BoxConstraints(maxHeight: 40),
                    isCollapsed: false,
                    prefixIcon: Container(
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50)),
                      // backgroundImage:
                      //     AssetImage("assets/vectors/cityicon.png"),
                      child: Image(
                        image: AssetImage(
                          "assets/vectors/cityIcon1.png",
                        ),
                      ),
                    ),
                    hintText: "City",
                    // hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                    // filled: true,
                    labelText: "City",
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                        // borderSide: BorderSide.none,
                        // gapPadding: 3,

                        borderRadius: BorderRadius.circular(50)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // TextField(
              //   controller: reraController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     // hintText: 'Description',
              //     labelText: 'Rera',
              //     icon: Icon(Icons.real_estate_agent_sharp),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // TextField(
              //   controller: descriptionController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     // hintText: 'Description',
              //     labelText: 'Description',
              //     icon: Icon(Icons.description),
              //   ),
              //   maxLines: 3,
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // TextField(
              //   controller: addressController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'Address',
              //     icon: Icon(Icons.location_on),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // TextField(
              //   controller: cityController,
              //   decoration: const InputDecoration(
              //     border: OutlineInputBorder(),
              //     labelText: 'City',
              //     icon: Icon(Icons.location_city),
              //   ),
              // ),
              ShowAmenities(),
              UploadProperty(),
              SizedBox(
                height: 20,
              ),
              widget.property != null
                  ? MaterialButton(
                      color: Color(0xFF1DAEF4),
                      child: !_isLoading
                          ? Text(
                              'Edit Property',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          : CircularProgressIndicator(
                              color: Colors.white,
                            ),
                      onPressed: () async {
                        //showSnackBar(context);

                        // setState(() {
                        //   _isLoading = true;
                        // });
                        // multiImages = await multiImageUploader(pickedimages!);

                        editProperty(
                          'Name',
                          widget.property!.uid,
                          widget.property!.pid!,
                          titleController.text,
                          descriptionController.text,
                          chosenValue!,
                          addressController.text,
                          cityController.text,
                          reraController.text,
                          projectname!,
                          multiImages!,
                        );
                        reraController.clear();
                        addressController.clear();
                        descriptionController.clear();
                        cityController.clear();
                        pickedimages = [];
                        setState(() {
                          pickedimages = [];
                          _isLoading = false;
                        });
                        showSnackBar(context, 'Property Edited');
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return IamBuilder();
                        }));
                      })
                  : MaterialButton(
                      color: Color(0xFF1DAEF4),
                      child: !_isLoading
                          ? Text(
                              'Add Property',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            )
                          : CircularProgressIndicator(
                              color: Colors.white,
                            ),
                      onPressed: () async {
                        //showSnackBar(context);

                        setState(() {
                          _isLoading = true;
                        });
                        multiImages = await multiImageUploader(pickedimages!);

                        registerProperty(
                          'Name',
                          // widget.property!.uid,
                          // widget.property!.pid,
                          titleController.text,
                          descriptionController.text,
                          chosenValue!,
                          addressController.text,
                          cityController.text,
                          reraController.text,
                          projectname!,
                          multiImages!,
                        );
                        reraController.clear();
                        addressController.clear();
                        descriptionController.clear();
                        cityController.clear();
                        pickedimages = [];
                        setState(() {
                          pickedimages = [];
                          _isLoading = false;
                        });
                        showSnackBar(context, 'Property Added');
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return IamBuilder();
                        }));
                      }),
            ],
          ),
        ),
      ),
    );
  }
}

//get image name
// String getImageName(XFile image) {
//   return image.path.split("/").last;
// }

//upload property
void registerProperty(
  String username,
  // String uid,
  // String pid,
  String title,
  String description,
  String type,
  String address,
  String city,
  String rera,
  String projectname,
  List<dynamic> image,
) async {
  Properties property = Properties(
      username: username,
      uid: FirebaseAuth.instance.currentUser!.uid,
      // pid: pid,
      description: description,
      title: title,
      type: type,
      address: address,
      city: city,
      rera: rera,
      projectname: projectname,
      image: image,
      amenities: amenities.toList());
  await firestore
      .collection('builder')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('properties')
      .add(property.toJson());
}

void editProperty(
  String username,
  String uid,
  String pid,
  String title,
  String description,
  String type,
  String address,
  String city,
  String rera,
  String projectname,
  List<dynamic> image,
) async {
  Properties property = Properties(
      username: username,
      pid: pid,
      uid: FirebaseAuth.instance.currentUser!.uid,
      description: description,
      title: title,
      type: type,
      address: address,
      city: city,
      rera: rera,
      projectname: projectname,
      image: image,
      amenities: amenities.toList());
  await firestore
      .collection('builder')
      .doc(uid)
      .collection('properties')
      .doc(pid)
      .update(property.toJson());
  // .add(property.toJson());
}

List<dynamic> amenities = [];

class ShowAmenities extends StatefulWidget {
  @override
  State<ShowAmenities> createState() => _ShowAmenitiesState();
}

class _ShowAmenitiesState extends State<ShowAmenities> {
  void show() {
    showModalBottomSheet(
      context: context,
      //  backgroundColor: Colors.yellow,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 500,
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              direction: Axis.horizontal,
              children: [
                'Club House',
                'Swimming Pool',
                'Tennis Court',
                'Park',
                'Furniture',
                'Security',
                'Basketball Court',
              ]
                  .map((String name) => GestureDetector(
                        onTap: () {
                          //     print(amenities);
                          setState(() {
                            amenities.add(name);
                          });
                        },
                        child: Chip(
                          backgroundColor: Colors.black12,
                          avatar:
                              CircleAvatar(child: Text(name.substring(0, 1))),
                          label: Text(name),
                        ),
                      ))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  Widget selectedAmenities() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width * 0.85,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: amenities
            .map((name) => Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          amenities.remove(name);
                          setState(() {});
                        },
                        child: const Icon(Icons.cancel_outlined)),
                    Chip(
                      backgroundColor: Colors.black12,
                      //avatar: CircleAvatar(child: Text(name.substring(0, 1))),
                      label: Text(name),
                    ),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                ))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return amenities.isEmpty
        ? Card(
            child: ListTile(
              title: Text("Select Amenities"),
              onTap: show,
              trailing: Icon(Icons.arrow_drop_down_circle_outlined),
            ),
          )
        : Row(
            children: [
              InkWell(
                  onTap: () {
                    show();
                  },
                  child: const Icon(Icons.arrow_drop_down_circle_outlined)),
              const SizedBox(
                width: 10,
              ),
              amenities.isEmpty
                  ? GestureDetector(
                      onTap: () {
                        show();
                      },
                      child: Text('Select Amenities'))
                  : selectedAmenities()
            ],
          );
  }
}
