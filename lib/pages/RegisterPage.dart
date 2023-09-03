import 'dart:math';

import 'package:flutter/material.dart';
import 'package:traveloka_flutter_clone/components/CountryDrawer.dart';
import 'package:traveloka_flutter_clone/constants/ThemeColors.dart';
import 'package:traveloka_flutter_clone/models/Countries.dart';

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

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    double defaultWidth= min(size.width, 420);
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: size.height,
            width: defaultWidth,
            child: Stack(
              children: [
                Positioned(
                  top: -10,
                  child: Container(
                    height: 300,
                    width: defaultWidth,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 250),
                        const Text(
                          "Halo!, Selamat datang di Traveloka.", 
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                        ),
                        const SizedBox(height: 40),
                        const Text(
                          "To comctinue, pick your country and language.", 
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)
                        ),
                        const SizedBox(height: 50),
                        inputWidget(0, defaultWidth, "Your Location", countries.names, chosenCountry),
                        const SizedBox(height: 50),
                        inputWidget(1, defaultWidth, "Your Preferred Language", languages.names, chosenLang),
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
          drawerIncrement: drawerIncrement,
          chosenIndex: isChosingCountry? chosenCountry: chosenLang,
          data: countries,
          stateFunction: (i) {
            if(isChosing) {
              setState(() {
                isChosingCountry? chosenCountry= i : chosenLang= i;
              });
              Future.delayed(const Duration(milliseconds: 500));
              setState(() {
                drawerIncrement++;
              });
            }
          },
        )
      ],
    );
  }

  Widget inputWidget(int index, var defaultWidth, String text, List<String> list, int chosenValue) {
    return SizedBox(
      height: 60,
      width: defaultWidth- 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text, 
            style: const TextStyle(
              fontSize: 15, 
              color: Colors.grey, 
              fontWeight: FontWeight.bold
            )
          ),
          GestureDetector(
            onTap: () async{
              await initiateDrawer(index);
            },
            child: SizedBox(
              height: 35,
              width: defaultWidth- 20,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    width: defaultWidth- 20,
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
                                margin: const EdgeInsets.only(bottom: 5, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(width: 1, color: Colors.black12),
                                  image: DecorationImage(
                                    image: AssetImage(countries.flagImages[chosenValue]),
                                    fit: BoxFit.cover
                                  )
                                ),
                              ) : const SizedBox(),
                              Container(
                                height: 25,
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                  list[chosenValue], 
                                  style: const TextStyle(fontSize: 17)
                                )
                              ),
                            ],
                          )
                        ),
                        SizedBox(
                          height: 30,
                          width: 25,
                          child: Center(
                            child: Icon(Icons.arrow_downward, color: ThemeColors().main)
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
            width: defaultWidth- 20,
            color: Colors.grey,
          )
        ],
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
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(min(size.width, 430), size.height);
    path.lineTo(min(size.width, 430), 150);

    var secondControlPoint = const Offset(200, 220);
    var secondPoint = const Offset(0.0, 250);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
      secondPoint.dx, secondPoint.dy);
    path.lineTo(0.0, 280);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}