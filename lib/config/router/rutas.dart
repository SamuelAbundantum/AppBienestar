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
          builder: (context, state) => PrimerInicioPantalla2(),
      ),
      GoRoute(
          path: '/pantalla1_menu',
          builder: (context, state) => Pantalla1Menu(),
      ),
      GoRoute(
          path: '/pantalla2_seleccionDeEstado',
          builder: (context, state) => Pantalla2SeleccionDeEstado(selectedDate: DateTime.now(),),
      ),
      GoRoute(
          path: '/pantalla4_ajustes',
          builder: (context, state) => Pantalla4Ajustes(),
      ),
      GoRoute(
          path: '/pantalla3_estadisticas',
          builder: (context, state) => Pantalla3Estadisticas(),
      )
    ] );

class CubitRutas extends Cubit<GoRouter> {

  CubitRutas() : super(_rutasPublicas);

  void goPrimerInicioPantalla1() {
    state.go('/primer_inicio_pantalla1');
  }

  void goPrimerInicioPantalla2() {
    state.go('/primer_inicio_pantalla2');
  }

  void goPantalla1Menu() {
    state.go('/Pantalla1_menu');
  }

  void goPantalla2SeleccionDeEstado() {
    state.go('/pantalla2_seleccionDeEstado');
  }

  void goPantalla4Ajustes() {
    state.go('/pantalla4_ajustes');
  }

  void goPantalla3Estadisticas() {
    state.go('/pantalla3_estadisticas');
  }

}