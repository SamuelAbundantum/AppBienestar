import '../../domain/entities/estadoDiario.dart';
import 'dbSambami.dart';

class estadoDiarioLoader {
  Future<Map<DateTime, List<String>>> loadEvents() async {

    // Consultar eventos desde la base de datos
    List<EstadoDiario> eventosDB = await DB.getAllEstadoDiario();

    // Procesar los resultados de la consulta
    Map<DateTime, List<String>> eventos = {};

    // Convertir los eventos de la base de datos al formato esperado por el widget de calendario
    for (var evento in eventosDB) {

      DateTime fecha= DateTime(evento.fecha.year, evento.fecha.month, evento.fecha.day);


      String emoji;
      switch (evento.comoEstasHoy) {
        case ComoEstasHoy.muyBien:
          emoji = '😁';
          break;
        case ComoEstasHoy.bien:
          emoji = '🙂';
          break;
        case ComoEstasHoy.mal:
          emoji = '☹️';
          break;
        case ComoEstasHoy.muyMal:
          emoji = '😡';
          break;
        default:
          emoji = '';
      }
      print('Emoji: $emoji');
      eventos.putIfAbsent(fecha, () => []).add(emoji);
    }

    print('Eventos cargados: $eventos');

    return eventos;
  }

  static Future<void> addTestData() async {
    List<EstadoDiario> testData = [
      EstadoDiario(
        id: 1,
        comoEstasHoy: ComoEstasHoy.muyMal,
        comoTeSientes: ComoTeSientes.enfadado,
        area: Area.dinero,
        texto: 'Hoy me siento bien, he tenido un día productivo.',
        foto: 'foto.jpg',
        fecha: DateTime(2024, 5, 1),
      ),
      EstadoDiario(
        id: 2,
        comoEstasHoy: ComoEstasHoy.mal,
        comoTeSientes: ComoTeSientes.preocupado,
        area: Area.pareja,
        texto: 'Hoy ha sido un mal día estoy triste',
        foto: 'foto.jpg',
        fecha: DateTime(2024, 5, 3),
      ),
      // ...otros eventos de prueba
    ];

    // Insertar eventos de prueba en la base de datos
    for (var evento in testData) {
      await DB.insertEstadoDiario(evento);
    }
  }

}
