import 'package:flutter/material.dart';
import '../../../constant.dart';

class AgentVerificationScreen extends StatefulWidget {
  Map<String, dynamic> data;
  AgentVerificationScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<AgentVerificationScreen> createState() =>
      _AgentVerificationScreenState(data: data);
}

class _AgentVerificationScreenState extends State<AgentVerificationScreen> {
  late bool check ;
  Map<String, dynamic> data;
  Color colorcheck = Colors.red;
  _AgentVerificationScreenState({required this.data});

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
              Text('Email : ${data['email']}'),
              Text('Phone : ${data['ph_no']}'),
              Text('Rera No : ${data['rera_no']}'),
              Text('Status : ${data['isVerified'].toString()}'),
              MaterialButton(
                  child:check==true? Text('Click to Disable'): Text('Clcik to verify'),
                  onPressed: () async {
                    if (!check) {
                      await firestore
                          .collection('agent')
                          .doc(data['uid'])
                          .update({"isVerified": true});
                      setState(() {
                        check = true;
                      });
                      setState((){});
                    }
                    else{
                      await firestore
                          .collection('agent')
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


            ],
          ),
        ),
      ),
    );
  }
}
