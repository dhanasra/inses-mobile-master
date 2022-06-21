import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TwoWaveClipper extends StatelessWidget {
  final Widget child;
  final Color waveColor;
  final Color bgColor;
  final double height;

  TwoWaveClipper(
      {@required this.child, this.waveColor, this.bgColor, this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: bgColor ?? Colors.white,
        ),
        Container(
          width: 200,
          child: ClipPath(
              clipper: CornerWaveClipper(),
              child: Container(
                color: waveColor ?? Colors.accents,
                height: height,
              )),
        ),
        child,
      ],
    );
  }
}

class SingleWaveClipper extends StatelessWidget {
  final Widget child;
  final Color waveColor;
  final Color bgColor;
  final double height;

  SingleWaveClipper(
      {@required this.child, this.waveColor, this.bgColor, this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: bgColor ?? Colors.white,
        ),
        Container(
          width: 150,
          child: ClipPath(
              clipper: QuarterWaveClipper(),
              child: Container(
                color: waveColor ?? Colors.accents,
                height: height,
              )),
        ),
        child,
      ],
    );
  }
}

class QuarterWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 1);
    /*path.quadraticBezierTo(
        size.height, size.height * 0.10, size.width, size.width * 0.5);*/
    path.quadraticBezierTo(
        size.width / 3, size.height * 0.45, size.width, size.height * 0.45);
    path.lineTo(size.width, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}

class CornerWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 3.25, size.height / 1.2);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 4.25), size.height / 1.4);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width / 1.5, size.height / 2.3);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    var thirdStart = Offset(size.width / 1, size.height / 2.8);
    //fifth point of quadratic bezier curve
    var thirdEnd = Offset(size.width + 5, 0);
    //sixth point of quadratic bezier curve
    path.quadraticBezierTo(
        thirdStart.dx, thirdStart.dy, thirdEnd.dx, thirdEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 30.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 55);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
