import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:proyectoabundantum_appbienestar/presenation/widgets/widgets.dart';

class EstadoConCamaraWidget extends StatefulWidget {
  final double height;
  final double width;
  final double borderRadius;
  final TextEditingController textController;
  final Function(File) onImagePicked;

  EstadoConCamaraWidget({
    required this.height,
    required this.width,
    required this.textController,
    required this.onImagePicked,
    this.borderRadius = 100.0,
  });

  @override
  _EstadoConCamaraWidgetState createState() => _EstadoConCamaraWidgetState();
}

class _EstadoConCamaraWidgetState extends State<EstadoConCamaraWidget> {
  File? _image;
  double _containerHeight = 0;

  @override
  void initState() {
    super.initState();
    widget.textController.addListener(_updateContainerHeight);
  }

  @override
  void dispose() {
    widget.textController.removeListener(_updateContainerHeight);
    super.dispose();
  }

  void _updateContainerHeight() {
    final textHeight = _calculateTextHeight();
    setState(() {
      _containerHeight = textHeight;
    });
  }

  double _calculateTextHeight() {
    final textSpan = TextSpan(
      text: widget.textController.text,
      style: TextStyle(
        fontSize: 16.0.sp,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: null,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: widget.width.w);
    return textPainter.size.height;
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.onImagePicked(_image!); // Notificar la imagen seleccionada
      }
    });
  }

  void _showImageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
            side: BorderSide(color: Colors.black, width: 2),
          ),
          child: _image != null
              ? Image.file(
            _image!,
            fit: BoxFit.contain,
          )
              : Container(
            height: 200.h,
            width: 200.w,
            child: Center(
              child: Text('No se ha seleccionado ninguna imagen'),
            ),
          ),
        );
      },
    );
  }

  void _showPickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ImagePickerDialog(
          onImageSelected: (source) {
            _getImage(source);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _containerHeight + widget.height.h,
      width: widget.width.w,
      padding: EdgeInsets.all(8.0.r),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(widget.borderRadius.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: TextField(
              controller: widget.textController,
              maxLines: null,
              expands: true,
              minLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Escribe como te sientes...',
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          if (_image != null)
            GestureDetector(
              onTap: _showImageDialog,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius.r),
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                  height: 200.h, // Ajusta la altura de la imagen según tus necesidades
                  width: widget.width.w, // Ajusta el ancho de la imagen según tus necesidades
                ),
              ),
            ),
          if (_image != null)
            SizedBox(height: 8.h),
          GestureDetector(
            onTap: _showPickerDialog,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                  size: 24.w,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Elegir Foto',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
