import 'package:flutter/material.dart';

MaterialBanner showMaterialBanner(
    BuildContext context, String text, String type) {
  return MaterialBanner(
    content: Text(text),
    // leading: Icon(Icons.error),
    padding: EdgeInsets.all(15),
    backgroundColor: Colors.green.shade200,
    contentTextStyle: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    actions: [],
    // actions: [
    //   TextButton(
    //     onPressed: () {},
    //     child: Text(
    //       'Agree',
    //       style: TextStyle(color: Colors.purple),
    //     ),
    //   ),
    //   TextButton(
    //     onPressed: () {
    //       ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    //     },
    //     child: Text(
    //       'Cancel',
    //       style: TextStyle(color: Colors.purple),
    //     ),
    //   ),
    // ]
  );
}
