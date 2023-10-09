import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:traveloka_flutter_clone/components/CountryDrawer.dart';
import 'package:traveloka_flutter_clone/components/StaticWidgets.dart';
import 'package:traveloka_flutter_clone/constants/ThemeColors.dart';
import 'package:traveloka_flutter_clone/models/Countries.dart';
import 'package:traveloka_flutter_clone/pages/IntroPage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Countries countries= Countries();
  Languages languages= Languages();

  bool isChosingCountry= false;
  bool isChosing= false;

  int chosenCountry= 0;
  int chosenLang= 0;

  int drawerIncrement= 0;

  int counter= 0;

  @override
  Widget build(BuildContext context) {
    debugPrint("rebuild with chosenLang= $chosenLang");
    var size= MediaQuery.of(context).size;
    double defaultWidth= min(size.width, 420);
    return WillPopScope(
      onWillPop: () async{
        StaticWidgets().getFloatingSnackBar(Size(defaultWidth, size.height), "Klik sekali lagi untuk keluar", context);
        startCountingToExit();
        return false;
      },
      child: Material(
        child: Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              body: SizedBox(
                height: size.height,
                width: defaultWidth,
                child: Stack(
                  children: [
                    Positioned(
                      top: -25,
                      left: -10,
                      child: Container(
                        height: 300,
                        width: defaultWidth+ 10,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/panorama.jpg"),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: ClipPathClass(),
                      child: Container(
                        height: size.height,
                        width: defaultWidth,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(-3, -3),
                              color: Colors.black12,
                              blurRadius: 8,
                              spreadRadius: 8,
                            )
                          ]
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 240,
                              left: 15,
                              child: SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Halo!, Selamat datang di Traveloka.", 
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                                    ),
                                    const SizedBox(height: 23),
                                    const Text(
                                      "To continue, pick your country and language.", 
                                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                                    ),
                                    const SizedBox(height: 40),
                                    inputWidget(0, defaultWidth, "Your Location", countries.names, chosenCountry),
                                    const SizedBox(height: 40),
                                    inputWidget(1, defaultWidth, "Your Preferred Language", languages.names, chosenLang),
                                  ],
                                )
                              )
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: button(defaultWidth)
                            )
                          ],
                        )
                      )
                    ),
                  ],
                )
              )
            ),
            CountryDrawer(
              isLoading: false,
              defaultWidth: defaultWidth,
              height: size.height,
              drawerIncrement: drawerIncrement,
              chosenIndex: isChosingCountry? chosenCountry: chosenLang,
              data: isChosingCountry? countries: languages,
              stateFunction: (i) {
                setState(() {
                  isChosingCountry? chosenCountry= i : chosenLang= i;
                });
                Future.delayed(const Duration(milliseconds: 500));
                setState(() {
                  drawerIncrement++;
                  isChosing= false;
                  isChosingCountry= false;
                });
              },
            )
          ],
        )
      ),
    );
  }

  Widget inputWidget(int index, var defaultWidth, String text, List<String> list, int chosenValue) {
    return SizedBox(
      height: 60,
      width: defaultWidth- 30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text, 
            style: const TextStyle(
              fontSize: 14, 
              color: Colors.grey, 
              fontWeight: FontWeight.w500
            )
          ),
          GestureDetector(
            onTap: () async{
              debugPrint("drawerIncrement= $drawerIncrement");
              setState(() {
                drawerIncrement++;
                isChosing= true;
                if(index== 0) {
                  isChosingCountry= true;
                }
              });
            },
            child: Container(
              height: 35,
              width: defaultWidth- 30,
              margin: const EdgeInsets.only(top: 5),
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    width: defaultWidth- 30,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 30,
                          child: Row(
                            children: [
                              index==0? Container(
                                height: 25,
                                width: 25,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(width: 1, color: Colors.black12),
                                  image: DecorationImage(
                                    image: AssetImage(countries.flagImages[chosenValue]),
                                    fit: BoxFit.cover
                                  )
                                ),
                              ) : const SizedBox(),
                              SizedBox(
                                height: 25,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    list[chosenValue], 
                                    style: const TextStyle(fontSize: 16)
                                  )
                                )
                              ),
                            ],
                          )
                        ),
                        SizedBox(
                          height: 30,
                          width: 25,
                          child: Center(
                            child: Icon(Icons.arrow_drop_down, color: ThemeColors().main, size: 20)
                          )
                        )
                      ],
                    )
                  ),
                ],
              )
            ),
          ),
          Container(
            height: 1,
            width: defaultWidth- 30,
            color: Colors.black12,
          )
        ],
      )
    );
  }

  Widget button(double defaultWidth) {
    return Container(
      height: 40,
      width: defaultWidth- 30,
      margin: const EdgeInsets.only(bottom: 17),
      child: Material(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context)=> IntroPage(defaultWidth: defaultWidth))
            );
          },
          splashColor: Colors.black12,
          child: Container(
            height: 45,
            width: defaultWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: ThemeColors().main
            ),
            child: const Center(
              child: Text("Lanjutkan", style: TextStyle(fontSize: 16, color: Colors.white))
            )
          )
        )
      )
    );
  }

  Future<void> initiateDrawer(int index) async{
    setState(() {
      drawerIncrement++;
      isChosing= true;
      if(index==0) {
        isChosingCountry= true;
      } else {
        isChosingCountry= false;
      }
    });
  } 

  Future<void> startCountingToExit() async {
    setState(() {
      counter++;
    });
    if (counter == 2) {
      exit(1);
    }
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      counter = 0;
    });
  }

}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(min(size.width, 430), size.height);
    path.lineTo(min(size.width, 430), 110);

    var secondControlPoint = const Offset(200, 180);
    var secondPoint = const Offset(0.0, 210);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
      secondPoint.dx, secondPoint.dy);
    path.lineTo(0.0, 240);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}