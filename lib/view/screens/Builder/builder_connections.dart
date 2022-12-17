import 'package:flutter/material.dart';
import 'package:housingapp/view/screens/Builder/messagesScreen.dart';
import 'package:housingapp/view/screens/Builder/requestsScreen.dart';

class BuilderConnectionScreen extends StatefulWidget {
  const BuilderConnectionScreen({Key? key}) : super(key: key);

  @override
  State<BuilderConnectionScreen> createState() => _BuilderConnectionScreenState();
}

class _BuilderConnectionScreenState extends State<BuilderConnectionScreen> {
  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        animationDuration: Duration(milliseconds: 100),
        length: 2,
        child:  Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            backgroundColor: Colors.black,
            bottom: const TabBar(

              tabs: [
                Tab(icon: Icon(Icons.message),
                  text: 'Inbox',),
                Tab(icon: Icon(Icons.pending),
                  text: 'Request',),
              ],
            ),
          ),

          body:   TabBarView(

            children: [ 
              MessagesScreen(),
              // Center(child: Text("Request/ Approval"))
              RequestsScreen()
            ],
          ),
        ),

      );
  }
}
