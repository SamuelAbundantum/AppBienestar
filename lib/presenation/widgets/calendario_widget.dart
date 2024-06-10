import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/helpers/estadoDiarioLoader.dart';
import '../screens/screens.dart';

class CalendarioWidget extends StatelessWidget {
  final estadoDiarioLoader _estadoDiarioLoader = estadoDiarioLoader();
  late Future<Map<DateTime, List<String>>> _eventsFuture;

  CalendarioWidget({Key? key}) : super(key: key) {
    _eventsFuture = _estadoDiarioLoader.loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(360, 690), minTextAdapt: true);

    return FutureBuilder<Map<DateTime, List<String>>>(
      future: _eventsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Text('Error: ${snapshot.error}');
        } else {
          print('Eventos cargados2: ${snapshot.data}');
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
              var eventsForDay = snapshot.data![dayWithoutTime] ?? [];
              print("Día: $day");
              print("Eventos para el día: $eventsForDay");
              return eventsForDay;
            },
            onDaySelected: (selectedDay, focusedDay) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Pantalla2SeleccionDeEstado(
                    selectedDate: selectedDay,
                  ),
                ),
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
      },
    );
  }
}
