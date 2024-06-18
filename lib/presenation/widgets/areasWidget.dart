import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class TopThreeAreasWidget extends StatefulWidget {
  final Map<String, String> topThreeData;
  const TopThreeAreasWidget({super.key, required this.topThreeData});

  @override
  State<StatefulWidget> createState() => _TopThreeAreasWidgetState();
}

class _TopThreeAreasWidgetState extends State<TopThreeAreasWidget> {
  Map<String, String> topThreeData = {};

  @override
  void initState() {
    super.initState();
    topThreeData = widget.topThreeData;
  }

  @override
  void didUpdateWidget(TopThreeAreasWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.topThreeData != widget.topThreeData) {
      topThreeData = widget.topThreeData;
      setState(() {});
    }
  }

  Color getColorByState(String state) {
    switch (state) {
      case 'muyBien':
        return Color(0xFFF8DE68);
      case 'bien':
        return Color(0xFFBFE4E1);
      case 'mal':
        return Color(0xFFCBD0D6);
      case 'muyMal':
        return Color(0xFFE69296);
      default:
        return Colors.grey;
    }
  }

  String formatLabel(String label) {
    Map<String, String> labelsMap = {
      'alimentacionNutricion': 'Alimentación y Nutrición',
      'crecimientoPersonal': 'Crecimiento Personal',
      'cuerpoFisicoEnergiaVital': 'Cuerpo Físico y Energía Vital',
      'descansoSueno': 'Descanso y Sueño',
      'dinero': 'Dinero',
      'espiritualidadFilosofia': 'Espiritualidad y Filosofía',
      'familia': 'Familia',
      'ocupacion': 'Ocupación',
      'pareja': 'Pareja',
      'redesSociales': 'Redes Sociales',
      'salud': 'Salud',
      'sexualidadGeneral': 'Sexualidad General'
    };

    return labelsMap[label] ?? label;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w, bottom: 8.h),
          child: Text(
            'Áreas',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(25.r),
          ),
          padding: EdgeInsets.all(8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: topThreeData.isEmpty
                ? [Center(child: CircularProgressIndicator())]
                : topThreeData.entries.map((entry) {
              List<String> values = entry.value.split(', ');
              if (values.length < 2) {
                return SizedBox.shrink();
              }
              String count = values[0];
              String state = values[1];
              Color color = getColorByState(state);
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(15.r),
                  gradient: LinearGradient(
                    colors: [color, Colors.white],
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Center(
                  child: Text(
                    '${count}x ${formatLabel(entry.key)}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
