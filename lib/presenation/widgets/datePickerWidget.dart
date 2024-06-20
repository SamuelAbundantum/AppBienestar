import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa la biblioteca intl
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FechaWidget extends StatefulWidget {
  final DateTime fechaInicial;
  final ValueChanged<DateTime> onDateSelected;

  FechaWidget({
    required this.onDateSelected,
    required this.fechaInicial,
  });

  @override
  _FechaWidgetState createState() => _FechaWidgetState();
}

class _FechaWidgetState extends State<FechaWidget> {
  late DateTime _fechaSeleccionada;

  @override
  void initState() {
    super.initState();
    _fechaSeleccionada = widget.fechaInicial;
  }

  _seleccionarFecha(BuildContext context) async {
    final DateTime? fechaNueva = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (fechaNueva != null) {
      final fechaSinTiempo = DateTime(fechaNueva.year, fechaNueva.month, fechaNueva.day);
      setState(() {
        _fechaSeleccionada = fechaSinTiempo;
        widget.onDateSelected(fechaSinTiempo);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String fechaFormateada = DateFormat('d \'de\' MMMM', 'es_ES').format(_fechaSeleccionada);
    return GestureDetector(
      onTap: () => _seleccionarFecha(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(50.r),
          color: Colors.blue[50],
        ),
        padding: EdgeInsets.all(8.0.r),
        child: Row(
          children: <Widget>[
            Icon(Icons.calendar_today, color: Colors.blue),
            SizedBox(width: 8.0.w),
            Text(
              fechaFormateada,
              style: TextStyle(
                fontSize: 20.0.sp,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
