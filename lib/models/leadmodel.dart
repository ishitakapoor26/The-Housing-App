import 'package:cloud_firestore/cloud_firestore.dart';

class Lead {
  String ph_no;
  String name;
  String email;
  String agentuid;
  String agentname;
  String projectuid;

  Lead(
      {required this.name,
      required this.email,
      required this.ph_no,
      required this.agentname,
      required this.agentuid,
      required this.projectuid});

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "ph_no": ph_no,
        "agentname": agentname,
        "agentuid": agentuid,
        "projectuid": projectuid
      };

  static Lead fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Lead(
      name: snapshot['name'],
      ph_no: snapshot['ph_no'],
      email: snapshot['email'],
      agentuid: snapshot['agentuid'],
      agentname: snapshot['agentname'],
      projectuid: snapshot['projectuid'],
    );
  }
}
