import 'package:flutter/material.dart';
import 'package:traveloka_flutter_clone/constants/ThemeColors.dart';
import 'package:traveloka_flutter_clone/pages/NewPage.dart';

class IntroPage extends StatefulWidget {
  final double defaultWidth;
  const IntroPage({super.key, required this.defaultWidth});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  PageController controller= PageController();

  double progress= 0;

  int currentPage= 0;
  int globalIncrement= 0;

  @override
  void initState() {
    initializeSliding();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
          NewViewPage(
            defaultWidth: defaultWidth, 
            controller: controller,
            animatePage: animatePage,
          ),
          indicatorWidget(defaultWidth),
          drawer(defaultWidth, size)
        ],
      ) 
    );
  }

  Widget indicatorWidget(double defaultWidth) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: 70,
        width: defaultWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            bar(0, defaultWidth),
            bar(1, defaultWidth),
            bar(2, defaultWidth),
            close(defaultWidth)
          ],
        ),
      )
    );
  }

  Widget drawer(double defaultWidth, var size) {
    double topPosition= size.height< 750? 500 : 620;
    return Positioned(
      top: topPosition,
      child: Container(
        height: size.height- topPosition,
        width: defaultWidth,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Unlock Full Experience", 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
            ),
            const SizedBox(height: 20),
            button(defaultWidth)
          ],
        )
      )
    );
  }

  Widget button(double defaultWidth) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context)=> NewPage(defaultWidth: defaultWidth)
            )
          );
        },
        splashColor: Colors.black12,
        child: Container(
          height: 35,
          width: defaultWidth- 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.orange,
          ),
          child: const Center(
            child: Text("Join Traveloka", style: TextStyle(
              fontSize: 16, 
              fontWeight: FontWeight.bold, 
              color: Colors.white
              )
            )
          )
        )
      )
    );
  }

  Widget bar(int index, double defaultWidth) {
    double barWidth= defaultWidth/3- 25;
    return GestureDetector(
      onTap: () async{
        debugPrint("bar is clicked at index= $index");
        setState(() {
          currentPage= index;
        });
        debugPrint("we go to page $index, controller.page= ${controller.page}");
        await animatePage(index);
      }, 
      child: Container(
        margin: EdgeInsets.only(
          left: index==0? 5: 3.5,
          right: index==2? 5: 3.5
        ),
        height: 35,
        width: barWidth,
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              top: 20,
              child: Container(
              height: 5,
              width: barWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5),
                color: ThemeColors().secondary
              ),
              ),
            ),
            Positioned(
              left: 0,
              top: 20,
              child: Container(
                height: 5,
                width: barWidth*(
                  controller.hasClients
                  ? controller.page==index
                  ? progress 
                  : controller.page!< index
                  ? 0 : 1 : 0
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.5),
                  color: Colors.white
                ),
              ),
            )
          ],
        )
      )
    );
  }

  Widget close(double defaultWidth) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context)=> NewPage(defaultWidth: defaultWidth)
          )
        );
      },
      child: Container(
        height: 35,
        width: 35,
        color: Colors.transparent,
        child: const Center(
          child: Icon(Icons.close, size: 25, color: Colors.white)
        )
      )
    );
  }

  Future<void> animatePage(int index) async{
    controller.jumpToPage(index);
    debugPrint("jumped to ${index.toDouble()}");
    setState(() {
      globalIncrement++;
    });
    int increment= globalIncrement;
    for(int i= index; i< 3; i++) {
      debugPrint("i= $i");
      for(int j=0; j< 51; j++) {
        setState(() {
          progress= j*0.02;
        });
        if(increment< globalIncrement) {
          setState(() {
            progress=0;
            increment= globalIncrement;
          });
          break;
        }
        await Future.delayed(const Duration(milliseconds: 100));
        debugPrint("progress= $progress, controller.page= ${controller.page}");
        if(j== 50) {
          debugPrint("animating to nextPage: to page ${i+1}");
          await controller.nextPage(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn
          );
          setState(() {
            currentPage++;
          });
        }
      }
    }
  }

  Future<void> initializeSliding() async{
    bool param= true;
    while(param) {
      debugPrint("initializeSliding is in progress");
      await Future.delayed(const Duration(seconds: 1));
      if(controller.hasClients) {
        debugPrint("since controller has client, we are going");
        setState(() {
          currentPage= 0;
        });
        await animatePage(0);
        param=false;
      }
    }
  }
}

class NewViewPage extends StatefulWidget {
  final double defaultWidth;
  final PageController controller;
  final Function(int index) animatePage;
  const NewViewPage({
    super.key, 
    required this.defaultWidth, 
    required this.controller, 
    required this.animatePage
  });

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
                    await widget.controller.nextPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn
                    );
                    debugPrint("swipe to right detected");
                    await widget.animatePage(widget.controller.page!.toInt());
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
                      await widget.controller.previousPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn
                      );
                      await widget.animatePage(widget.controller.page!.toInt());
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
    return SizedBox(
      height: size.height,
      width: defaultWidth,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Image(
              width: defaultWidth,
              height: 1600*defaultWidth/720,
              image: AssetImage(
                "images/introImage_$index.jpg",
              ),
              fit: BoxFit.cover
            )
          )
        ],
      )
    );
  }
}