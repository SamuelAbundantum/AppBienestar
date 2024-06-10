import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectoabundantum_appbienestar/config/router/rutas.dart';

class MenuButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [ // Añadimos una separación entre las dos palabras
        GestureDetector(
          onTap: () {
            context.read<CubitRutas>().goPantalla5Filtrar();
          },
          child: Text(
            'Filtrar',
            style: TextStyle(
              fontFamily: 'Poppins', // Usamos 'Poppins' directamente
              fontSize: 20, // Aumentamos el tamaño de la fuente
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
