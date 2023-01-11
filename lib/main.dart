import 'package:flutter/material.dart';
import 'package:untitled/HomePage.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
      primaryColor: Colors.orange,
      typography: Typography(
        englishLike: Typography.englishLike2018,
      ),
    ),
    title: 'Balance app',
  ));
}
