import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

class CsvLoader {
  Future<Map<DateTime, List<String>>> loadEvents() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/datos.csv');

    final fileExists = await file.exists();
    if (!fileExists) {
      await file.writeAsString('');
    }


    final csvString = await file.readAsString();
    final rows = const CsvToListConverter().convert(csvString);

    final events = <DateTime, List<String>>{};

    for (final row in rows) {
      final year = (row[5]);
      final month = (row[6]);
      final day = (row[7]);
      final date = DateTime.utc(year, month, day);

      final estado = row[0];

      String emoji;
      switch (estado) {
        case 'muyBien':
          emoji = '😁';
          break;
        case 'bien':
          emoji = '🙂';
          break;
        case 'mal':
          emoji = '☹️';
          break;
        case 'muyMal':
          emoji = '😡';
          break;
        default:
          emoji = '';
      }

      if (events[date] == null) {
        events[date] = [emoji];
      } else {
        events[date]!.add(emoji);
      }
    }

    return events;
  }


  Future<void> addTestData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/datos.csv');

    final rows = [
      ['muyMal', 'enfadado', 'dinero', 'Hoy me siento bien, he tenido un día productivo.', 'foto.jpg', '2024', '5', '1'],
      ['mal', 'preocupado', 'pareja', 'Hoy ha sido un mal día estoy triste', 'foto.jpg', '2024', '5', '3'],
      ['bien', 'triste', 'familia', 'Hoy no he hecho nada', 'foto.jpg', '2024', '5', '5'],
      ['muyBien', 'triste', 'salud', 'Otro día que no hago nada', 'foto.jpg', '2024', '5', '10'],
      ['muyBien', 'enfadado', 'ocupacion', 'Bueno, hoy estaba bien, la cosa va mejorando', 'foto.jpg', '2024', '5', '22'],
    ];

    final csvString = const ListToCsvConverter().convert(rows);

    await file.writeAsString(csvString);
  }


}
