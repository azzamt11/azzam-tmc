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
    return getFrame(size);
  }

  Widget getFrame(var size) {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.black87,
      child: Center(
        child: SizedBox(
          height: size.height,
          width: min(size.width, 420),
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: InitialPage(),
          )
        )
      )
    );
  }
}