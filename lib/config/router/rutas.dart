import 'package:bloc/bloc.dart';
import 'package:go_router/go_router.dart';
import '../../presenation/screens/screens.dart';

final _rutasPublicas = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) => PrimerInicioPantalla1(),
      ),
      GoRoute(
          path: '/primer_inicio_pantalla1',
          builder: (context, state) => PrimerInicioPantalla1(),
      ),
      GoRoute(
          path: '/primer_inicio_pantalla2',
          builder: (context, state) => PrimerInicioPantalla2(),)
    ] );

class CubitRutas extends Cubit<GoRouter> {
  CubitRutas() : super(_rutasPublicas);

  void goPrimerInicioPantalla1() {
    state.go('/primer_inicio_pantalla1');
  }

  void goPrimerInicioPantalla2() {
    state.go('/primer_inicio_pantalla2');
  }
}