import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MouseRegionEffect extends StatefulWidget {
  const MouseRegionEffect({
    Key? key,
    required this.width,
    required this.height,
    required this.builder,
  }) : super(key: key);

  final double width;
  final double height;
  final Widget Function(BuildContext context, Offset offser) builder;

  @override
  State<MouseRegionEffect> createState() => _MouseRegionEffectState();
}

class _MouseRegionEffectState extends State<MouseRegionEffect> {
  Offset offset = const Offset(0, 0);
  Alignment mouseRegionAlignment = Alignment.bottomRight;
  static const maxMovableDistance = 10;

  Alignment alignmentFromOffset(Offset mousePosition) {
    if (mousePosition.dx > widget.width / 2) {
      return mousePosition.dy > widget.height / 2
          ? Alignment.bottomRight
          : Alignment.topRight;
    } else {
      return mousePosition.dy > widget.height / 2
          ? Alignment.bottomLeft
          : Alignment.topLeft;
    }
  }

  Offset offsetFromMousePosition(Offset mousePosition) {
    Alignment alignment = alignmentFromOffset(mousePosition);
    return Offset(
      maxMovableDistance * alignment.x * -1,
      maxMovableDistance * alignment.y * -1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      hitTestBehavior: HitTestBehavior.opaque,
      onEnter: (PointerEnterEvent event) {
        setState(() {
          offset = offsetFromMousePosition(event.localPosition);
        });
      },
      onHover: (PointerHoverEvent event) {
        setState(() {
          offset = offsetFromMousePosition(event.localPosition);
        });
      },
      onExit: (PointerExitEvent event) {
        setState(() {
          offset = offsetFromMousePosition(event.localPosition);
        });
      },
      child: widget.builder(context, offset),
    );
  }
}
