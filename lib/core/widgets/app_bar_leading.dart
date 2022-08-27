import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vikings/core/styles/app_colors.dart';

class AppBarLeading extends StatefulWidget {
  const AppBarLeading({
    Key? key,
    this.bgColor = AppColors.white,
  }) : super(key: key);

  final Color bgColor;

  @override
  State<AppBarLeading> createState() => _AppBarLeadingState();
}

class _AppBarLeadingState extends State<AppBarLeading>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1, curve: Curves.easeOutBack),
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
    return InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Container(
          margin: const EdgeInsets.only(left: 17),
          decoration: BoxDecoration(
            color: widget.bgColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back,
              color: AppColors.textColorFromBackground(widget.bgColor),
            ),
          ),
        ),
      ),
    );
  }
}
