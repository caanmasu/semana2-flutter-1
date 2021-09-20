import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:semanda2flutter1/pages/home.page.dart';

void main(){
  runApp(MyApplication());
}

class MyApplication extends StatelessWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculadora",
      theme: ThemeData.light(),
      home: HomePage(),
    );
  }
}