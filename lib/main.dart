import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'homeScreen.dart';

void main(){
  runApp( contactApp());
}

class contactApp extends StatelessWidget{
  const contactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Contact_list(),
    );
  }}


