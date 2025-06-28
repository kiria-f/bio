import 'package:bio/constants/constants.dart';
import 'package:flutter/widgets.dart';

class FKText extends StatelessWidget {
  final String text;

  const FKText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Source Code Pro',
        fontSize: Constants.sizes.font.normal,
        fontWeight: FontWeight.w800,
        color: const Color.fromARGB(255, 0, 0, 0), // Black color
      ),
    );
  }
}
