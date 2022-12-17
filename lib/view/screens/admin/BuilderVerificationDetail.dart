import 'package:flutter/material.dart';
import '../../../constant.dart';

class BuilderVerificationScreen extends StatefulWidget {
  Map<String, dynamic> data;
  BuilderVerificationScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<BuilderVerificationScreen> createState() =>
      _BuilderVerificationScreenState(data: data);
}

class _BuilderVerificationScreenState extends State<BuilderVerificationScreen> {
 late bool check ;
  Map<String, dynamic> data;
  Color colorcheck = Colors.red;
  _BuilderVerificationScreenState({required this.data});

  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;
    var textValue = 'Switch is OFF';
    check = data['isVerified'];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Hero(tag: data['uid'], child: Image.network(data['profilePhoto'])),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  data['name'],
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Row(
                children: [
                  Image.network(data['adhaar_photo'][0],
                  height: 200,
                  fit: BoxFit.cover),
                  SizedBox(width: 10,),
                  Image.network(data['adhaar_photo'][1],
                      height: 200,
                      fit: BoxFit.cover),
                ],
              ),
              Text('Email : ${data['email']}'),
              Text('Phone : ${data['ph_no']}'),
              Text('Rera No : ${data['rera_no']}'),
              Image.network(data['rera_photo'][0]),
              Text('Company : ${data['company_name']}'),
              Text('Company Add : ${data['company_add']}'),
              Text('Registration Number : ${data['company_registration_no']}'),
              Text('Gst Invoice : ${data['gst_invoice']}'),
              Text('Status : ${data['isVerified'].toString()}'),
              MaterialButton(
                  child: check==true? Text('Click to Disable'): Text('Clcik to verify'),
                  onPressed: () async {
                    if (!check) {
                      await firestore
                          .collection('builder')
                          .doc(data['uid'])
                          .update({"isVerified": true});
                      setState(() {
                        check = true;
                      });
                      setState((){});
                    }
                    else{
                      await firestore
                          .collection('builder')
                          .doc(data['uid'])
                          .update({"isVerified": false});
                      setState(() {
                        check = false;
                      });
                      setState((){});
                    }
                    Navigator.pop(context);
                  }),
              check==true? Icon(Icons.verified, color: Colors.green,):Icon(Icons.pending, color: Colors.red,),
              // Switch(
              //   onChanged: (bool value) {
              //     if (isSwitched == false) {
              //       setState(() {
              //         isSwitched = true;
              //         textValue = 'Switch Button is ON';
              //       });
              //       print('Switch Button is ON');
              //     } else {
              //       setState(() {
              //         isSwitched = false;
              //         textValue = 'Switch Button is OFF';
              //       });
              //       print('Switch Button is OFF');
              //     }
              //   },
              //   value: isSwitched,
              //   activeColor: Colors.blue,
              //   activeTrackColor: Colors.yellow,
              //   inactiveThumbColor: Colors.redAccent,
              //   inactiveTrackColor: Colors.orange,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
