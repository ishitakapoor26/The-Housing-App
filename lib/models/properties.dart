import 'package:cloud_firestore/cloud_firestore.dart';

class Properties {
  String username;
  String uid;
  String? pid;
  String title;
  String rera;
  String description;
  String address;
  String city;
  String type;
  List<dynamic> image;
  List<dynamic> amenities;
  String projectname;

  Properties(
      {required this.username,
      required this.uid,
       this.pid,
      required this.projectname,
      required this.type,
      required this.title,
      required this.rera,
      required this.description,
      required this.address,
      required this.city,
      required this.image,
      required this.amenities});

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        // "pid": pid,
        "title": title,
        "image": image,
        "description": description,
        "type": type,
        "address": address,
        "city": city,
        "rera": rera,
        "projectname": projectname,
        "amenities": amenities
      };

  static Properties fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Properties(
        pid: snap.id,
        username: snapshot['username'],
        uid: snapshot['uid'],
        projectname: snapshot['projectname'],
        type: snapshot['type'],
        title: snapshot['title'],
        rera: snapshot['rera'],
        description: snapshot['description'],
        city: snapshot['city'],
        address: snapshot['address'],
        image: snapshot['image'],
        amenities: snapshot['amenities']);
  }
}
