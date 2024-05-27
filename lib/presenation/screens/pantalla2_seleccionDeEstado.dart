import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/helpers/dbSambami.dart';
import '../../config/router/rutas.dart';
import '../../domain/entities/estadoDiario.dart';
import '../widgets/widgets.dart';

class Pantalla2SeleccionDeEstado extends StatefulWidget {
  final DateTime selectedDate;

  const Pantalla2SeleccionDeEstado({Key? key, required this.selectedDate}) : super(key: key);

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
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
  }

  void _onEstadoSelected(int index) {
    setState(() {
      _selectedEstado = index;
      if (index == 0 || index == 1) {
        _showFeelingSelector = true;
        _selectedFeeling = -1;
      } else {
        _showFeelingSelector = false;
        _selectedFeeling = -1;
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
      fecha: selectedDateWithoutTime,
    );
    await DB.insertOrUpdateEstadoDiario(estadoDiario);
    print(estadoDiario.toMap());

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
                enabled: isFormValid,
                onPressed: _onGuardarPressed,
              ),
            ),
            Positioned(
              top: 30.h,
              left: 80.w,
              child: FechaWidget(
                onDateSelected: _onDateSelected,
              ),
            ),
            Positioned(
              top: 100.h,
              left: 25.w,
              child: SizedBox(
                height: 475.h,
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
                        onIconSelected: _onEstadoSelected,
                      ),
                      SizedBox(height: 25.h),
                      if (_showFeelingSelector)
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
                          onIconSelected: _onFeelingSelected,
                        ),
                      SizedBox(height: 25.h),
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
                        onIconSelected: _onAreaSelected,
                      ),
                      SizedBox(height: 25.h),
                      EstadoConCamaraWidget(
                        height: 300,
                        width: 300,
                        borderRadius: 25,
                        onImagePicked: _onImagePicked,
                        textController: _textController,
                      ),
                      SizedBox(height: 25.h),
                      BotonGuardar(
                        ancho: 300,
                        largo: 60,
                        radio: 25,
                        tamanoTexto: 25,
                        enabled: isFormValid,
                        onPressed: _onGuardarPressed,
                      ),
                      SizedBox(height: 25.h),
                    ],
                  ),
                ),
              ),
            ),
            BarraDeTareas(),
          ],
        ),
      ),
    );
  }
}
