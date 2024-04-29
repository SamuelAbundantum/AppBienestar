import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyectoabundantum_appbienestar/presenation/screens/screens.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Cambia esto al color que prefieras
      statusBarIconBrightness: Brightness.dark, // Usa Brightness.dark para iconos oscuros
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PrimerInicioPantalla1(),
      ),
    );
  }
}