import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RectanguloPequenyoIndicador extends StatelessWidget {
  final Color color;

  const RectanguloPequenyoIndicador({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 10.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.black, width: 1.0),
      ),
    );
  }
}

