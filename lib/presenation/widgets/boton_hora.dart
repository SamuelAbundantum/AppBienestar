import 'package:flutter/material.dart';
import '../../config/helpers/helpers.dart';

class BotonHora extends StatefulWidget {
  const BotonHora({Key? key}) : super(key: key);

  @override
  _BotonHoraState createState() => _BotonHoraState();
}

class _BotonHoraState extends State<BotonHora> {
  late Stream<TimeOfDay> _horaSeleccionadaStream;

  @override
  void initState() {
    super.initState();
    _horaSeleccionadaStream = HoraHelper.horaSeleccionadaStream;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectorDeHora(context);
      },
      child: Container(
        width: 315,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white, width: 3),
        ),
        child: StreamBuilder<TimeOfDay>(
          stream: _horaSeleccionadaStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error al obtener la hora');
            } else {
              TimeOfDay horaMostrada = snapshot.data ?? TimeOfDay.now();
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications),
                  SizedBox(width: 10),
                  Text(
                    horaMostrada.format(context),
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 70),
                  Text(
                    'Programar >',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
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
      await HoraHelper.guardarHoraSeleccionada(horaSeleccionada);
    }
  }
}

