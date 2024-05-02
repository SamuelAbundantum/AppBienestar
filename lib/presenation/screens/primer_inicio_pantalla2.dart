import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/router/rutas.dart';
import '../widgets/widgets.dart';

class PrimerInicioPantalla2 extends StatelessWidget {
  const PrimerInicioPantalla2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFB973FF),
      body: Stack(
        children: [
          Positioned(
            top: screenHeight * -0.02,
            left: screenWidth * 0.28,
            child: Image.asset(
              'assets/images/reloj.png',
              width: screenWidth * 0.45,
              height: screenHeight * 0.45,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.065),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RectanguloPequenyoIndicador(color: Colors.grey),
                    SizedBox(width: 30.0),
                    RectanguloPequenyoIndicador(color: Colors.black),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.89,
            left: screenWidth * 0.10,
            child: BotonContinuar(
              onPressed: () {
                context.read<CubitRutas>().goPrimerInicioPantalla1();
              },
            ),
          ),
          Positioned(
            top: screenHeight * 0.68,
            left: screenWidth * 0.10,
            child: BotonHora(),
          ),
          Positioned(
            top: screenHeight * 0.34,
            left: screenWidth * 0.12,
            child: Text(
              'Ajusta tu recordatorio',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.42,
            left: screenWidth * 0.1,
            child: Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.15,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.20),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Recuerda ser feliz.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Selecciona una hora para completar el día.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
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
