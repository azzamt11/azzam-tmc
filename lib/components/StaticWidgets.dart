import 'package:flutter/material.dart';

class StaticWidgets {

  void getFloatingSnackBar(Size size, String string, BuildContext context) {
    debugPrint("Floating snackbar is appearing...");
    SnackBar floatingSnackBar = SnackBar(
      content: Text(
        string,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white)
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      margin: size != null
          ? EdgeInsets.only(
          bottom: (size.height / 2) - 40,
          left: size.width / 2 - 100,
          right: size.width / 2 - 100)
          : size.height!=0? EdgeInsets.only(
          bottom: (size.height / 2) - 40,
          left:  size.width / 2 - 100,
          right:  size.width / 2 - 100)
            : const EdgeInsets.only(bottom: 400, left: 100, right: 100),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(floatingSnackBar);
  }
}