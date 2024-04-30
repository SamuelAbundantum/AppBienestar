import 'package:flutter/material.dart';
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
            top: screenHeight * -0.29,
            left: screenWidth * 0.01,
            child: Image.asset(
              'assets/images/SAMBAMI.png',
              width: screenWidth,
              height: screenHeight,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.065),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RectanguloPequenyoIndicador(color: Colors.black),
                    SizedBox(width: 30.0),
                    RectanguloPequenyoIndicador(color: Colors.grey),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: screenHeight * 0.89,
            left: screenWidth * 0.10,
            child: BotonContinuar(),
          ),
          Positioned(
            top: screenHeight * 0.33,
            left: screenWidth * 0.26,
            child: Text(
              'Bienvenido a',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.38,
            left: screenWidth * 0.10,
            child: Text(
              'Sambami Paz Interior',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.45,
            left: screenWidth * 0.1,
            child: Container(
              width: screenWidth * 0.8,
              height: screenHeight * 0.4,
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
                      'Sambami te acompaña en tu viaje emocional, mostrándote que cada desafío es una oportunidad para encontrar armonía y alegría.',
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
                      'Con cada interacción, te ayuda a reconocer y transformar tus emociones, inspirándote a danzar a través de la vida con resiliencia y espíritu festivo. ',
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
                      'En Sambami, cada dificultad es un paso más hacia la felicidad.',
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
