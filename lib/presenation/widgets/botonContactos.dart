import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactosBotones extends StatelessWidget {
  const ContactosBotones({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título fuera del cuadro
        Text(
          'Contactos',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 10.h),
        // Cuadro principal con dos botones
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.w),
            border: Border.all(color: Colors.black),
          ),
          child: Column(
            children: [
              _buildContactButton(context, 'WhatsApp', Icons.message),
              SizedBox(height: 20.h),
              _buildContactButton(context, 'Correo', Icons.email),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactButton(BuildContext context, String label, IconData iconData) {
    return Container(
      width: 300.w,
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.w),
        border: Border.all(color: Colors.black, width: 1.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w900,
                fontSize: 20.sp,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Icon(
              iconData,
              size: 24.sp,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
