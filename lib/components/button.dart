import 'package:bio/components/surface.dart';
import 'package:bio/components/text.dart';
import 'package:bio/constants/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class FButton extends StatefulWidget {
  final String label;
  final PointerDownEventListener? onPressed;

  const FButton({super.key, this.label = '', this.onPressed});

  @override
  State<FButton> createState() => _FButtonState();
}

class _FButtonState extends State<FButton> with TickerProviderStateMixin {
  late final AnimationController elevationController;
  late final Animation<double> elevationTween;
  late final AnimationController hilightController;
  late final Animation<double> hilightTween;
  late bool pressed;
  late bool hovered;

  @override
  void initState() {
    super.initState();
    elevationController = AnimationController(vsync: this);
    elevationTween = Tween<double>(begin: 1, end: 0).animate(elevationController);
    hilightController = AnimationController(vsync: this);
    hilightTween = Tween<double>(begin: 1, end: 0).animate(hilightController);
    pressed = false;
    hovered = false;
  }

  @override
  void dispose() {
    pressed = false;
    hovered = false;
    elevationController.dispose();
    hilightController.dispose();
    super.dispose();
  }

  TickerFuture animatePress() {
    return elevationController.animateTo(1, duration: const Duration(milliseconds: 50));
  }

  TickerFuture animateRelease() {
    return elevationController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeOutQuad);
  }

  TickerFuture animateEnter() {
    return hilightController.animateTo(1, duration: const Duration(milliseconds: 100), curve: Curves.linear);
  }

  TickerFuture animateExit() {
    return hilightController.animateTo(0, duration: const Duration(milliseconds: 100), curve: Curves.linear);
  }

  void onPointerDown(PointerDownEvent event) async {
    pressed = true;
    if (widget.onPressed != null) {
      widget.onPressed!(event);
    }
    elevationController.stop();
    await animatePress();
    if (!pressed) {
      animateRelease();
    }
  }

  void onPointerUp(PointerUpEvent event) async {
    pressed = false;
    if (!elevationController.isAnimating) {
      animateRelease();
    }
  }

  void onEnter(PointerEnterEvent event) async {
    hovered = true;
    animateEnter();
  }

  void onExit(PointerExitEvent event) async {
    hovered = false;
    animateExit();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: onEnter,
      onExit: onExit,
      child: Listener(
        onPointerDown: onPointerDown,
        onPointerUp: onPointerUp,
        child: AnimatedBuilder(
          animation: elevationTween,
          builder: (context, externalChild) {
            return AnimatedBuilder(
              animation: hilightTween,
              builder: (context, internalChild) {
                return FSurface(elevation: elevationTween.value, hilight: hilightTween.value, child: externalChild);
              },
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: Constants.radius * 4 / 3),
            child: IntrinsicWidth(child: Center(child: FText(widget.label))),
          ),
        ),
      ),
    );
  }
}
