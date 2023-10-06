import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  final double defaultWidth;
  const IntroPage({super.key, required this.defaultWidth});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController controller= PageController();

  List<double> progresses= [0, 0, 0];

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
          NewViewPage(defaultWidth: defaultWidth, controller: controller),
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
    double barWidth= defaultWidth/3- 20;
    return  TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: progresses[index]),
      duration: const Duration(seconds: 5),
      builder:(BuildContext context, double param, Widget? child) {
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
                  color: Colors.black12
                ),
              ),
              Positioned(
                left: 0,
                child: Container(
                  height: 5,
                  width: barWidth*param,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.5),
                    color: Colors.white
                  ),
                ),
              )
            ],
          )
        );
      },
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
  final PageController controller;
  const NewViewPage({super.key, required this.defaultWidth, required this.controller});

  @override
  State<NewViewPage> createState() => _NewViewPageState();
}

class _NewViewPageState extends State<NewViewPage> {
  int currentIndex= 0;

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: widget.controller,
            onPageChanged: (index){
              setState(() {
                currentIndex= index;
              });
            },
            children: [
              introTab(size, widget.defaultWidth, 0),
              introTab(size, widget.defaultWidth, 1),
              introTab(size, widget.defaultWidth, 2),
            ],
          ),
          Positioned(
            right: 0,
            top: 150,
            child: SizedBox(
              height: size.height,
              width: 70,
              child: GestureDetector(
                onPanUpdate: (details) async{
                  if (details.delta.dx > 50) {
                    widget.controller.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn
                    );
                  }
                },
                child: SizedBox(
                  height: size.height,
                  width: 65,
                )
              )
            )
          ),
          Positioned(
              left: 0,
              top: 150,
              child: GestureDetector(
                  onPanUpdate: (details) async{
                    if (details.delta.dx < -50) {
                      widget.controller.previousPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn
                      );
                    }
                  },
                  child: SizedBox(
                    height: size.height,
                    width: 65,
                  )
              )
          )
        ],
      );
  }

  Widget introTab(var size, double defaultWidth, int index) {
    return Container(
      height: size.height,
      width: defaultWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/introImage_$index.png"),
          fit: BoxFit.cover
        )
      )
    );
  }
}