import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BotonGuardar extends StatelessWidget {
  final double ancho;
  final double largo;
  final double radio;
  final double tamanoTexto;

  BotonGuardar({required this.ancho, required this.largo, required this.radio, required this.tamanoTexto});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ancho.w,
      height: largo.h,
      child: ElevatedButton(
        onPressed: () {
          // Aquí puedes definir qué quieres que suceda cuando se presione el botón
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.green, // Color de fondo
          onPrimary: Colors.white, // Color del texto
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radio),
            side: BorderSide(color: Colors.black, width: 1),
          ),
        ),
        child: Text(
          'Guardar',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500, // Medium weight
            fontSize: tamanoTexto.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
