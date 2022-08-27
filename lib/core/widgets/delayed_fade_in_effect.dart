import 'package:flutter/material.dart';

class DelayedFadeInEffect extends StatefulWidget {
  const DelayedFadeInEffect({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<DelayedFadeInEffect> createState() => _DelayedFadeInEffectState();
}

class _DelayedFadeInEffectState extends State<DelayedFadeInEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();

    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1, curve: Curves.easeOut),
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
    return FadeTransition(
      opacity: opacityAnimation,
      child: widget.child,
    );
  }
}
