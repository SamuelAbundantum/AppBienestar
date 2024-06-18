import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectorMesWidget extends StatefulWidget {
  final int mesInicial;
  final Function(String) onMesConfirmado;

  const SelectorMesWidget({
    Key? key,
    required this.mesInicial,
    required this.onMesConfirmado,
  }) : super(key: key);

  @override
  _SelectorMesWidgetState createState() => _SelectorMesWidgetState();
}

class _SelectorMesWidgetState extends State<SelectorMesWidget> {
  int _mesSeleccionadoIndex = 0;

  @override
  void initState() {
    super.initState();
    _mesSeleccionadoIndex = widget.mesInicial;
  }

  @override
  Widget build(BuildContext context) {
    List<String> meses = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 200.h,
          child: CupertinoPicker(
            backgroundColor: Colors.white,
            itemExtent: 40.h,
            scrollController: FixedExtentScrollController(initialItem: widget.mesInicial),
            onSelectedItemChanged: (index) {
              _mesSeleccionadoIndex = index;
            },
            children: meses.map((mes) => Text(mes, style: TextStyle(fontSize: 22.sp))).toList(),
          ),
        ),
        SizedBox(height: 10.h),
        ElevatedButton(
          onPressed: () {
            widget.onMesConfirmado(meses[_mesSeleccionadoIndex]);
            Navigator.of(context).pop();
          },
          child: Text('Confirmar'),
        ),
      ],
    );
  }
}

