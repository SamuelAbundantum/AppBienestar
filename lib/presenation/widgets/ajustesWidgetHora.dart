import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'boton_hora.dart'; // Asegúrate de que la ruta sea correcta para importar el archivo

class AjustesWidgetHora extends StatefulWidget {
  const AjustesWidgetHora({Key? key}) : super(key: key);

  @override
  _AjustesWidgetHoraState createState() => _AjustesWidgetHoraState();
}

class _AjustesWidgetHoraState extends State<AjustesWidgetHora> {
  bool _isSwitchOn = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título fuera del cuadro
        Text(
          'Hora de notificación',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 10.h),
        // Cuadro principal con BotonHora y Rectángulo con Switch
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.w),
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            children: [
              BotonHora(
                width: 300,
                height: 65,
                textStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w900,
                  fontSize: 20.sp, // Utiliza .sp para escalar el tamaño de la fuente
                ),
              ), // Widget de hora importado
              SizedBox(height: 20.h),
              // Rectángulo con Switch
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w), // Reducir padding para hacerlo más fino
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.w),
                  border: Border.all(color: Colors.black), // Borde negro opcional
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Activar recordatorio',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp, // Reducir tamaño de fuente si es necesario
                      ),
                    ),
                    Transform.scale(
                      scale: 1.5, // Ajusta este valor para cambiar el tamaño del Switch
                      child: Switch(
                        value: _isSwitchOn,
                        onChanged: (bool value) {
                          setState(() {
                            _isSwitchOn = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
