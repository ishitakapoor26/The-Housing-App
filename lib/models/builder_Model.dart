import 'package:cloud_firestore/cloud_firestore.dart';

class BuilderModel {
  String ph_no;
  String rera_no;
  List<dynamic> rera_photo;
  List<dynamic> adhaar_photo;
  String name;
  String profilePhoto;
  String email;
  String uid;
  String city;
  String company_name;
  String company_add;
  String gst_invoice;
  String company_registration_no;
  bool isAgent;
  bool isBuilder;
  bool isVerified;

  BuilderModel(
      {required this.name,
      required this.email,
      required this.ph_no,
      required this.uid,
      required this.rera_no,
      required this.profilePhoto,
      required this.company_name,
      required this.company_registration_no,
      required this.company_add,
      required this.gst_invoice,
      required this.city,
      required this.adhaar_photo,
      required this.rera_photo,
      required this.isAgent,
      required this.isBuilder,
      required this.isVerified});

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "ph_no": ph_no,
        "uid": uid,
        "rera_no": rera_no,
        "profilePhoto": profilePhoto,
        "company_name": company_name,
        "company_registration_no": company_registration_no,
        "company_add": company_add,
        "gst_invoice": gst_invoice,
        "city": city,
        "rera_photo": rera_photo,
        "adhaar_photo": adhaar_photo,
        "isAgent": isAgent,
        "isBuilder": isBuilder,
        "isVerified": isVerified
      };
  static BuilderModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return BuilderModel(
        email: snapshot['email'],
        profilePhoto: snapshot['profilePhoto'],
        uid: snapshot['uid'],
        name: snapshot['name'],
        rera_no: snapshot['rera_no'],
        company_add: snapshot['company_add'],
        company_name: snapshot['company_name'],
        company_registration_no: snapshot['company_registration_no'],
        gst_invoice: snapshot['gst_invoice'],
        ph_no: snapshot['ph_no'],
        city: snapshot['city'],
        rera_photo: snapshot['rera_photo'],
        adhaar_photo: snapshot['adhaar_photo'],
        isAgent: snapshot['isAgent'],
        isBuilder: snapshot['isBuilder'],
        isVerified: snapshot['isVerified']);
  }
}
