import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                    selectedDate: selectedDay, // Pasar la fecha seleccionada a la nueva pantalla
                  ),
                ),
              );
            },
            calendarBuilders: CalendarBuilders(
              singleMarkerBuilder: (context, date, event) {
                print("Evento: $event");
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
