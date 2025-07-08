import 'package:bio/components/surface.dart';
import 'package:bio/components/text.dart';
import 'package:flutter/widgets.dart';

class HeadSection extends StatelessWidget {
  const HeadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FSurface(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            FSurface(round: true, child: Image.asset('assets/images/me.png')),
            Column(children: [FText('еб')]),
          ],
        ),
      ),
    );
  }
}
