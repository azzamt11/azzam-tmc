import 'dart:math';

import 'package:flutter/material.dart';

class GuestPage extends StatefulWidget {
  const GuestPage({super.key});

  @override
  State<GuestPage> createState() => _GuestPageState();
}

class _GuestPageState extends State<GuestPage> {
  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    double defaultWidth= min(size.width, 420);
    return Container(
      height: size.height,
      width: defaultWidth,
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            height: 300,
            width: defaultWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/panorama.jpg"),
                fit: BoxFit.cover
              )
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
            )
          ),
        ],
      )
    );
  }
}

class ClipPathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(min(size.width, 430), size.height);
    path.lineTo(min(size.width, 430), 200);

    var firstControlPoint = Offset(min(3*size.width, 430)/4, 200);
    var firstPoint = Offset(min(size.width, 430)/2, 270);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(min(size.width, 430)/4, 270);
    var secondPoint = const Offset(0.0, 350);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(0.0, 350);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}