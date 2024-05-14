import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/router/rutas.dart';
import '../widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pantalla2SeleccionDeEstado extends StatelessWidget {
  const Pantalla2SeleccionDeEstado({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF2F8),
      body: Padding(
        padding: EdgeInsets.only(top: 20.h), // Aquí se ajusta el padding superior
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 25.h, // Ajusta estos valores para mover el botón
              left: 10.w, // Ajusta estos valores para mover el botón
              child: BotonFlechaIzquierda(
                onPressed: () {
                  context.read<CubitRutas>().goPantalla1Menu();
                },
              ),
            ),
            Positioned(
              top: 35.h, // Ajusta estos valores para mover el botón
              left: 250.w, // Ajusta estos valores para mover el botón
              child: BotonGuardar(
                ancho: 100,
                largo: 30,
                radio: 50,
                tamanoTexto: 16,
              ),
            ),
            Positioned(
              top: 30.h, // Ajusta estos valores para mover el widget de fecha
              left: 80.w, // Ajusta estos valores para mover el widget de fecha
              child: FechaWidget(),
            ),
            BarraDeTareas(), // Añade la BarraDeTareas
            // Aquí puedes añadir más widgets que se superpongan
          ],
        ),
      ),
    );
  }
}
