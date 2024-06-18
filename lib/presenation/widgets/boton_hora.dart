import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/helpers/dbSambami.dart';
import '../../domain/entities/hora.dart';

class BotonHora extends StatefulWidget {
  final double width;
  final double height;
  final TextStyle textStyle;

  const BotonHora({
    Key? key,
    this.width = 315.0,
    this.height = 70.0,
    required this.textStyle,
  }) : super(key: key);

  @override
  _BotonHoraState createState() => _BotonHoraState();
}

class _BotonHoraState extends State<BotonHora> {
  late Stream<TimeOfDay> _horaSeleccionadaStream =
  Stream<TimeOfDay>.value(TimeOfDay.now());
  int idHora = 1;

  @override
  void initState() {
    super.initState();
    _inicializarHora();
  }

  void _inicializarHora() async {
    Hora horaExistente = await DB.getHora(idHora);

    if (horaExistente.id != idHora) {
      TimeOfDay horaActual = TimeOfDay.now();
      Hora nuevaHora = Hora(id: idHora, hora: horaActual);
      int insertedId = await DB.insertHora(nuevaHora);
      print(
          'Hora inicial insertada en la base de datos con ID $insertedId: ${nuevaHora.toMap()}');
    } else {
      print(
          'La hora con ID $idHora ya existe en la base de datos: ${horaExistente.toMap()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectorDeHora(context);
      },
      child: Container(
        width: widget.width.w,
        height: widget.height.h,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(
              18.w),
          border: Border.all(
              color: Colors.white,
              width: 3.w),
        ),
        child: StreamBuilder<TimeOfDay>(
          stream: _horaSeleccionadaStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error al obtener la hora');
            } else {
              TimeOfDay horaMostrada =
                  snapshot.data ?? TimeOfDay.now();
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications),
                  SizedBox(
                      width:
                      10.w),
                  Text(
                    horaMostrada.format(context),
                    style: widget.textStyle,
                  ),
                  SizedBox(
                      width:
                      25.w),
                  Text(
                    'Programar >',
                    style: widget.textStyle,
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void _selectorDeHora(BuildContext context) async {
    final TimeOfDay? horaSeleccionada = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (horaSeleccionada != null) {
      Hora hora = Hora(id: idHora, hora: horaSeleccionada);

      Hora horaExistente = await DB.getHora(idHora);

      if (horaExistente.id == idHora) {
        await DB.updateHora(hora);
        print('Hora actualizada en la base de datos: ${hora.toMap()}');
      } else {
        await DB.insertHora(hora);
        print('Nueva hora insertada en la base de datos: ${hora.toMap()}');
      }

      setState(() {
        _horaSeleccionadaStream = Stream<TimeOfDay>.value(horaSeleccionada);
      });
    }
  }
}