import 'package:flutter/material.dart';

class RectanguloPequenyoIndicador extends StatelessWidget {
  final Color color;

  const RectanguloPequenyoIndicador({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.black, width: 1),
      ),
    );
  }
}
