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
      body: Container(
        height: size.height,
        width: widget.defaultWidth,
        color: ThemeColors().main,
        child: const Center(
          child: Text(
          "Maaf, halaman ini masih dalam tahap konstruksi. Nanti hari rabu insyaAllah jadi. 🙏.", 
          style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.center,
        )
        )
      )
    );
  }
}