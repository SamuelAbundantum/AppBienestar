import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BotonGuardar extends StatelessWidget {
  final double ancho;
  final double largo;
  final double radio;
  final double tamanoTexto;
  final bool enabled;
  final VoidCallback? onPressed;

  BotonGuardar({
    required this.ancho,
    required this.largo,
    required this.radio,
    required this.tamanoTexto,
    this.enabled = true,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ancho.w,
      height: largo.h,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null, // Usar el callback
        style: ElevatedButton.styleFrom(
          primary: enabled ? Colors.green : Colors.grey, // Color de fondo
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