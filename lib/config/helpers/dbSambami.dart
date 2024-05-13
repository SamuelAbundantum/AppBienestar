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

  static Future<int> insertEstadoDiario (EstadoDiario estadoDiario) async{
      Database database = await _openDB();

      return database.insert('estadoDiario', estadoDiario.toMap());
  }

  static Future<int> updateEstadoDiario (EstadoDiario estadoDiario) async{
    Database database = await _openDB();
    return database.update('estadoDiario', estadoDiario.toMap(), where: 'id = ?', whereArgs: [estadoDiario.id]);
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
      // Si no se encuentra ninguna hora, devuelve la hora actual
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
      return -1; // O cualquier valor que indique un error
    }
  }




}