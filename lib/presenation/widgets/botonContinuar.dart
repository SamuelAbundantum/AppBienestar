import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BotonContinuar extends StatelessWidget {
  final Function onPressed;

  const BotonContinuar({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: 285.w,
        height: 55.h,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.white, width: 3),
        ),
        child: Center(
          child: Text(
            'Continuar',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w900,
              fontSize: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
