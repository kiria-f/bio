import 'package:bio/constants/constants.dart';
import 'package:flutter/widgets.dart';

class FSurface extends Container {
  FSurface({
    super.key,
    super.alignment,
    super.padding,
    super.color,
    super.decoration,
    super.foregroundDecoration,
    super.width,
    super.height,
    super.constraints,
    super.margin,
    super.transform,
    super.transformAlignment,
    super.child,
    super.clipBehavior = Clip.none,
    this.elevation = 1,
    this.hilight = 0,
  }) : assert(elevation >= 0);
  final double elevation;
  final double hilight;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -3 * elevation),
      child: Container(
        constraints: BoxConstraints(minHeight: Constants.radius * 2, minWidth: Constants.radius * 2),
        decoration: BoxDecoration(
          color: Color.lerp(Constants.backgroundColor, Constants.backgroundHilightColor, hilight),
          borderRadius: BorderRadius.circular(Constants.radius),
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
