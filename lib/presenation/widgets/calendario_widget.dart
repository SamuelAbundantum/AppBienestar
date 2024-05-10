import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/helpers/csvLoader.dart';

class CalendarioWidget extends StatelessWidget {
  final CsvLoader _csvLoader = CsvLoader();
  late Future<Map<DateTime, List<String>>> _eventsFuture;

  CalendarioWidget({Key? key})
      : super(key: key) {
    _eventsFuture = _csvLoader.loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<DateTime, List<String>>>(
      future: _eventsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return TableCalendar(
            locale: 'es_ES',
            rowHeight: 100,
            startingDayOfWeek: StartingDayOfWeek.monday,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(fontSize: 24.sp),
              headerPadding: EdgeInsets.all(16),
            ),
            daysOfWeekHeight: 24.sp,
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(fontSize: 18.sp),
              weekendStyle: TextStyle(fontSize: 18.sp, color: Colors.red),
            ),
            availableGestures: AvailableGestures.all,
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            eventLoader: (day) {
              print("Tipo de datos para el día ${day}: ${snapshot.data![day].runtimeType}");
              return snapshot.data![day] ?? [];
            },
            calendarBuilders: CalendarBuilders(
              singleMarkerBuilder: (context, date, event) {
                print("Tipo de datos para el evento: ${event.runtimeType}");
                return Text(event.toString());  // Muestra la imagen.
              },
            ),
          );
        }
      },
    );
  }
}
