import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectorEstadoWidget extends StatefulWidget {
  final List<String> iconPaths;
  final List<String> iconLabels;
  final double height;
  final double width;
  final String titulo;
  final double borderRadius;
  final ValueChanged<int>? onIconSelected; // Callback para notificar la selección

  SelectorEstadoWidget({
    required this.iconPaths,
    required this.iconLabels,
    required this.height,
    required this.width,
    required this.titulo,
    this.borderRadius = 100.0,
    this.onIconSelected, // Añadir el parámetro opcional
  });

  @override
  _SelectorEstadoWidgetState createState() => _SelectorEstadoWidgetState();
}

class _SelectorEstadoWidgetState extends State<SelectorEstadoWidget> {
  int _selectedIcon = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.titulo,
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10.h),
        Container(
          height: widget.height.h,
          width: widget.width.w,
          padding: EdgeInsets.symmetric(vertical: 8.0.r),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(widget.borderRadius.r),
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: List.generate(widget.iconPaths.length, (index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIcon = index;
                      });
                      if (widget.onIconSelected != null) {
                        widget.onIconSelected!(index); // Notificar la selección
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _selectedIcon == index ? Colors.blue : Colors.transparent,
                          width: 3.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(
                          widget.iconPaths[index],
                          width: 50.w,
                          height: 50.h,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.iconLabels[index],
                    style: TextStyle(
                      color: _selectedIcon == index ? Colors.blue : Colors.grey,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}