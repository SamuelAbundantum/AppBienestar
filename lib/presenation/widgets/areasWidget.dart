import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/helpers/dbSambami.dart';

class TopThreeAreasWidget extends StatefulWidget {
  const TopThreeAreasWidget({super.key});

  @override
  State<StatefulWidget> createState() => _TopThreeAreasWidgetState();
}

class _TopThreeAreasWidgetState extends State<TopThreeAreasWidget> {
  Map<String, String> topThreeData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    topThreeData = await DB.getTopThreeEstadoDiarioCountsByArea();
    print("Fetched Data: $topThreeData");
    setState(() {});
  }

  Color getColorByState(String state) {
    print("Getting color for state: $state");
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
        return Colors.grey; // Color por defecto si el estado no coincide
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
                print("Invalid data format for entry: ${entry.value}");
                return SizedBox.shrink(); // Skip invalid entries
              }
              String count = values[0];
              String state = values[1];
              Color color = getColorByState(state);
              print("Entry: ${entry.key}, Count: $count, State: $state, Color: $color");
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
