import 'package:flutter/material.dart';

class MenuListItemImage extends StatefulWidget {
  const MenuListItemImage({Key? key}) : super(key: key);

  @override
  State<MenuListItemImage> createState() => _MenuListItemImageState();
}

class _MenuListItemImageState extends State<MenuListItemImage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
