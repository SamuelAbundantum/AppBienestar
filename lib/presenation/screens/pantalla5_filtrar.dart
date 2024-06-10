import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proyectoabundantum_appbienestar/config/router/rutas.dart';

import '../widgets/widgets.dart';


class Pantalla5Filtrar extends StatelessWidget {
  const Pantalla5Filtrar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Lista de imágenes y textos
    final List<Map<String, String>> categorias = [
      {'imagen': 'assets/icons/Family.svg', 'texto': 'Familia'},
      {'imagen': 'assets/icons/Food.svg', 'texto': 'Alimentación y nutrición'},
      {'imagen': 'assets/icons/PersonalGrowth.svg', 'texto': 'Crecimiento personal'},
      {'imagen': 'assets/icons/Body&VitalEnergy.svg', 'texto': 'Cuerpo físico y energía vital'},
      {'imagen': 'assets/icons/Health.svg', 'texto': 'Salud'},
      {'imagen': 'assets/icons/Sexuality.svg', 'texto': 'Sexualidad'},
      {'imagen': 'assets/icons/Rest&Sleep.svg', 'texto': 'Descanso y Sueño'},
      {'imagen': 'assets/icons/Money.svg', 'texto': 'Dinero'},
      {'imagen': 'assets/icons/Partnership.svg', 'texto': 'Pareja'},
      {'imagen': 'assets/icons/SocialRelationship.svg', 'texto': 'Redes sociales'},
      {'imagen': 'assets/icons/Spirituality.svg', 'texto': 'Espiritualidad y filosofía'},
      {'imagen': 'assets/icons/General.svg', 'texto': 'General'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFEAF2F8),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            // Fila para el botón de flecha izquierda y el texto "Filtrar" centrado
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Text(
                      'Filtrar',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 15.w,
                  top: 15.h,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      context.read<CubitRutas>().goPantalla5Recomendaciones();
                    },
                  ),
                ),
              ],
            ),
            // Uso del widget GridCategoriasWidget
            GridCategoriasWidget(categorias: categorias),
          ],
        ),
      ),
    );
  }
}
