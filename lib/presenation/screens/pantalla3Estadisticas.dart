import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proyectoabundantum_appbienestar/config/helpers/DataBase/estadoDiarioService.dart';
import '../../config/helpers/DataBase/dbSambami.dart';
import '../../config/router/rutas.dart';
import '../widgets/widgets.dart';

class Pantalla3Estadisticas extends StatefulWidget {
  const Pantalla3Estadisticas({Key? key}) : super(key: key);

  @override
  _Pantalla3EstadisticasState createState() => _Pantalla3EstadisticasState();
}

class _Pantalla3EstadisticasState extends State<Pantalla3Estadisticas> {
  String _mesSeleccionado = '';
  Map<String, int> _estadoDiarioCounts = {};
  Map<String, String> _topThreeEstadoDiario = {};
  bool _isLoading = true;
  EstadoDiarioService estadoDiarioService = EstadoDiarioService();

  @override
  void initState() {
    super.initState();
    _mesSeleccionado = getMesActual();
    _cargarDatosDelMes(_mesSeleccionado);
  }

  String getMesActual() {
    DateTime now = DateTime.now();
    List<String> meses = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return meses[now.month - 1];
  }

  Future<void> _seleccionarMes(BuildContext context) async {
    int mesInicial = obtenerNumeroDelMes(_mesSeleccionado) - 1;
    await showCupertinoModalPopup<String>(
      context: context,
      builder: (context) => SelectorMesWidget(
        mesInicial: mesInicial,
        onMesConfirmado: (mes) {
          setState(() {
            _mesSeleccionado = mes;
            _isLoading = true;
          });
          _cargarDatosDelMes(mes);
        },
      ),
    );
  }

  int obtenerNumeroDelMes(String mesSeleccionado) {
    Map<String, int> meses = {
      'Enero': 1, 'Febrero': 2, 'Marzo': 3, 'Abril': 4, 'Mayo': 5, 'Junio': 6,
      'Julio': 7, 'Agosto': 8, 'Septiembre': 9, 'Octubre': 10, 'Noviembre': 11, 'Diciembre': 12
    };
    return meses[mesSeleccionado] ?? 0;
  }

  Future<void> _cargarDatosDelMes(String mes) async {
    int mesNumero = obtenerNumeroDelMes(mes);
    try {
      Map<String, int> estadoCounts = await estadoDiarioService.getEstadoDiarioCounts(mesNumero);
      Map<String, String> topThreeAreas = await estadoDiarioService.getTopThreeEstadoDiarioCountsByArea(mesNumero);

      print("Datos obtenidos para el mes $mesNumero:");
      print("estadoCounts: $estadoCounts");
      print("topThreeAreas: $topThreeAreas");

      setState(() {
        _estadoDiarioCounts = estadoCounts;
        _topThreeEstadoDiario = topThreeAreas;
        _isLoading = false;
      });
    } catch (error) {
      print("Error al cargar datos del mes $mesNumero: $error");
      setState(() {
        _estadoDiarioCounts = {};
        _topThreeEstadoDiario = {};
        _isLoading = false;
      });
    }
  }

  bool _isMapEmptyOrZero(Map<String, int> map) {
    return map.values.every((value) => value == 0);
  }

  bool _isMapEmptyOrZeroString(Map<String, String> map) {
    return map.values.every((value) {
      var parts = value.split(', ');
      return parts[0] == '0';
    });
  }

  bool _hasData() {
    bool hasEstadoData = _estadoDiarioCounts.isNotEmpty && !_isMapEmptyOrZero(_estadoDiarioCounts);
    bool hasTopThreeData = _topThreeEstadoDiario.isNotEmpty && !_isMapEmptyOrZeroString(_topThreeEstadoDiario);

    print("Estado Diario Counts vacío o todo a cero: ${_isMapEmptyOrZero(_estadoDiarioCounts)}");
    print("Top Three Estado Diario Counts vacío o todo a cero: ${_isMapEmptyOrZeroString(_topThreeEstadoDiario)}");

    return hasEstadoData || hasTopThreeData;
  }

  @override
  Widget build(BuildContext context) {
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
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () => _seleccionarMes(context),
                  child: Text(
                    _mesSeleccionado,
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 100.h,
              left: 25.w,
              right: 25.w,
              bottom: 100.h,
              child: SizedBox(
                height: 475.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (_isLoading)
                        Padding(
                          padding: EdgeInsets.only(top: 150.h),
                          child: Text(
                            'Cargando datos...',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      else if (!_hasData())
                        Padding(
                          padding: EdgeInsets.only(top: 150.h),
                          child: Text(
                            'No hay datos disponibles para el mes seleccionado, por favor selecciona otro mes o completa los meses restantes.',
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      else
                        Column(
                          children: [
                            PieChartSample(dataMap: _estadoDiarioCounts),
                            SizedBox(height: 35.h),
                            TopThreeAreasWidget(topThreeData: _topThreeEstadoDiario),
                          ],
                        ),
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
