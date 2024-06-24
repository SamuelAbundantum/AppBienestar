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
        onPressed: enabled ? onPressed : null,
        // Definimos el estilo del botón
        style: ButtonStyle(
          // Definimos el color de fondo del botón
          backgroundColor: enabled
              ? WidgetStateProperty.all(Colors.green)
              : WidgetStateProperty.all(Colors.grey),
          // Definimos el color del texto del botón
          foregroundColor: WidgetStateProperty.all(Colors.white),
          // Definimos la forma del botón
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              // Definimos el radio del borde del botón
              borderRadius: BorderRadius.circular(radio),
              // Definimos el color y ancho del borde del botón
              side: BorderSide(color: Colors.black, width: 1),
            ),
          ),
        ),
        // Definimos el contenido del botón
        child: Text(
          'Guardar',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
            fontSize: tamanoTexto.sp,
          ),
        ),
      ),
    );
  }
}
