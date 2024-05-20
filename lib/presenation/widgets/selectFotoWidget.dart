import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDialog extends StatelessWidget {
  final Function(ImageSource) onImageSelected;

  ImagePickerDialog({required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(color: Colors.black, width: 2),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Tomar Foto'),
              onTap: () {
                Navigator.of(context).pop();
                onImageSelected(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Seleccionar de Galería'),
              onTap: () {
                Navigator.of(context).pop();
                onImageSelected(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
