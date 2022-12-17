import 'package:flutter/material.dart';

class Leadslist extends StatefulWidget {
  const Leadslist({Key? key}) : super(key: key);

  @override
  State<Leadslist> createState() => _LeadslistState();
}

class _LeadslistState extends State<Leadslist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('leads list'),
      ),
    );
  }
}
