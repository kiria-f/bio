import 'package:bio/constants/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class FKThickButton extends StatefulWidget {
  final String label;
  final PointerDownEventListener? onPressed;

  const FKThickButton({super.key, this.label = '', this.onPressed});

  @override
  State<FKThickButton> createState() => _FKThickButtonState();
}

class _FKThickButtonState extends State<FKThickButton>
    with TickerProviderStateMixin {
  late final AnimationController elevationController;
  late final Animation<double> elevationTween;
  late final AnimationController dimController;
  late final Animation<double> dimTween;
  late bool pressed;
  late bool hovered;

  @override
  void initState() {
    super.initState();
    elevationController = AnimationController(vsync: this);
    elevationTween = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(elevationController);
    dimController = AnimationController(vsync: this);
    dimTween = Tween<double>(begin: 1, end: 0).animate(dimController);
    pressed = false;
    hovered = false;
  }

  @override
  void dispose() {
    pressed = false;
    hovered = false;
    elevationController.dispose();
    dimController.dispose();
    super.dispose();
  }

  TickerFuture animatePress() {
    return elevationController.animateTo(
      1,
      duration: const Duration(milliseconds: 50),
    );
  }

  TickerFuture animateRelease() {
    return elevationController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuad,
    );
  }

  TickerFuture animateEnter() {
    return dimController.animateTo(
      1,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
  }

  TickerFuture animateExit() {
    return dimController.animateTo(
      0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.linear,
    );
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
            return Transform.translate(
              offset: Offset(0, 3 * (1 - elevationTween.value)),
              child: IntrinsicWidth(
                child: IntrinsicHeight(
                  child: AnimatedBuilder(
                    animation: dimTween,
                    builder: (context, internalChild) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                stops: [0, 0.15, 0.85, 1],
                                colors: [
                                  Color.fromARGB(255, 255, 255, 255),
                                  Color.fromARGB(255, 200, 200, 200),
                                  Color.fromARGB(255, 200, 200, 200),
                                  Color.fromARGB(255, 255, 255, 255),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(1000),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.from(
                                    alpha: 0.5 + (1 - elevationTween.value) / 2,
                                    red: 0,
                                    green: 0,
                                    blue: 0,
                                  ),
                                  blurRadius: 2 + 4 * elevationTween.value,
                                  spreadRadius:
                                      -1 - (1 - elevationTween.value) * 1,
                                  offset: Offset(
                                    0,
                                    2 + 4 * elevationTween.value,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(0, -2),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(1000),
                              ),
                              child: externalChild,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Text(
              widget.label,
              style: TextStyle(
                fontFamily: 'Source Code Pro',
                fontSize: Constants.sizes.font.normal,
                fontWeight: FontWeight.w800,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
