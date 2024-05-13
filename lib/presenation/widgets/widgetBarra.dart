import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarraDeTareas extends StatelessWidget {
  const BarraDeTareas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -40.h,
      left: 0,
      right: 0,
      child: Container(
        height: 100.h,
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            IconButton(
              iconSize: 80,
              icon: Image.asset('assets/icons/ajustes.png'),
              onPressed: () {},
            ),
            IconButton(
              iconSize: 80,
              icon: Image.asset('assets/icons/chat.png'),
              onPressed: () {},
            ),
            SizedBox(width: 50.w),
            IconButton(
              iconSize: 80,
              icon: Image.asset('assets/icons/stats.png'),
              onPressed: () {},
            ),
            IconButton(
              iconSize: 80,
              icon: Image.asset('assets/icons/videos.png'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}


