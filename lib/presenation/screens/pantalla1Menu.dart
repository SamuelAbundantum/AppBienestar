import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import '../../config/helpers/estadoDiarioLoader.dart';
import '../../config/helpers/pantallaDeCarga.dart';
import '../widgets/widgets.dart';

class Pantalla1Menu extends StatefulWidget {
  const Pantalla1Menu({Key? key}) : super(key: key);

  @override
  _Pantalla1MenuState createState() => _Pantalla1MenuState();
}

class _Pantalla1MenuState extends State<Pantalla1Menu> {
  late Future<Map<DateTime, List<String>>> _eventsFuture;

  @override
  void initState() {
    super.initState();
    _eventsFuture = _loadEvents();
  }

  Future<Map<DateTime, List<String>>> _loadEvents() async {
    final estadoDiarioLoader loader = estadoDiarioLoader();
    final events = await loader.loadEvents();
    await Future.delayed(const Duration(seconds: 2));
    return events;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
      minTextAdapt: true,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFEAF2F8),
      body: FutureBuilder<Map<DateTime, List<String>>>(
        future: _eventsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<DateTime, List<String>> events = snapshot.data ?? {};

            return Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: CalendarioWidget(events: events),
                  ),
                  const BarraDeTareas(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}