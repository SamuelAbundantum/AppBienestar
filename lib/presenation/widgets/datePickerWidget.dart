import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa la biblioteca intl
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Importa la biblioteca flutter_screenutil

class FechaWidget extends StatefulWidget {
  @override
  _FechaWidgetState createState() => _FechaWidgetState();
}

class _FechaWidgetState extends State<FechaWidget> {
  DateTime _fechaSeleccionada = DateTime.now();

  _seleccionarFecha(BuildContext context) async {
    final DateTime? fechaNueva = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (fechaNueva != null) {
      setState(() {
        _fechaSeleccionada = fechaNueva;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Formatea la fecha para mostrar el día y el mes en texto con 'de' en medio
    String fechaFormateada = DateFormat('d \'de\' MMMM', 'es_ES').format(_fechaSeleccionada);

    return GestureDetector(
      onTap: () => _seleccionarFecha(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue), // Añade un borde
          borderRadius: BorderRadius.circular(50.r), // Añade esquinas redondeadas más grandes
          color: Colors.blue[50], // Cambia el color de fondo
        ),
        padding: EdgeInsets.all(8.0.r), // Añade un poco de padding
        child: Row(
          children: <Widget>[
            Icon(Icons.calendar_today, color: Colors.blue), // Añade un icono de calendario
            SizedBox(width: 8.0.w), // Añade un poco de espacio entre el icono y el texto
            Text(
              fechaFormateada,
              style: TextStyle(
                fontSize: 20.0.sp, // Hace el texto un poco más grande
                fontFamily: 'Poppins', // Usa la fuente 'Poppins'
                fontWeight: FontWeight.w600, // Usa un peso de fuente 'semibold'
              ),
            ),
          ],
        ),
      ),
    );
  }
}
