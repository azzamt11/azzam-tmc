import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:traveloka_flutter_clone/constants/ThemeColors.dart';

class CountryDrawer extends StatefulWidget {
  final bool isLoading;
  final double defaultWidth;
  final double height;
  final int chosenIndex;
  final int drawerIncrement;
  final dynamic data;
  final ValueChanged<int> stateFunction;
  const CountryDrawer({
    Key? key,
    required this.isLoading,
    required this.defaultWidth,
    required this.height,
    required this.drawerIncrement,
    required this.chosenIndex,
    required this.data,
    required this.stateFunction
  }) : super(key: key);

  @override
  _CountryDrawerState createState() => _CountryDrawerState();
}

class _CountryDrawerState extends State<CountryDrawer> {
  ScrollController scrollController= ScrollController();

  double containerHeight= 0;
  double defaultDrawerHeight= 0;
  double initialDragValue= 0;

  int localDrawerIncrement= 0;

  bool isReadyToHide= false;
  bool higherDrawer= false;

  @override
  void initState() {
    initializePeriodicInspection();
    setState(() {
      defaultDrawerHeight= (70+ 51*widget.data.names.length).toDouble();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: Container(
          height: containerHeight,
          width: widget.defaultWidth,
          color: Colors.black38,
          child: containerHeight!=0? SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              controller: scrollController,
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () async{
                        await scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut
                        );
                        setState(() {
                          containerHeight= 0;
                        });
                      },
                      child: Container(
                          height: containerHeight,
                          width: widget.defaultWidth,
                          color: Colors.transparent,
                          child: Center(
                              child: widget.isLoading? SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: ThemeColors().main,
                                    backgroundColor: Colors.transparent,
                                  )
                              ) : null
                          )
                      )
                  ),
                  getDrawerBody(size),
                ],
              )
          ) : null
      )
    );
  }

  Widget getDrawerBody(var size) {
    return Container(
        height: size.height+ 100,
        width: widget.defaultWidth,
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            dragger(
                Container(
                    height: 20,
                    width: widget.defaultWidth,
                    color: Colors.transparent,
                    child: Center(
                      child: Container(
                        height: 5,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2.5)
                        ),
                      ),
                    )
                ),
                size
            ),
            Container(
                height: size.height+ 70,
                width: widget.defaultWidth,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    dragger(
                        Container(
                          height: 20,
                          width: widget.defaultWidth,
                          color: Colors.transparent,
                        ),
                        size
                    ),
                    Text(
                      "Your Prefered ${widget.data.type== "country"? "Country" : "Language"}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: defaultDrawerHeight- 75,
                      width: widget.defaultWidth,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: getCountryList(size),
                        )
                      )
                    )
                  ],
                )
            ),
          ],
        )
    );
  }

   Widget dragger(Widget child, var size) {
      double scrollFixedPosition= - size.height+ defaultDrawerHeight;
      return GestureDetector(
          onVerticalDragStart: (value) {
            setState(() {
              initialDragValue= value.globalPosition.dy;
            });
          },
          onVerticalDragUpdate: (value) async{
            if(value.globalPosition.dy + scrollFixedPosition> -50) {
              scrollController.jumpTo(
                  initialDragValue- value.globalPosition.dy+ defaultDrawerHeight
              );
            }
          },
          onVerticalDragEnd: (value) async{
            if(value.velocity.pixelsPerSecond.dy >300) {
              await scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut
              );
              setState(() {
                containerHeight= 0;
              });
            } else if(value.velocity.pixelsPerSecond.dy <-500) {
              await scrollController.animateTo(
                  size.height- 100,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut
              );
              scrollController.animateTo(
                  defaultDrawerHeight,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut
              );
            } else {
              scrollController.animateTo(
                  defaultDrawerHeight,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut
              );
            }
          },
          child: child
      );
   }

  List<Widget> getCountryList(var size) {
    List<Widget> widgetList= [];
    for(int i=0; i< widget.data.names.length; i++) {
      widgetList.add(
        Container(
            height: 1,
            width: widget.defaultWidth,
            color: Colors.black12
        ),
      );
      widgetList.add(
        GestureDetector(
          onTap: () {
            widget.stateFunction(i);
            closeDrawer();
          },
          child: Container(
            height: 50,
            width: widget.defaultWidth,
            padding: const EdgeInsets.only(left: 15, right: 15),
            color: widget.chosenIndex==i? ThemeColors().main12 : Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 30,
                  child: Row(
                    children: [
                      widget.data.type=="country"? Container(
                        height: 25,
                        width: 25,
                        margin: const EdgeInsets.only(bottom: 5, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(width: 1, color: Colors.black12),
                          image: DecorationImage(
                            image: AssetImage(widget.data.flagImages[i]),
                            fit: BoxFit.cover
                          )
                        ),
                      ) : const SizedBox(),
                      Container(
                        height: 25,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          widget.data.names[i], 
                          style: const TextStyle(fontSize: 17)
                        )
                      ),
                    ],
                  )
                ),
                i==widget.chosenIndex? SizedBox(
                  height: 30,
                  width: 25,
                  child: Center(
                    child: Icon(Icons.check, color: ThemeColors().main)
                  )
                ) : const SizedBox()
              ],
            )
          )
        )
      );
    }
    return widgetList;
  }

  Future<void> closing() async{
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      localDrawerIncrement= widget.drawerIncrement;
    });
  }

  Future<void> closeDrawer() async{
    await Future.delayed(const Duration(milliseconds: 500));
    await scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut
    );
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      containerHeight= 0;
    });
  }

  Future<void> initializePeriodicInspection() async{
    while(true) {
      debugPrint("localDrawerIncrement= $localDrawerIncrement, widget.drawerIncrement= ${widget.drawerIncrement}");
      if(widget.drawerIncrement>localDrawerIncrement) {
        setState(() {
          defaultDrawerHeight= (100+ 51*widget.data.names.length).toDouble();
        });
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          containerHeight= widget.height;
          localDrawerIncrement= widget.drawerIncrement;
        });
        while(widget.isLoading || !scrollController.hasClients) {
          await Future.delayed(const Duration(milliseconds: 100));
        }
        scrollController.animateTo(
            defaultDrawerHeight,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut
        );
      }
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }
}