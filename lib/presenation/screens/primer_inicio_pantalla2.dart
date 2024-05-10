import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/router/rutas.dart';
import '../widgets/widgets.dart';

class PrimerInicioPantalla2 extends StatelessWidget {
  const PrimerInicioPantalla2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: const Color(0xFFB973FF),
      body: Stack(
        children: [
          Positioned(
            top: 0.01.sh,
            left: 0.28.sw,
            child: Image.asset(
              'assets/images/reloj.png',
              width: 0.45.sw,
              height: 0.45.sh,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.065.sh),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RectanguloPequenyoIndicador(color: Colors.grey),
                    SizedBox(width: 30.w),
                    RectanguloPequenyoIndicador(color: Colors.black),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 0.89.sh,
            left: 0.10.sw,
            child: BotonContinuar(
              onPressed: () {
                context.read<CubitRutas>().goPantalla1Menu();
              },
            ),
          ),
          Positioned(
            top: 0.68.sh,
            left: 0.07.sw,
            child: BotonHora(),
          ),
          Positioned(
            top: 0.37.sh,
            left: 0.08.sw,
            child: Text(
              'Ajusta tu recordatorio',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Positioned(
            top: 0.45.sh,
            left: 0.05.sw,
            child: Container(
              width: 0.9.sw,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.20),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Recuerda ser feliz.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Selecciona una hora para completar el día.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
