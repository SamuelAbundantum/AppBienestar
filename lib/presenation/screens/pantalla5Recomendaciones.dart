import 'package:flutter/material.dart';
import 'package:proyectoabundantum_appbienestar/presenation/widgets/videosYoutubeWidget.dart';
import '../widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pantalla5Recomendaciones extends StatelessWidget {
  const Pantalla5Recomendaciones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF2F8),
      body: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8.w),
              child: VideosYoutubeWidget(),
            ),
            BarraDeTareas(),
          ],
        ),
      ),
    );
  }
}
