import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class EnlacesLegales extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () async {
            await _launchURL('https://www.abundantum.org/terminos-y-condiciones');
          },
          child: Text(
            'Términos y condiciones',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            await _launchURL('https://www.abundantum.org/politica-de-privacidad');
          },
          child: Text(
            'Política de privacidad',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        TextButton(
          onPressed: () async {
            await _launchURL('https://www.abundantum.org/aviso-legal');
          },
          child: Text(
            'Aviso legal',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
  Future<void> _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo lanzar $url';
    }
  }
}