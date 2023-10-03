import 'package:flutter/material.dart';
import 'package:traveloka_flutter_clone/constants/ThemeColors.dart';

class NewPage extends StatefulWidget {
  final double defaultWidth;
  const NewPage({super.key, required this.defaultWidth});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
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
          "Maaf, halaman ini masih dalam tahap konstruksi 🙏.", 
          style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.center,
        )
        )
      )
    );
  }
}