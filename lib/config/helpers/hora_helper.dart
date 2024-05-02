import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HoraHelper {
  static StreamController<TimeOfDay> _controller = StreamController.broadcast();

  static Stream<TimeOfDay> get horaSeleccionadaStream {
    obtenerHoraSeleccionada().then((hora) {
      _controller.add(hora ?? TimeOfDay.now());
    });
    return _controller.stream;
  }

  static Future<TimeOfDay?> obtenerHoraSeleccionada() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      File file = File('${directory.path}/horaAviso.txt');
      if (await file.exists()) {
        String horaString = await file.readAsString();
        List<String> partesHora = horaString.split(':');
        int hora = int.parse(partesHora[0]);
        int minuto = int.parse(partesHora[1]);
        return TimeOfDay(hour: hora, minute: minuto);
      }
      return TimeOfDay.now();
    } catch (e) {
      print('Error al obtener la hora: $e');
      return TimeOfDay.now();
    }
  }

  static Future<void> guardarHoraSeleccionada(TimeOfDay hora) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      String horaString = '${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}';
      File file = File('${directory.path}/horaAviso.txt');
      await file.writeAsString(horaString);
      _controller.add(hora);
    } catch (e) {
      print('Error al guardar la hora: $e');
    }
  }

  static void cerrarStream() {
    _controller.close();
  }
}
