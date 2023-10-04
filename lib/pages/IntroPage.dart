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

  Widget getBody(double defaultWidth, size) {
    return SizedBox(
      width: defaultWidth,
      height: size.height,
      child: Stack(
        children: [
          NewViewPage(defaultWidth: defaultWidth),
          indicatorWidget(defaultWidth),
          drawer(defaultWidth)
        ],
      ) 
    );
  }

  Widget indicatorWidget(double defaultWidth) {
    return SizedBox(
      height: 70,
      width: defaultWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          bar(0, defaultWidth),
          bar(1, defaultWidth),
          bar(2, defaultWidth),
          close()
        ],
      ),
    );
  }

  Widget drawer(double defaultWidth) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 200,
        width: defaultWidth,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
      )
    );
  }

  Widget bar(int index, double defaultWidth) {
    double param= 0;
    double barWidth= defaultWidth/3- 20;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      height: 5,
      width: barWidth,
      child: Stack(
        children: [
          Container(
            height: 5,
            width: barWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.5),
              color: Colors.white
            ),
          ),
          Positioned(
            left: 0,
            child: Container(
              height: 5,
              width: barWidth*param,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5),
                color: ThemeColors().main
              ),
            ),
          )
        ],
      )
    );
  }

  Widget close() {
    return GestureDetector(
      onTap: () {
        debugPrint("close function si in progress");
      },
      child: const SizedBox(
        height: 25,
        width: 25,
        child: Center(
          child: Icon(Icons.close, size: 20, color: Colors.white)
        )
      )
    );
  }
}

class NewViewPage extends StatefulWidget {
  final double defaultWidth;
  const NewViewPage({super.key, required this.defaultWidth});

  @override
  State<NewViewPage> createState() => _NewViewPageState();
}

class _NewViewPageState extends State<NewViewPage> {
  @override
  Widget build(BuildContext context) {
    return const Text("This is ViewPage");
  }
}