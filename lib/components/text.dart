import 'package:bio/constants/constants.dart';
import 'package:flutter/widgets.dart';

class FText extends Text {
  const FText(
    super.data, {
    super.key,
    super.style = const TextStyle(
      fontFamily: 'Source Code Pro',
      fontSize: Constants.normalFontSize,
      fontWeight: FontWeight.w800,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
    super.strutStyle,
    super.textAlign,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaler,
    super.maxLines,
    super.semanticsLabel,
    super.semanticsIdentifier,
    super.textWidthBasis,
    super.textHeightBehavior,
    super.selectionColor,
  });
}
