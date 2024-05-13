import 'package:flutter/material.dart';

class Hora {
  int id;
  TimeOfDay hora;

  Hora({required this.id, required this.hora});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      // Guarda la hora como un string en el formato HH:mm
      'hora': '${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}',
    };
  }

  // Este método convierte el mapa a un objeto Hora
  factory Hora.fromMap(Map<String, dynamic> map) {
    return Hora(
      id: map['id'],
      // Convierte el string a TimeOfDay
      hora: TimeOfDay(
        hour: int.parse(map['hora'].split(':')[0]),
        minute: int.parse(map['hora'].split(':')[1]),
      ),
    );
  }


}
