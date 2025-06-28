import 'package:bio/constants/constants.dart';
import 'package:flutter/widgets.dart';

class FKButton extends StatefulWidget {
  final String label;
  final PointerDownEventListener? onPressed;

  const FKButton({super.key, this.label = '', this.onPressed});

  @override
  State<FKButton> createState() => _FKButtonState();
}

class _FKButtonState extends State<FKButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> elevation;
  late bool pendingRelease;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    elevation = Tween<double>(begin: 1, end: 0).animate(controller);
    pendingRelease = false;
  }

  @override
  void dispose() {
    pendingRelease = false;
    controller.dispose();
    super.dispose();
  }

  TickerFuture animatePush() {
    return controller.animateTo(1, duration: const Duration(milliseconds: 50));
  }

  TickerFuture animateRelease() {
    return controller.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuad,
    );
  }

  void onPointerDown(PointerDownEvent event) async {
    if (widget.onPressed != null) {
      widget.onPressed!(event);
    }
    controller.stop();
    await animatePush();
    if (pendingRelease) {
      pendingRelease = false;
      animateRelease();
    }
  }

  void onPointerUp(PointerUpEvent event) async {
    if (controller.isAnimating) {
      pendingRelease = true;
    } else {
      animateRelease();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: onPointerDown,
      onPointerUp: onPointerUp,
      child: AnimatedBuilder(
        animation: elevation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 3 * (1 - elevation.value)),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(1000),
                boxShadow: [
                  BoxShadow(
                    color: Color.from(
                      alpha: 0.5 + (1 - elevation.value) / 2,
                      red: 0,
                      green: 0,
                      blue: 0,
                    ),
                    blurRadius: 3 * elevation.value,
                    spreadRadius: 0 - (1 - elevation.value) * 1,
                    offset: Offset(0, 3 * elevation.value),
                  ),
                ],
              ),
              child: child,
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
    );
  }
}
