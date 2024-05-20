import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/helpers/dbSambami.dart';
import '../../config/router/rutas.dart';
import '../../domain/entities/estadoDiario.dart';
import '../widgets/widgets.dart'; // Asegúrate de importar tus widgets personalizados

class Pantalla2SeleccionDeEstado extends StatefulWidget {
  const Pantalla2SeleccionDeEstado({Key? key}) : super(key: key);
  @override
  _Pantalla2SeleccionDeEstadoState createState() => _Pantalla2SeleccionDeEstadoState();
}
class _Pantalla2SeleccionDeEstadoState extends State<Pantalla2SeleccionDeEstado> {
  bool _showFeelingSelector = false;
  int _selectedEstado = -1;
  int _selectedFeeling = -1;
  int _selectedArea = -1;
  File? _image;
  final TextEditingController _textController = TextEditingController();
  DateTime _selectedDate = DateTime.now(); // Nueva variable para almacenar la fecha seleccionada
  void _onEstadoSelected(int index) {
    setState(() {
      _selectedEstado = index;
      if (index == 0 || index == 1) {
        _showFeelingSelector = true;
        _selectedFeeling = -1; // Resetear selección de "¿Cómo te sientes?"
      } else {
        _showFeelingSelector = false;
        _selectedFeeling = -1; // Resetear selección de "¿Cómo te sientes?"
      }
    });
  }
  void _onFeelingSelected(int index) {
    setState(() {
      _selectedFeeling = index;
    });
  }
  void _onAreaSelected(int index) {
    setState(() {
      _selectedArea = index;
    });
  }
  void _onImagePicked(File image) {
    setState(() {
      _image = image;
    });
  }
  bool _isFormValid() {
    if (_selectedEstado == -1 || _selectedArea == -1) {
      return false;
    }
    if ((_selectedEstado == 0 || _selectedEstado == 1) && _selectedFeeling == -1) {
      return false;
    }
    return true;
  }
  Future<void> _onGuardarPressed() async {
    if (!_isFormValid()) return;
    final selectedDateWithoutTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
    );
    final estadoDiario = EstadoDiario(
      id: int.parse('${_selectedDate.day}${_selectedDate.month}${_selectedDate.year}'),
      comoEstasHoy: ComoEstasHoy.values[_selectedEstado],
      comoTeSientes: _showFeelingSelector ? ComoTeSientes.values[_selectedFeeling] : ComoTeSientes.noSeleccionado,
      area: Area.values[_selectedArea],
      texto: _textController.text,
      foto: _image?.path ?? '',
      fecha: selectedDateWithoutTime, // Usar la fecha sin hora
    );
    await DB.insertOrUpdateEstadoDiario(estadoDiario);
    // Aquí puedes manejar el objeto `estadoDiario`, por ejemplo, guardarlo en una base de datos o enviarlo a un servidor.
    print(estadoDiario.toMap()); // Para depuración

    context.read<CubitRutas>().goPantalla1Menu();
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }
  @override
  Widget build(BuildContext context) {
    bool isFormValid = _isFormValid();
    return Scaffold(
      backgroundColor: const Color(0xFFEAF2F8),
      body: Padding(
        padding: EdgeInsets.only(top: 20.h),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 25.h,
              left: 10.w,
              child: BotonFlechaIzquierda(
                onPressed: () {
                  context.read<CubitRutas>().goPantalla1Menu();
                },
              ),
            ),
            Positioned(
              top: 35.h,
              left: 250.w,
              child: BotonGuardar(
                ancho: 100,
                largo: 30,
                radio: 50,
                tamanoTexto: 16,
                enabled: isFormValid, // Pasar la propiedad enabled
                onPressed: _onGuardarPressed, // Llamar a la función de guardar
              ),
            ),
            Positioned(
              top: 30.h,
              left: 80.w,
              child: FechaWidget(
                onDateSelected: _onDateSelected, // Pasar el callback para actualizar la fecha seleccionada
              ),
            ),
            Positioned(
              top: 100.h,
              left: 25.w,
              child: SizedBox(
                height: 475.h, // Altura del área visible del ScrollView
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SelectorEstadoWidget(
                        iconPaths: [
                          'assets/icons/muyMal.png',
                          'assets/icons/mal.png',
                          'assets/icons/bien.png',
                          'assets/icons/muyBien.png',
                        ],
                        iconLabels: [
                          'Muy mal',
                          'Mal',
                          'Bien',
                          'Muy bien',
                        ],
                        height: 100,
                        width: 300,
                        titulo: '¿Como estas hoy?',
                        onIconSelected: _onEstadoSelected, // Agregar callback
                      ),
                      SizedBox(height: 25.h),
                      if (_showFeelingSelector) // Condicional para mostrar u ocultar
                        SelectorEstadoWidget(
                          iconPaths: [
                            'assets/icons/muyMal.png',
                            'assets/icons/Triste.png',
                            'assets/icons/Preocupado.png',
                            'assets/icons/Frustrado.png',
                          ],
                          iconLabels: [
                            'Enfadado',
                            'Triste',
                            'Preocupado',
                            'Frustrado',
                          ],
                          height: 100,
                          width: 300,
                          titulo: '¿Como te sientes?',
                          onIconSelected: _onFeelingSelected, // Agregar callback
                        ),
                      SizedBox(height: 25.h), // Ajusta el espacio entre los widgets
                      SelectorEstadoWidget(
                        iconPaths: [
                          'assets/icons/Alimentacion.png',
                          'assets/icons/CrecimientoPersonal.png',
                          'assets/icons/Fisico.png',
                          'assets/icons/Descanso.png',
                          'assets/icons/Dinero.png',
                          'assets/icons/Espiritualidad.png',
                          'assets/icons/Familia.png',
                          'assets/icons/Ocupacion.png',
                          'assets/icons/Pareja.png',
                          'assets/icons/RedesSociales.png',
                          'assets/icons/Salud.png',
                          'assets/icons/Sexualidad.png',
                          'assets/icons/General.png',
                        ],
                        iconLabels: [
                          'Alimentación y Nutrición',
                          'Crecimiento personal',
                          'Cuerpo físico y Energía vital',
                          'Descanso y sueño',
                          'Dinero',
                          'Espiritualidad y Filosofía',
                          'Familia',
                          'Ocupación',
                          'Pareja',
                          'Redes Sociales',
                          'Salud',
                          'Sexualidad',
                          'General',
                        ],
                        height: 400,
                        width: 300,
                        titulo: 'Área de la vida',
                        borderRadius: 50,
                        onIconSelected: _onAreaSelected, // Agregar callback
                      ),
                      SizedBox(height: 25.h),
                      EstadoConCamaraWidget(
                        height: 300,
                        width: 300,
                        borderRadius: 25,
                        onImagePicked: _onImagePicked, // Pasar el callback para actualizar la imagen
                        textController: _textController, // Pasar el controlador de texto
                      ),
                      SizedBox(height: 25.h),
                      BotonGuardar(
                        ancho: 300,
                        largo: 60,
                        radio: 25,
                        tamanoTexto: 25,
                        enabled: isFormValid, // Pasar la propiedad enabled
                        onPressed: _onGuardarPressed, // Llamar a la función de guardar
                      ),
                      SizedBox(height: 25.h), // Espacio final opcional
                    ],
                  ),
                ),
              ),
            ),
            BarraDeTareas(), // Añade la BarraDeTareas
          ],
        ),
      ),
    );
  }
}