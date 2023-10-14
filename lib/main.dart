import 'dart:math';

import 'package:flutter/material.dart';
import 'package:traveloka_flutter_clone/pages/InitialPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    double defaultWidth= min(size.width, 420);
    return getFrame(size, defaultWidth);
  }

  Widget getFrame(var size, double defaultWidth) {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.black87,
      child: Center(
        child: SizedBox(
          height: size.height,
          width: defaultWidth,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: InitialPage(defaultWidth: defaultWidth),
          )
        )
      )
    );
  }
}