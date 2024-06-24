import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../domain/entities/videos.dart';

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
  late final YoutubePlayerController _controller;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.video.url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        showLiveFullscreenButton: true,
      ),
    );

    _controller.addListener(() {
      final isFullScreen = _controller.value.isFullScreen;
      if (isFullScreen != _isFullScreen) {
        setState(() {
          _isFullScreen = isFullScreen;
          if (_isFullScreen) {
            _enterFullScreenMode();
          } else {
            _exitFullScreenMode();
          }
        });
      }
    });
  }

  void _enterFullScreenMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  void _exitFullScreenMode() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    _exitFullScreenMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullScreen ? null : AppBar(title: const Text("Reproductor")),
      body: Stack(
        children: [
          if (!_isFullScreen)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YoutubePlayer(controller: _controller),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
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
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
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
            ),
          if (_isFullScreen)
            Positioned.fill(
              child: YoutubePlayer(controller: _controller),
            ),
        ],
      ),
    );
  }
}
