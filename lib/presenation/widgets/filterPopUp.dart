import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterPopup extends StatelessWidget {
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
    {'imagen': 'assets/icons/Occupation.svg', 'texto': 'Ocupación'},
    {'imagen': 'assets/icons/General.svg', 'texto': 'General'},
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0.w),
        height: 400.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Seleccionar Género',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 1.0,
                ),
                itemCount: categorias.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop(categorias[index]['texto']);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            categorias[index]['imagen']!,
                            width: 60.w,
                            height: 60.h,
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            child: Text(
                              categorias[index]['texto']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
