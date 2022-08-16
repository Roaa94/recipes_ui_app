import 'dart:developer';

import 'package:flutter/material.dart';

class InteractiveGrid extends StatefulWidget {
  const InteractiveGrid({
    Key? key,
    required this.maxHAxisCount,
    required this.minHAxisCount,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;
  final int maxHAxisCount;
  final int minHAxisCount;

  @override
  State<InteractiveGrid> createState() => _InteractiveGridState();
}

class _InteractiveGridState extends State<InteractiveGrid>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  Animation<Offset>? _snapOffsetAnimation;
  Offset offset = const Offset(0, 0);
  double scale = 1;

  late double gridChildWidth;
  late double gridChildHeight;
  late double gridWidth;
  late double gridChildAspectRatio;

  _updateOffset(Offset previousOffset) {
    bool snapToNextX =
        previousOffset.dx.abs() % gridChildWidth > gridChildWidth * 0.75;
    bool snapToNextY =
        previousOffset.dy.abs() % gridChildHeight > gridChildHeight * 0.75;
    int traveledXItems = snapToNextX
        ? (previousOffset.dx.abs() / gridChildWidth).ceil()
        : (previousOffset.dx.abs() / gridChildWidth).floor();
    int traveledYItems = snapToNextY
        ? (previousOffset.dy.abs() / gridChildHeight).ceil()
        : (previousOffset.dy.abs() / gridChildHeight).floor();
    return Offset(
      -traveledXItems * gridChildWidth,
      -traveledYItems * gridChildHeight,
    );
  }

  void _onAnimateSnap() {
    offset = _snapOffsetAnimation!.value;
    if (!_animationController.isAnimating) {
      _snapOffsetAnimation!.removeListener(_onAnimateSnap);
      _snapOffsetAnimation = null;
      _animationController.reset();
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    _snapOffsetAnimation = Tween<Offset>(
      begin: offset,
      end: _updateOffset(offset),
    ).animate(_animationController);
    _snapOffsetAnimation!.addListener(_onAnimateSnap);
    _animationController.forward();
  }

  // Stop a running reset to home transform animation.
  void _animateResetStop() {
    _animationController.stop();
    _snapOffsetAnimation?.removeListener(_onAnimateSnap);
    _snapOffsetAnimation = null;
    _animationController.reset();
  }

  void _onScaleStart(ScaleStartDetails details) {
    // If the user tries to cause a transformation while the snap animation is
    // running, cancel the snap animation.
    if (_animationController.status == AnimationStatus.forward) {
      _animateResetStop();
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    gridChildWidth = widget.width / widget.minHAxisCount;
    gridChildHeight = widget.height / widget.minHAxisCount;
    gridWidth = gridChildWidth * widget.maxHAxisCount;
    gridChildAspectRatio = gridChildWidth / gridChildHeight;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onScaleUpdate: (ScaleUpdateDetails details) {
        double xPosition = offset.dx + details.focalPointDelta.dx;
        double yPosition = offset.dy + details.focalPointDelta.dy;
        setState(() {
          offset = Offset(xPosition, yPosition);
          // if (details.scale != 1) {
          //   scale = details.scale;
          // }
        });
        // log(details.scale.toString());
      },
      onScaleStart: _onScaleStart,
      onScaleEnd: _onScaleEnd,
      child: OverflowBox(
        alignment: Alignment.topLeft,
        minHeight: 0,
        minWidth: 0,
        maxWidth: gridWidth,
        maxHeight: gridWidth / gridChildAspectRatio,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (c, child) => Transform.translate(
            offset: offset,
            child: child,
          ),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: gridChildAspectRatio,
            ),
            itemCount: 52,
            clipBehavior: Clip.none,
            itemBuilder: (context, i) {
              return Transform(
                transform: Matrix4.identity(),
                // ..setEntry(3, 2, 0.001)
                // ..rotateY(45 * 3.14 / 180),
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.blue.shade100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Item $i'),
                        Text('Width: ${gridChildWidth.ceil()}'),
                        Text('Height: ${gridChildHeight.ceil()}'),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
