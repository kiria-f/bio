import 'package:bio/sections/head.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        color: const Color.from(alpha: 1, red: 0.98, green: 0.98, blue: 0.98),
        padding: EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [HeadSection()]),
      ),
    );
  }
}
