import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../../domain/entities/estadoDiario.dart';
import '../../../domain/entities/hora.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'sambami.db'),
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE estadoDiario (id INTEGER PRIMARY KEY, comoEstasHoy TEXT, comoTeSientes TEXT, area TEXT, texto TEXT, foto TEXT, fecha TEXT)",
        );

        db.execute(
          "CREATE TABLE hora (id INTEGER PRIMARY KEY, hora TEXT)",
        );
      },
      version: 1,
    );
  }

  static EstadoDiario mapToEstadoDiario(Map<String, dynamic> map) {
    return EstadoDiario(
      id: map['id'],
      comoEstasHoy: ComoEstasHoy.values.firstWhere((e) => e.toString() == map['comoEstasHoy']),
      comoTeSientes: ComoTeSientes.values.firstWhere((e) => e.toString() == map['comoTeSientes']),
      area: Area.values.firstWhere((e) => e.toString() == map['area']),
      texto: map['texto'],
      foto: map['foto'],
      fecha: DateTime.parse(map['fecha']),
    );
  }

  static Future<EstadoDiario?> getEstadoDiarioById(int id) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> maps = await database.query('estadoDiario', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return mapToEstadoDiario(maps.first);
    } else {
      return null;
    }
  }

  static Future<List<EstadoDiario>> getAllEstadoDiario() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> todosEstadosDiarios = await database.query('estadoDiario');

    return todosEstadosDiarios.map((map) => mapToEstadoDiario(map)).toList();
  }

  static Future<EstadoDiario?> getEstadoDiarioByDate(String date) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> maps = await database.query(
        'estadoDiario',
        where: 'fecha = ?',
        whereArgs: [date]
    );

    if (maps.isNotEmpty) {
      return mapToEstadoDiario(maps.first);
    } else {
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

  static Future<void> deleteAllEstadoDiario() async {
    Database database = await _openDB();
    await database.delete('estadoDiario');
  }

  static Future<int> insertEstadoDiario(EstadoDiario estadoDiario) async {
    Database database = await _openDB();
    return database.insert('estadoDiario', estadoDiario.toMap());
  }

  static Future<int> updateEstadoDiario(EstadoDiario estadoDiario) async {
    Database database = await _openDB();
    return database.update('estadoDiario', estadoDiario.toMap(), where: 'id = ?', whereArgs: [estadoDiario.id]);
  }

  static Future<int> insertHora(Hora hora) async {
    Database database = await _openDB();
    int insertedId = await database.insert('hora', hora.toMap());
    return insertedId;
  }

  static Future<Hora> getHora(int id) async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> maps = await database.query('hora', where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Hora.fromMap(maps.first);
    } else {
      return Hora(id: id, hora: TimeOfDay.now());
    }
  }

  static Future<int> updateHora(Hora hora) async {
    Database database = await _openDB();
    try {
      int rowsAffected = await database.update('hora', hora.toMap(), where: 'id = ?', whereArgs: [hora.id]);
      return rowsAffected;
    } catch (e) {
      return -1;
    }
  }
}