import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'botonHora.dart';

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
        Text(
          'Hora de notificación',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 10.h),
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
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 20.h),
              // Rectángulo con Switch
              Container(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50.w),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Activar recordatorio',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                    Transform.scale(
                      scale: 1.5,
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
