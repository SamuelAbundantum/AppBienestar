import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proyectoabundantum_appbienestar/config/helpers/dbSambami.dart';

import '../../config/router/rutas.dart';

class BarraDeTareas extends StatelessWidget {
  const BarraDeTareas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -45.h,
      left: 0,
      right: 0,
      child: Container(
        height: 100.h,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 1.w,
                  width: MediaQuery.of(context).size.width /2.46,
                  color: Colors.black,
                ),
                Container(
                  height: 1.w,
                  width: MediaQuery.of(context).size.width / 2.46,
                  color: Colors.black,
                ),
              ],
            ),
            Align(
              alignment: Alignment(0, -2.8),
              child: Container(
                height: 70.r,
                width: 70.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 1.w),
                ),
                child: IconButton(
                  iconSize: 40.r,
                  icon: Image.asset('assets/icons/anyadir.png'),
                  onPressed: () {
                    context.read<CubitRutas>().goPantalla2SeleccionDeEstado();
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 40.r,
                    icon: Image.asset('assets/icons/stats.png'),
                    onPressed: () {
                      context.read<CubitRutas>().goPantalla3Estadisticas();
                    },
                  ),
                  IconButton(
                    iconSize: 40.r,
                    icon: Image.asset('assets/icons/videos.png'),
                    onPressed: () {
                    },
                  ),
                  SizedBox(width: 50.w),
                  IconButton(
                    iconSize: 40.r,
                    icon: Image.asset('assets/icons/chat.png'),
                    onPressed: () {},
                  ),
                  IconButton(
                    iconSize: 40.r,
                    icon: Image.asset('assets/icons/ajustes.png'),
                    onPressed: () {
                      context.read<CubitRutas>().goPantalla4Ajustes();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
