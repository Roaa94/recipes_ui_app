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
    with TickerProviderStateMixin {
  final TransformationController _transformationController =
      TransformationController();
  Animation<Matrix4>? _snapAnimation;
  late final AnimationController _animationController;

  late double gridChildWidth;
  late double gridChildHeight;
  late double gridWidth;
  late double gridChildAspectRatio;

  void _onAnimateSnap() {
    _transformationController.value = _snapAnimation!.value;
    if (!_animationController.isAnimating) {
      _snapAnimation!.removeListener(_onAnimateSnap);
      _snapAnimation = null;
      _animationController.reset();
    }
  }

  Matrix4 _updateTransformationMatrix(Matrix4 previous) {
    double scaleX = previous.entry(0, 0);
    double scaleY = previous.entry(1, 1);
    double scaleZ = previous.entry(2, 2);
    double xTranslation = previous.getTranslation().x;
    double yTranslation = previous.getTranslation().y;
    double xDistance = xTranslation * scaleX;
    double yDistance = yTranslation * scaleY;
    bool snapToNextX =
        xTranslation.abs() % gridChildWidth > gridChildWidth * 0.75;
    bool snapToNextY =
        yTranslation.abs() % gridChildHeight > gridChildHeight * 0.75;
    int traveledXItems = snapToNextX
        ? (xTranslation.abs() / gridChildWidth).ceil()
        : (xTranslation.abs() / gridChildWidth).floor();
    int traveledYItems = snapToNextY
        ? (yTranslation.abs() / gridChildHeight).ceil()
        : (yTranslation.abs() / gridChildHeight).floor();

    log('translation: $xTranslation, $yTranslation');
    log('current item traveled x distance: ${xDistance % gridChildWidth}');
    log('current item traveled y distance: ${yTranslation.abs() % gridChildHeight}');
    log('traveled items: $traveledXItems, $traveledYItems');

    Matrix4 updated = Matrix4.identity()
      ..setEntry(0, 0, scaleX)
      ..setEntry(1, 1, scaleY)
      ..setEntry(2, 2, scaleZ)
      ..setTranslationRaw(-traveledXItems * gridChildWidth * scaleX,
          -traveledYItems * gridChildHeight * scaleY, 0);
    log('Scales: $scaleX, $scaleY, $scaleZ');
    return updated;
  }

  void _initSnapAnimation() {
    _animationController.reset();
    _updateTransformationMatrix(_transformationController.value);
    _snapAnimation = Matrix4Tween(
      begin: _transformationController.value,
      end: _updateTransformationMatrix(_transformationController.value),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _snapAnimation!.addListener(_onAnimateSnap);
    _animationController.forward();
  }

// Stop a running reset to home transform animation.
  void _animateResetStop() {
    _animationController.stop();
    _snapAnimation?.removeListener(_onAnimateSnap);
    _snapAnimation = null;
    _animationController.reset();
  }

  void _onInteractionStart(ScaleStartDetails details) {
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
      duration: const Duration(milliseconds: 500),
    );

    gridChildWidth = widget.width / widget.minHAxisCount;
    gridChildHeight = widget.height / widget.minHAxisCount;
    gridWidth = gridChildWidth * widget.maxHAxisCount;
    gridChildAspectRatio = gridChildWidth / gridChildHeight;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: false,
      minScale: 1,
      maxScale: 3,
      transformationController: _transformationController,
      onInteractionUpdate: (ScaleUpdateDetails details) {
        // log(_transformationController.value.getTranslation().toString());
        // print(_transformationController.value.getMaxScaleOnAxis());
      },
      onInteractionEnd: (ScaleEndDetails details) {
        _initSnapAnimation();
      },
      onInteractionStart: _onInteractionStart,
      child: SizedBox(
        width: gridWidth,
        height: gridWidth / gridChildAspectRatio,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.maxHAxisCount,
            childAspectRatio: gridChildAspectRatio,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemCount: 30,
          clipBehavior: Clip.none,
          itemBuilder: (context, i) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: GestureDetector(
                onTap: () {
                  print('tapped $i');
                },
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
    );
  }
}
