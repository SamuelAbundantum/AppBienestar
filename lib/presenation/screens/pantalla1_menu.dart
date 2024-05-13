import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class Pantalla1Menu extends StatelessWidget {
  const Pantalla1Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CalendarioWidget(),
            ),
            BarraDeTareas(),
          ],
        ),
      ),
    );
  }
}
