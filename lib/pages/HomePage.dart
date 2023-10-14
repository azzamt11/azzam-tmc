import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final double defaultWidth;
  const HomePage({super.key, required this.defaultWidth});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body: getBody(size),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget getBody(var size) {
    return Container(
      height: size.height,
      width: widget.defaultWidth,
      color: Colors.white,
      child: const Center(
        child: Text("This is HomePage")
      )
    );
  }
}