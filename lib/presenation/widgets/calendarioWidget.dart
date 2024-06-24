import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../config/router/rutas.dart';

class CalendarioWidget extends StatelessWidget {
  final Map<DateTime, List<String>> events;

  CalendarioWidget({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'es_ES',
      rowHeight: 85.h,
      startingDayOfWeek: StartingDayOfWeek.monday,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(fontSize: 24.sp),
        headerPadding: EdgeInsets.all(16.h),
      ),
      daysOfWeekHeight: 24.h,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(fontSize: 18.sp),
        weekendStyle: TextStyle(fontSize: 18.sp, color: Colors.red),
      ),
      availableGestures: AvailableGestures.all,
      focusedDay: DateTime.now(),
      firstDay: DateTime(2010, 10, 16),
      lastDay: DateTime(2030, 3, 14),
      eventLoader: (day) {
        DateTime dayWithoutTime = DateTime(day.year, day.month, day.day);
        return events[dayWithoutTime] ?? [];
      },
      onDaySelected: (selectedDay, focusedDay) {
        context.read<CubitRutas>().goPantalla2SeleccionDeEstado(
            selectedDate: selectedDay
        );
      },
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 37.w,
                    height: 37.h,
                    child: SvgPicture.asset(
                      'assets/icons/${events.first}',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
