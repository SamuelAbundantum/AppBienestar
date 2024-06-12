import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../domain/entities/videos.dart'; // Asegúrate de importar la clase Video

class PLayerScreen extends StatefulWidget {
  const PLayerScreen({
    Key? key,
    required this.video,
  }) : super(key: key);

  final Video video;

  @override
  State<PLayerScreen> createState() => _PLayerScreenState();
}

class _PLayerScreenState extends State<PLayerScreen> {
  late final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(widget.video.url)!,
    flags: const YoutubePlayerFlags(
      autoPlay: true,
    ),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Player")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alineación a la izquierda
          children: [
            YoutubePlayer(controller: _controller),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12), // Espaciado interno
              margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8), // Margen
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10), // Bordes redondeados
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Desplazamiento de la sombra
                  ),
                ],
              ),
              child: Text(
                widget.video.nombre,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(12), // Espaciado interno
              margin: const EdgeInsets.only(left: 8, right: 8), // Margen
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10), // Bordes redondeados
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Desplazamiento de la sombra
                  ),
                ],
              ),
              child: Text(
                widget.video.descripcion,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
