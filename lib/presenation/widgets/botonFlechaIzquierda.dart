import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BotonFlechaIzquierda extends StatelessWidget {
  final Function onPressed;

  BotonFlechaIzquierda({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, size: 30.sp),
      onPressed: () => onPressed(),
    );
  }
}
