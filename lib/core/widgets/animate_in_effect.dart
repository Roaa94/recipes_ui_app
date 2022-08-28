import 'package:flutter/material.dart';

class AnimateInEffect extends StatefulWidget {
  const AnimateInEffect({
    Key? key,
    required this.child,
    this.intervalStart = 0,
  }) : super(key: key);

  final Widget child;
  final double intervalStart;

  @override
  State<AnimateInEffect> createState() => _AnimateInEffectState();
}

class _AnimateInEffectState extends State<AnimateInEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<Offset> offsetAnimation;
  late final Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    Future.delayed(
      const Duration(milliseconds: 300),
      () => animationController.forward(),
    );

    Curve intervalCurve = Interval(
      widget.intervalStart,
      1,
      curve: Curves.easeOut,
    );

    offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 30),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: intervalCurve,
      ),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: intervalCurve,
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
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) => Transform.translate(
        offset: offsetAnimation.value,
        child: child,
      ),
      child: FadeTransition(
        opacity: fadeAnimation,
        child: widget.child,
      ),
    );
  }
}
