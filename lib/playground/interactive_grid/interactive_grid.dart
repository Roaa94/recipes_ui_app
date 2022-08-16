import 'package:flutter/material.dart';

class InteractiveGrid extends StatefulWidget {
  const InteractiveGrid({
    Key? key,
    required this.horizontalAxisCount,
  }) : super(key: key);

  final int horizontalAxisCount;

  @override
  State<InteractiveGrid> createState() => _InteractiveGridState();
}

class _InteractiveGridState extends State<InteractiveGrid>
    with TickerProviderStateMixin {
  final TransformationController _transformationController =
      TransformationController();
  Animation<Matrix4>? _snapAnimation;
  late final AnimationController _animationController;

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

    Matrix4 updated = Matrix4.identity()
      ..setEntry(0, 0, scaleX)
      ..setEntry(1, 1, scaleY)
      ..setEntry(2, 2, scaleZ)
      ..setTranslationRaw(-20, -20, 0);
    print('Scales: $scaleX, $scaleY, $scaleZ');
    print('updated $updated');
    print('previous $previous');
    return updated;
  }

  void _initSnapAnimation() {
    _animationController.reset();
    _snapAnimation = Matrix4Tween(
      begin: _transformationController.value,
      end: _updateTransformationMatrix(_transformationController.value),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double gridWidth = screenSize.width * 2;
    double gridChildAspectRatio = screenSize.width /
        (screenSize.height - MediaQuery.of(context).padding.top);

    return InteractiveViewer(
      constrained: false,
      minScale: 1,
      maxScale: 3,
      // boundaryMargin: EdgeInsets.only(
      //   bottom: MediaQuery.of(context).padding.bottom,
      // ),
      transformationController: _transformationController,
      onInteractionUpdate: (ScaleUpdateDetails details) {
        // print(_transformationController.value.getTranslation().x);
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
            crossAxisCount: widget.horizontalAxisCount,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: gridChildAspectRatio,
          ),
          itemCount: 52,
          clipBehavior: Clip.none,
          itemBuilder: (context, i) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: Colors.blue.shade100,
              ),
            );
          },
        ),
      ),
    );
  }
}
