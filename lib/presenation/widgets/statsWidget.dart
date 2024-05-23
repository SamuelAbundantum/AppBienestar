import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/helpers/dbSambami.dart';
class PieChartSample extends StatefulWidget {
  const PieChartSample({super.key});
  @override
  State<StatefulWidget> createState() => _PieChartSampleState();
}
class _PieChartSampleState extends State<PieChartSample> {
  int touchedIndex = 0;
  Map<String, double> dataMap = {};
  @override
  void initState() {
    super.initState();
    fetchData();
  }
  Future<void> fetchData() async {
    Map<String, int> counts = await DB.getEstadoDiarioCounts();
    int total = counts.values.fold(0, (sum, value) => sum + value);
    dataMap = counts.map((key, value) => MapEntry(key, (value / total) * 100));
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(50.r),
      ),
      padding: EdgeInsets.all(8.w),
      child: AspectRatio(
        aspectRatio: 1.3,
        child: AspectRatio(
          aspectRatio: 1,
          child: dataMap.isEmpty
              ? Center(child: CircularProgressIndicator())
              : PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              sections: showingSections(),
            ),
          ),
        ),
      ),
    );
  }
  List<PieChartSectionData> showingSections() {
    List<String> categories = ['muyBien', 'bien', 'mal', 'muyMal'];
    List<Color> colors = [
      Color(0xFFF8DE68),
      Color(0xFFBFE4E1),
      Color(0xFFE69296),
      Color(0xFFCBD0D6)
    ];
    List<String> icons = [
      'assets/icons/muyBien.svg',
      'assets/icons/bien.svg',
      'assets/icons/muyMal.svg',
      'assets/icons/mal.svg'
    ];
    return List.generate(dataMap.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.sp : 16.sp;
      final radius = isTouched ? 110.w : 100.w;
      final widgetSize = isTouched ? 55.w : 40.w;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      return PieChartSectionData(
        color: colors[i],
        value: dataMap[categories[i]],
        title: '${dataMap[categories[i]]!.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
        badgeWidget: _Badge(
          icons[i],
          size: widgetSize,
          borderColor: Colors.black,
        ),
        badgePositionPercentageOffset: .98,
      );
    });
  }
}
class _Badge extends StatelessWidget {
  const _Badge(
      this.svgAsset, {
        required this.size,
        required this.borderColor,
      });
  final String svgAsset;
  final double size;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: SvgPicture.asset(
          svgAsset,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}