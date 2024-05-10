import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/estadoDiario.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/widgets.dart';

class Pantalla1Menu extends StatelessWidget {
  const Pantalla1Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: const Color(0xFFFFFFFF),
          body: Padding(
            padding: EdgeInsets.only(top: 50.0), // Añade un padding en la parte superior
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0), // Añade un padding alrededor del calendario
                  child: CalendarioWidget(), // Pasa los eventos al CalendarioWidget
                ),
              ],
            ),
          ),
        );
      }
  }



