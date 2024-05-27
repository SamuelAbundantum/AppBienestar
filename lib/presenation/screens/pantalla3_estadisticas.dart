import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/router/rutas.dart';
import '../widgets/widgets.dart'; // Asegúrate de importar tus widgets personalizados

class Pantalla3Estadisticas extends StatefulWidget {
  const Pantalla3Estadisticas({Key? key}) : super(key: key);

  @override
  _Pantalla3EstadisticasState createState() => _Pantalla3EstadisticasState();
}

class _Pantalla3EstadisticasState extends State<Pantalla3Estadisticas> {
  // Método para obtener el nombre del mes actual en español
  String getMesActual() {
    DateTime now = DateTime.now();
    List<String> meses = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return meses[now.month - 1];
  }

  @override
  Widget build(BuildContext context) {
    String mesActual = getMesActual(); // Obtiene el nombre del mes actual

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
                  mesActual, // Muestra el mes actual
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
                      PieChartSample(),
                      SizedBox(height: 35.h),
                      TopThreeAreasWidget()
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
