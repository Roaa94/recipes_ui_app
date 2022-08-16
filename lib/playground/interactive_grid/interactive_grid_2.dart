import 'package:flutter/material.dart';

class InteractiveGrid extends StatefulWidget {
  const InteractiveGrid({Key? key}) : super(key: key);

  @override
  State<InteractiveGrid> createState() => _InteractiveGridState();
}

class _InteractiveGridState extends State<InteractiveGrid>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  final TransformationController transformationController =
      TransformationController();
  late final Animation<double> scaleAnimation;
  late final Animation<double> offsetAnimation;
  late final Tween<double> scaleTween;
  late final Tween<double> offsetTween;
  double xPosition = 0;
  double yPosition = 0;
  double scale = 1;

  Duration snapDuration = Duration.zero;

  void _onScaleEnd(ScaleEndDetails details) {
    setState(() {
      snapDuration = const Duration(milliseconds: 500);
      xPosition = 0;
      yPosition = 0;
    });
    Future.delayed(snapDuration, () {
      setState(() {
        snapDuration = Duration.zero;
      });
    });
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    scaleTween = Tween<double>(begin: 1, end: 1);
    offsetTween = Tween<double>(begin: 0, end: 0);
    scaleAnimation = scaleTween.animate(animationController);
    offsetAnimation = offsetTween.animate(animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double gridWidth = screenSize.width * 2;

    return SafeArea(
      child: Stack(
        children: [
          AnimatedPositioned(
            duration: snapDuration,
            left: xPosition,
            top: yPosition,
            curve: Curves.easeInOut,
            width: gridWidth,
            height: MediaQuery.of(context).size.height * 2,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleUpdate: (ScaleUpdateDetails details) {
                setState(() {
                  xPosition += details.focalPointDelta.dx;
                  yPosition += details.focalPointDelta.dy;
                  if (details.scale != 1) {
                    scale = details.scale;
                  }
                });
                // print('xPosition: $xPosition, yPosition: $yPosition');
                print(details.scale);
              },
              onScaleStart: (ScaleStartDetails details) {
                print(details);
              },
              onScaleEnd: _onScaleEnd,
              child: AnimatedScale(
                duration: snapDuration,
                scale: scale,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: screenSize.width /
                        (screenSize.height -
                            MediaQuery.of(context).padding.top -
                            MediaQuery.of(context).padding.bottom),
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
                          child: Center(
                            child: Text('${i + 1}'),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
