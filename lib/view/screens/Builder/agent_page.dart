import 'package:flutter/material.dart';
import 'package:housingapp/view/screens/Builder/builderprofile.dart';

class AgentPageBuilder extends StatelessWidget {
  AgentPageBuilder(
      {required this.name,
      required this.email,
      required this.phone,
      required this.rera,
      required this.profilePhoto,
      Key? key})
      : super(key: key);
  String name;
  String email;
  String profilePhoto;
  String phone;
  String rera;

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
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: FadeInImage.assetNetwork(
                width: 200,
                height: 200,
                fit: BoxFit.cover,
                placeholder: "assets/vectors/profile.png",
                image: profilePhoto,
              ),
              // child: Image(
              //   // image: AssetImage("assests/vectors/profile.png"),
              //   image:
              //   // errorBuilder: (_,){},
              //   // width: 200,
              //   // height: 200,
              //   // fit: BoxFit.cover,
              // ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Name : ",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  name,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Phone : ",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  phone,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Email : ",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  email,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Rera : ",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  rera,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ]),
        )));
  }
}
