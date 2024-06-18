import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectoabundantum_appbienestar/config/router/rutas.dart';

class MenuButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            //context.read<CubitRutas>().goPantalla5Filtrar();
          },
          child: Text(
            'Filtrar',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
