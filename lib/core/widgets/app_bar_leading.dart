import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipes_ui/core/styles/app_colors.dart';

class AppBarLeading extends StatefulWidget {
  const AppBarLeading({
    Key? key,
    this.bgColor = AppColors.white,
    this.text,
    this.popValue,
  }) : super(key: key);

  final Color bgColor;
  final String? text;
  final dynamic popValue;

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
      onTap: () => Navigator.of(context).pop(widget.popValue),
      child: ScaleTransition(
        scale: scaleAnimation,
        child: Container(
          margin: const EdgeInsets.only(left: 17),
          padding: EdgeInsets.all(widget.text != null ? 10 : 0),
          decoration: widget.text == null
              ? BoxDecoration(
                  color: widget.bgColor,
                  shape: BoxShape.circle,
                )
              : BoxDecoration(
                  color: widget.bgColor,
                  borderRadius: BorderRadius.circular(20),
                ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.arrow_back,
                color: AppColors.textColorFromBackground(widget.bgColor),
              ),
              if (widget.text != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.text!,
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color:
                              AppColors.textColorFromBackground(widget.bgColor),
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
