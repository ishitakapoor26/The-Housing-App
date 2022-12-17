import 'package:flutter/material.dart';

class ReusableDetailcard extends StatelessWidget {
  String fullname;
  String ph_no;
  String email;
  String profile;

  ReusableDetailcard(
      {Key? key,
      required this.fullname,
      required this.ph_no,
      required this.email,
      required this.profile})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white70,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10.0),
      child: SizedBox(
        height: 170,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 15,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(profile),
              radius: 50.0,
              backgroundColor: Colors.white,
            ),
            SizedBox(
              width: 70,
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, top: 40),
                  child: Text(
                    fullname,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    ph_no,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    email,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
