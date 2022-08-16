import 'dart:math' as math;

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  static const bool showCorners = false;

  static const double isDistorted = 0;

  static const double padding = 0;
  static const double angle = 70;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // double size = screenSize.width > screenSize.height
    //     ? screenSize.width / 3
    //     : screenSize.height / 3;
    double size = 120;
    const double perspectiveY = 0.006;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Transform.scale(
                scaleX: (1 / 3) + (1 - (1 / 3)) * (1 - isDistorted),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, perspectiveY * isDistorted)
                    ..rotateX((angle * math.pi / 180) * isDistorted),
                  alignment: Alignment.bottomCenter,
                  child: Collection(
                    height: size,
                    width: size * 3,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: size * 1,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, perspectiveY * isDistorted)
                  ..rotateY((-angle * math.pi / 180) * isDistorted),
                alignment: Alignment.centerRight,
                child: Collection(
                  height: size,
                  width: size,
                ),
              ),
            ),
            Positioned(
              left: size * 1,
              top: size * 1,
              child: Transform(
                transform: Matrix4.identity(),
                alignment: Alignment.centerLeft,
                child: Collection(
                  height: size,
                  width: size,
                ),
              ),
            ),
            Positioned(
              left: size * 2,
              top: size * 1,
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, perspectiveY * isDistorted)
                  ..rotateY((angle * math.pi / 180) * isDistorted),
                alignment: Alignment.centerLeft,
                child: Collection(
                  height: size,
                  width: size,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: size * 2,
              child: Transform.scale(
                scaleX: (1 / 3) + (1 - (1 / 3)) * (1 - isDistorted),
                child: Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, perspectiveY * isDistorted)
                    ..rotateX(-(angle * math.pi / 180) * isDistorted),
                  alignment: Alignment.topCenter,
                  child: Collection(
                    height: size,
                    width: size * 3,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Collection extends StatelessWidget {
  const Collection({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blue,
                    margin: const EdgeInsets.all(5),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.green,
                    margin: const EdgeInsets.all(5),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.yellow,
                    margin: const EdgeInsets.all(5),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.pink,
                    margin: const EdgeInsets.all(5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
