import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pantalla1Menu extends StatelessWidget {
  const Pantalla1Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF2F8),
      body: Padding(
        padding: EdgeInsets.only(top: 20.h), // Aquí se ajusta el padding superior
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8.w), // Aquí se ajusta el padding alrededor
              child: CalendarioWidget(),
            ),
            BarraDeTareas(),
          ],
        ),
      ),
    );
  }
}
