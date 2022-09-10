import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:recipes_ui/core/widgets/adaptive_offset_effect.dart';

class MouseRegionEffect extends StatefulWidget {
  const MouseRegionEffect({
    Key? key,
    required this.width,
    required this.height,
    required this.child,
    this.offsetMultiplier = 1,
    this.childBuilder,
    this.maxMovableDistance = 10,
  })  : assert(child != null && childBuilder == null),
        super(key: key);

  const MouseRegionEffect.builder({
    Key? key,
    required this.width,
    required this.height,
    this.child,
    this.offsetMultiplier = 1,
    required this.childBuilder,
    this.maxMovableDistance = 10,
  })  : assert(childBuilder != null),
        super(key: key);

  final double width;
  final double height;
  final OffsetEffectBuilder? childBuilder;
  final Widget? child;
  final double offsetMultiplier;
  final double maxMovableDistance;

  @override
  State<MouseRegionEffect> createState() => _MouseRegionEffectState();
}

class _MouseRegionEffectState extends State<MouseRegionEffect> {
  Offset offset = const Offset(0, 0);
  Alignment mouseRegionAlignment = Alignment.bottomRight;

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
      widget.maxMovableDistance * alignment.x * -1,
      widget.maxMovableDistance * alignment.y * -1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      hitTestBehavior: HitTestBehavior.translucent,
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
      child: _buildChild(context, widget.child),
    );
  }

  Widget _buildChild(BuildContext context, Widget? child) {
    if (widget.childBuilder != null) {
      return widget.childBuilder!.call(context, offset, child);
    } else {
      return TweenAnimationBuilder(
        tween: Tween<Offset>(
          begin: Offset.zero,
          end: offset * widget.offsetMultiplier,
        ),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutBack,
        builder: (context, Offset offset, child) => Transform.translate(
          offset: offset,
          child: child,
        ),
        child: child,
      );
    }
  }
}
