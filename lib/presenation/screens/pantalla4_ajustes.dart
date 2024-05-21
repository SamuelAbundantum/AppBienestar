import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/router/rutas.dart';
import '../widgets/widgets.dart'; // Asegúrate de importar tus widgets personalizados

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
                    fontSize: 24.sp, // Tamaño grande
                    fontWeight: FontWeight.w600, // Semi bold
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100.h,
              left: 25.w,
              right: 25.w,
              bottom: 100.h, // Ajusta el bottom para no cubrir la barra de tareas
              child: SizedBox(
                height: 475.h, // Altura del área visible del ScrollView
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AjustesWidgetHora(),
                      SizedBox(height: 40.h), // Espacio entre los widgets
                      ContactosBotones(),
                      SizedBox(height: 35.h), // Espacio entre los widgets y los enlaces legales
                      EnlacesLegales(), // Agregar los enlaces legales
                    ],
                  ),
                ),
              ),
            ),
            BarraDeTareas(), // Añade la BarraDeTareas si es necesario
          ],
        ),
      ),
    );
  }
}