import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/router/rutas.dart';
import '../widgets/widgets.dart';

class Pantalla4Ajustes extends StatefulWidget {
  const Pantalla4Ajustes({Key? key}) : super(key: key);

  @override
  _Pantalla4AjustesState createState() => _Pantalla4AjustesState();
}

class _Pantalla4AjustesState extends State<Pantalla4Ajustes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF2F8),
      body: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 25.h,
              left: 10.w,
              child: BotonFlechaIzquierda(
                onPressed: () {
                  context.read<CubitRutas>().goPantalla1Menu();
                },
              ),
            ),
            Positioned(
              top: 35.h,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Ajustes',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100.h,
              left: 25.w,
              right: 25.w,
              bottom: 100.h,
              child: SizedBox(
                height: 475.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AjustesWidgetHora(),
                      SizedBox(height: 40.h),
                      ContactosBotones(),
                      SizedBox(height: 35.h),
                      EnlacesLegales(),
                    ],
                  ),
                ),
              ),
            ),
            BarraDeTareas(),
          ],
        ),
      ),
    );
  }
}