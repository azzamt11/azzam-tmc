import 'dart:math';

import 'package:flutter/material.dart';
import 'package:traveloka_flutter_clone/functions/DataFunction.dart';
import 'package:traveloka_flutter_clone/pages/HomePage.dart';
import 'package:traveloka_flutter_clone/pages/RegisterPage.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  @override
  void initState() {
    initiateRegister();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Scaffold(
      body: getBody(size, min(size.width, 420)),
      resizeToAvoidBottomInset: false,
    );
  }
   
  Widget getBody(var size, double defaultWidth) {
    return Container(
      height: size.height,
      width: defaultWidth,
      color: const Color.fromRGBO(27, 160, 226, 1),
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 130,
              width: 130,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/travelokaLogo.png")
                )
              ),
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              width: 250,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/travelokaSubLogo.png")
                )
              ),
            )
          )
        ],
      )
    );
  }

  Future<void> initiateRegister() async{
    await Future.delayed(const Duration(seconds: 3));
    String? isRegistered= await DataFunctions().getString("user", "isRegistered");
    if(isRegistered=="true") {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> const HomePage())
      );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> const RegisterPage())
      );
    }
  } 
}