import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/entities/estadoDiario.dart';
import '../../domain/entities/hora.dart';


class DB {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'sambami.db'),
        onCreate: (db, version) {
          db.execute(
            "CREATE TABLE estadoDiario (id INTEGER PRIMARY KEY, comoEstasHoy TEXT, comoTeSientes TEXT, area TEXT, texto TEXT, foto TEXT, fecha TEXT)",

          );

          db.execute("CREATE TABLE hora (id INTEGER PRIMARY KEY, hora TEXT)"
          );

        }, version: 1,
    );
  }

  static Future<EstadoDiario?> getEstadoDiarioByDate(String date) async {
    // Abre la base de datos.
    Database database = await _openDB();

    // Convierte la fecha a cadena en el formato ISO 8601, que incluye la hora.

    // Ejecuta la consulta SQL para buscar el estado diario por la fecha exacta.
    final List<Map<String, dynamic>> maps = await database.query(
        'estadoDiario',
        where: 'fecha = ?',
        whereArgs: [date]
    );

    // Si se encuentran resultados, crea y devuelve un objeto EstadoDiario.
    if (maps.isNotEmpty) {
      return EstadoDiario(
        id: maps.first['id'],
        comoEstasHoy: ComoEstasHoy.values.firstWhere((e) => e.toString() == maps.first['comoEstasHoy']),
        comoTeSientes: ComoTeSientes.values.firstWhere((e) => e.toString() == maps.first['comoTeSientes']),
        area: Area.values.firstWhere((e) => e.toString() == maps.first['area']),
        texto: maps.first['texto'],
        foto: maps.first['foto'],
        fecha: DateTime.parse(maps.first['fecha']),
      );
    } else {
      // Si no se encuentra nada, devuelve null.
      return null;
    }
  }


  static Future<void> insertOrUpdateEstadoDiario(EstadoDiario estadoDiario) async {
    Database database = await _openDB();

    List<Map<String, dynamic>> result = await database.query(
      'estadoDiario',
      where: 'id = ?',
      whereArgs: [estadoDiario.id],
    );

    if (result.isNotEmpty) {
      await updateEstadoDiario(estadoDiario);
    } else {
      await insertEstadoDiario(estadoDiario);
    }
  }

  static Future<Map<String, int>> getEstadoDiarioCounts(int month) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> estados = await database.rawQuery(
      'SELECT * FROM estadoDiario WHERE strftime("%m", fecha) = ?', [month.toString().padLeft(2, '0')],
    );
    Map<String, int> counts = {
      'muyBien': 0,
      'bien': 0,
      'mal': 0,
      'muyMal': 0,
    };
    for (var estado in estados) {
      String estadoHoy = estado['comoEstasHoy'].toString().split('.').last;
      if (counts.containsKey(estadoHoy)) {
        counts[estadoHoy] = (counts[estadoHoy] ?? 0) + 1;
      }
    }
    return counts;
  }

  static Future<Map<String, String>> getTopThreeEstadoDiarioCountsByArea(int month) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> estados = await database.rawQuery(
      'SELECT * FROM estadoDiario WHERE strftime("%m", fecha) = ?', [month.toString().padLeft(2, '0')],
    );
    Map<String, Map<String, int>> counts = {
      'alimentacionNutricion': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'crecimientoPersonal': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'cuerpoFisicoEnergiaVital': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'descansoSueno': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'dinero': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'espiritualidadFilosofia': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'familia': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'ocupacion': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'pareja': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'redesSociales': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'salud': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
      'sexualidadGeneral': {'count': 0, 'muyBien': 0, 'bien': 0, 'mal': 0, 'muyMal': 0},
    };
    for (var estado in estados) {
      String area = estado['area'].toString().split('.').last;
      String estadoHoy = estado['comoEstasHoy'].toString().split('.').last;
      if (counts.containsKey(area)) {
        counts[area]!['count'] = (counts[area]!['count'] ?? 0) + 1;
        counts[area]![estadoHoy] = (counts[area]![estadoHoy] ?? 0) + 1;
      }
    }
    var sortedCounts = counts.entries.toList()
      ..sort((a, b) => b.value['count']!.compareTo(a.value['count']!));
    // Take the top three entries
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


  static Future<void> deleteAllEstadoDiario() async {
    Database database = await _openDB();
    await database.delete('estadoDiario');
  }



  static Future<int> insertEstadoDiario (EstadoDiario estadoDiario) async{
      Database database = await _openDB();

      return database.insert('estadoDiario', estadoDiario.toMap());
  }

  static Future<int> updateEstadoDiario (EstadoDiario estadoDiario) async{
    Database database = await _openDB();
    return database.update('estadoDiario', estadoDiario.toMap(), where: 'id = ?', whereArgs: [estadoDiario.id]);
  }

  static Future<EstadoDiario?> getEstadoDiarioById(int id) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> maps =
    await database.query('estadoDiario', where: 'id = ?', whereArgs: [id]);

    if (maps.length > 0) {
      return EstadoDiario(
        id: maps.first['id'],
        comoEstasHoy: ComoEstasHoy.values.firstWhere((e) => e.toString() == maps.first['comoEstasHoy']),
        comoTeSientes: ComoTeSientes.values.firstWhere((e) => e.toString() == maps.first['comoTeSientes']),
        area: Area.values.firstWhere((e) => e.toString() == maps.first['area']),
        texto: maps.first['texto'],
        foto: maps.first['foto'],
        fecha: DateTime.parse(maps.first['fecha']),
      );
    } else {
      return null;
    }
  }


  static Future<List<EstadoDiario>> getAllEstadoDiario() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> todosEstadosDiarios = await database.query('estadoDiario');

    return List.generate(todosEstadosDiarios.length,
            (i) => EstadoDiario(
          id: todosEstadosDiarios[i]['id'],
          comoEstasHoy: ComoEstasHoy.values.firstWhere((e) => e.toString() == todosEstadosDiarios[i]['comoEstasHoy']),
              comoTeSientes: ComoTeSientes.values.firstWhere((e) => e.toString() == todosEstadosDiarios[i]['comoTeSientes']),
              area: Area.values.firstWhere((e) => e.toString() == todosEstadosDiarios[i]['area']),
              texto: todosEstadosDiarios[i]['texto'],
              foto: todosEstadosDiarios[i]['foto'],
              fecha: DateTime.parse(todosEstadosDiarios[i]['fecha']),



        )
    );
  }

  static Future<int> insertHora(Hora hora) async {
    Database database = await _openDB();
    print('Insertando hora en la base de datos: ${hora.toMap()}');
    int insertedId = await database.insert('hora', hora.toMap());
    print('ID de la hora insertada: $insertedId');
    return insertedId;
  }


  static Future<Hora> getHora(int id) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> maps = await database.query('hora', where: 'id = ?', whereArgs: [id]);

    if (maps.length > 0) {
      return Hora.fromMap(maps.first);
    } else {
      return Hora(id: id, hora: TimeOfDay.now());
    }
  }

  static Future<int> updateHora(Hora hora) async {
    Database database = await _openDB();
    print('Actualizando hora en la base de datos: ${hora.toMap()}');
    try {
      int rowsAffected = await database.update('hora', hora.toMap(), where: 'id = ?', whereArgs: [hora.id]);
      print('Se actualizó la hora correctamente. Filas afectadas: $rowsAffected');
      return rowsAffected;
    } catch (e) {
      print('Error al actualizar la hora: $e');
      return -1;
    }
  }




}