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
        style: ButtonStyle(
          backgroundColor: enabled
              ? WidgetStateProperty.all(Colors.green)
              : WidgetStateProperty.all(Colors.grey),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radio),
              side: BorderSide(color: Colors.black, width: 1),
            ),
          ),
        ),
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
