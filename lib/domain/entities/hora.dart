import 'package:flutter/material.dart';

class Hora {
  int id;
  TimeOfDay hora;

  Hora({required this.id, required this.hora});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hora': '${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}',
    };
  }

  factory Hora.fromMap(Map<String, dynamic> map) {
    return Hora(
      id: map['id'],
      hora: TimeOfDay(
        hour: int.parse(map['hora'].split(':')[0]),
        minute: int.parse(map['hora'].split(':')[1]),
      ),
    );
  }


}
