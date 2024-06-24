import '../../../domain/entities/estadoDiario.dart';
import 'dbSambami.dart';

class EstadoDiarioService {
  Future<Map<String, int>> getEstadoDiarioCounts(int month) async {
    List<EstadoDiario> estados = await DB.getAllEstadoDiario();
    estados = estados.where((estado) => estado.fecha.month == month).toList();

    Map<String, int> counts = {
      'muyBien': 0,
      'bien': 0,
      'mal': 0,
      'muyMal': 0,
    };
    for (var estado in estados) {
      String estadoHoy = estado.comoEstasHoy.toString().split('.').last;
      if (counts.containsKey(estadoHoy)) {
        counts[estadoHoy] = (counts[estadoHoy] ?? 0) + 1;
      }
    }
    return counts;
  }

  Future<Map<String, String>> getTopThreeEstadoDiarioCountsByArea(int month) async {
    List<EstadoDiario> estados = await DB.getAllEstadoDiario();
    estados = estados.where((estado) => estado.fecha.month == month).toList();

    Map<String, Map<String, int>> counts = {
      'alimentacionNutricion': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'crecimientoPersonal': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'dineroFinanzasInversiones': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'ejercicioActividadFisica': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'familia': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'parejaAmigosVidaSocial': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'recreacionAficionesDiversion': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'servicioAportacionesSociedad': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'trabajoEstudiosVidaProfesional': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'vidaIntelectualDesarrolloMental': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
    };
    for (var estado in estados) {
      String area = estado.area.toString().split('.').last;
      String estadoHoy = estado.comoEstasHoy.toString().split('.').last;
      if (counts.containsKey(area)) {
        counts[area]!['count'] = (counts[area]!['count'] ?? 0) + 1;
        counts[area]![estadoHoy] = (counts[area]![estadoHoy] ?? 0) + 1;
      }
    }

    var sortedCounts = counts.entries.toList()
      ..sort((a, b) => b.value['count']!.compareTo(a.value['count']!));
    var topThree = sortedCounts.take(3).toList();
    Map<String, String> result = {};
    for (var entry in topThree) {
      var area = entry.key;
      var data = entry.value;
      var mostCommonState = data.entries
          .where((entry) => entry.key != 'count')
          .reduce((a, b) => a.value > b.value ? a : b);
      result[area] = '${data['count']}, ${mostCommonState.key}';
    }
    return result;
  }
}
