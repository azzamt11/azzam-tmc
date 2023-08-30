import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    double defaultWidth= min(size.width, 420);
    return Container(
      height: size.height,
      width: defaultWidth,
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            height: 300,
            width: defaultWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/regBackground.png")
              )
            ),
          )
        ],
      )
    );
  }
}