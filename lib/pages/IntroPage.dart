import 'package:flutter/material.dart';
import 'package:traveloka_flutter_clone/constants/ThemeColors.dart';

class IntroPage extends StatefulWidget {
  final double defaultWidth;
  const IntroPage({super.key, required this.defaultWidth});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: getBody(widget.defaultWidth, size),
    );
  }

  Widget getBody(double defaultWidth, var size) {
    return Container(
      height: size.height,
      width: defaultWidth,
      child: Column(
        children: [
          viewPage(defaultWidth, size),
          bottomWidget(defaultWidth, size)
        ],
      )
    );
  }

  Widget viewPage(double defaultWidth, var size) {
    return Container(
      height: size.height- 80,
      width: defaultWidth,
      color: Colors.white,
    );
  }

  Widget bottomWidget(double defaultWidth, var size) {
    return Container(
      height: 80,
      width: defaultWidth,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          button("Lewati"),
          indicator(),
          button("Lanjut")
        ],
      )
    );
  }

  Widget button(String text) {
    return InkWell(
      onTap: () {

      },
      splashColor: Colors.black12,
      child: SizedBox(
        height: 50,
        width: 120,
        child: Center(
          child: Text(text, style: TextStyle(color: ThemeColors().main, fontSize: 20)),
        )
      )
    );
  }

  Widget indicator() {
    return Container(
      height: 50,
      width: 100,
      color: Colors.white
    );
  }
}