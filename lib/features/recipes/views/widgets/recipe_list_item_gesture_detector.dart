import 'package:flutter/material.dart';

class RecipeListItemGestureDetector extends StatefulWidget {
  const RecipeListItemGestureDetector({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onTap;

  @override
  State<RecipeListItemGestureDetector> createState() =>
      _RecipeListItemGestureDetectorState();
}

class _RecipeListItemGestureDetectorState
    extends State<RecipeListItemGestureDetector>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    scaleAnimation = Tween<double>(begin: 1, end: 0.9).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => animationController.animateTo(
        0.5,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      onExit: (_) => animationController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => animationController.forward(),
        onTapCancel: () =>
            animationController.reverse(from: animationController.value),
        onTapUp: (_) => animationController.reverse(),
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: scaleAnimation.value,
              child: widget.child,
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}
