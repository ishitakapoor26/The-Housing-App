import 'package:housingapp/calendly/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/view/screens/Agent/agent_landingPage.dart';
import 'package:housingapp/view/screens/Agent/builder_list.dart';
import 'package:provider/provider.dart';

import 'calendar_widget.dart';
import 'event_editing_page.dart';

void main() {
  runApp(const MyCalendlyApp());
}

class MyCalendlyApp extends StatelessWidget {
  const MyCalendlyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)=> ChangeNotifierProvider(
    create: (context)=> EventProvider(),
    child: MaterialApp(
      title: 'Flutter Demo',
      home: mainWidget(),
      debugShowCheckedModeBanner: false,
    ),
  );
  }



class mainWidget extends StatelessWidget {
  const mainWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> IamAgent()));
          },
        ),
        title: Text('Schedule'),
        centerTitle: true,
      ),
      body: CalendarWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.blue,
        onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EventEditingPage())),
      ),
    );
  }
}
