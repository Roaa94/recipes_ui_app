import 'package:flutter/material.dart';

class MenuListItemTextWrapper extends StatefulWidget {
  const MenuListItemTextWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<MenuListItemTextWrapper> createState() =>
      _MenuListItemTextWrapperState();
}

class _MenuListItemTextWrapperState extends State<MenuListItemTextWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<Offset> offsetAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -30),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.3, 1, curve: Curves.easeOutBack),
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
      child: widget.child,
      builder: (context, child) {
        return Transform.translate(
          offset: offsetAnimation.value,
          child: child,
        );
      },
    );
  }
}
