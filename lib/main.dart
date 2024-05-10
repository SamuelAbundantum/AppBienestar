import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectoabundantum_appbienestar/config/router/rutas.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proyectoabundantum_appbienestar/presenation/blocs/blocs.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  initializeDateFormatting('es'); // Inicializa los datos de localización para español de forma síncrona

  runApp(const BlocsProvider());
}


class BlocsProvider extends StatelessWidget {
  const BlocsProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CubitRutas()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rutas = context.watch<CubitRutas>().state;

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: rutas,
    );
  }
}
