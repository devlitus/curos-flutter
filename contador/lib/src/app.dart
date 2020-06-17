import 'package:flutter/material.dart';
import 'package:contador/src/pages/home_pages.dart';

class Myapp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Center(
        child: HomePage()
      ),
    );
  }
}