import 'package:flutter/material.dart';

class IngredientItemWrapper extends StatefulWidget {
  const IngredientItemWrapper({
    Key? key,
    required this.child,
    this.index = 0,
    this.totalCount = 1,
  }) : super(key: key);

  final Widget child;
  final int index;
  final int totalCount;

  @override
  State<IngredientItemWrapper> createState() => _IngredientItemWrapperState();
}

class _IngredientItemWrapperState extends State<IngredientItemWrapper>
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

    double intervalStartValue = widget.index / widget.totalCount;
    Curve intervalCurve = Interval(
      intervalStartValue,
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
