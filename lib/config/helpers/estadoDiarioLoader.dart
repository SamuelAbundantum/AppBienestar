import '../../domain/entities/estadoDiario.dart';
import 'DataBase/dbSambami.dart';

class estadoDiarioLoader {
  Future<Map<DateTime, List<String>>> loadEvents() async {
    List<EstadoDiario> eventosDB = await DB.getAllEstadoDiario();
    Map<DateTime, List<String>> eventos = {};

    for (var evento in eventosDB) {
      DateTime fecha = DateTime(evento.fecha.year, evento.fecha.month, evento.fecha.day);
      String emoji;
      switch (evento.comoEstasHoy) {
        case ComoEstasHoy.muyBien:
          emoji = 'VeryGood.svg';
          break;
        case ComoEstasHoy.bien:
          emoji = 'Good.svg';
          break;
        case ComoEstasHoy.mal:
          emoji = 'Bad.svg';
          break;
        case ComoEstasHoy.muyMal:
          emoji = 'VeryBad.svg';
          break;
        default:
          emoji = '';
      }
      eventos.putIfAbsent(fecha, () => []).add(emoji);
    }

    return eventos;
  }
}

