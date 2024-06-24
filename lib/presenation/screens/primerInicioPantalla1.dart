import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/router/rutas.dart';
import '../widgets/widgets.dart';

class PrimerInicioPantalla1 extends StatelessWidget {
  const PrimerInicioPantalla1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: const Color(0xFF3EB6C4),
      body: Stack(
        children: [
          Positioned(
            top: -0.29.sh,
            left: 0.01.sw,
            child: Image.asset(
              'assets/images/SAMBAMI.png',
              width: 1.sw,
              height: 1.sh,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.065.sh),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RectanguloPequenyoIndicador(color: Colors.black),
                    SizedBox(width: 30.w),
                    RectanguloPequenyoIndicador(color: Colors.grey),
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
                context.read<CubitRutas>().goPrimerInicioPantalla2();
              },
            ),
          ),
          Positioned(
            top: 0.33.sh,
            left: 0.26.sw,
            child: Text(
              'Bienvenido a',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Positioned(
            top: 0.38.sh,
            left: 0.10.sw,
            child: Text(
              'Sambami Paz Interior',
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
            left: 0.1.sw,
            child: Container(
              width: 0.8.sw,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.20),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sambami te acompaña en tu viaje emocional, mostrándote que cada desafío es una oportunidad para encontrar armonía y alegría.',
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
                      'Con cada interacción, te ayuda a reconocer y transformar tus emociones, inspirándote a danzar a través de la vida con resiliencia y espíritu festivo. ',
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
                      'En Sambami, cada dificultad es un paso más hacia la felicidad.',
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
