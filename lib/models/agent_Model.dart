import 'package:cloud_firestore/cloud_firestore.dart';

class Agent {
  String ph_no;
  String? rera_no;
  String name;
  String profilePhoto;
  String email;
  String uid;
  String city;
  bool isAgent;
  bool isBuilder;
  bool isVerified;
  String? companyName;
  String? companyAdd;
  String? companyPAN;
  String? companyRERA;
  String? companyWeb;
  int? yoe;
  // String ;

  Agent(
      {required this.name,
      required this.email,
      required this.ph_no,
      required this.uid,
      this.rera_no,
      required this.profilePhoto,
      required this.city,
      required this.isAgent,
      required this.isBuilder,
      required this.isVerified,
      this.companyName,
      this.companyAdd,
      this.companyPAN,
      this.companyWeb,
      this.companyRERA,
      this.yoe
      });

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "ph_no": ph_no,
        "uid": uid,
        "rera_no": rera_no,
        "profilePhoto": profilePhoto,
        "type": city,
        "isAgent": isAgent,
        "isBuilder": isBuilder,
        "isVerified": isVerified
      };

  static Agent fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Agent(
        email: snapshot['email'],
        profilePhoto: snapshot['profilePhoto'],
        uid: snapshot['uid'],
        name: snapshot['name'],
        rera_no: snapshot['rera_no'],
        ph_no: snapshot['ph_no'],
        city: snapshot['city'],
        isAgent: snapshot['isAgent'],
        isBuilder: snapshot['isBuilder'],
        isVerified: snapshot['isVerified']);
  }
}
