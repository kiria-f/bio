import 'package:bio/constants/constants.dart';
import 'package:flutter/widgets.dart';

class FSurface extends Container {
  FSurface({
    super.key,
    super.alignment,
    super.padding,
    super.foregroundDecoration,
    super.width,
    super.height,
    super.constraints,
    super.margin,
    super.transform,
    super.transformAlignment,
    super.child,
    this.elevation = 1,
    this.hilight = 0,
    this.round = false,
  }) : assert(elevation >= 0);
  final double elevation;
  final double hilight;
  final bool round;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -3 * elevation),
      child: Container(
        constraints: BoxConstraints(minHeight: Constants.radius * 2, minWidth: Constants.radius * 2),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Color.lerp(Constants.backgroundColor, Constants.backgroundHilightColor, hilight),
          borderRadius: BorderRadius.circular(round ? 1000 : Constants.radius),
          boxShadow: [
            BoxShadow(
              color: Color.from(alpha: 0.5 + (1 - elevation) / 2, red: 0, green: 0, blue: 0),
              blurRadius: 3 * elevation,
              spreadRadius: elevation - 1,
              offset: Offset(0, 3 * elevation),
            ),
          ],
        ),
        child: super.build(context),
      ),
    );
  }
}
