import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RectanguloPequenyoIndicador extends StatelessWidget {
  final Color color;

  const RectanguloPequenyoIndicador({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w, // Utiliza .w para escalar el ancho de la pantalla
      height: 10.h, // Utiliza .h para escalar la altura de la pantalla
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0), // Para hacer los bordes redondeados
        border: Border.all(color: Colors.black, width: 1.0), // Para el borde negro de 1 de ancho
      ),
    );
  }
}

