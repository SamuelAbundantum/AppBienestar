import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/router/rutas.dart';

class BotonContinuar extends StatelessWidget {
  const BotonContinuar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<CubitRutas>().goPrimerInicioPantalla2();
      },
      child: Container(
        width: 315,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.white, width: 3),
        ),
        child: Center(
          child: Text(
            'Continuar',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w900,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

