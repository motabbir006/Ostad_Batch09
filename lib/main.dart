import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_list_api/ui_page.dart';


void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: crudApi(),
    );
  }
}

