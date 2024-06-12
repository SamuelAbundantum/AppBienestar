import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proyectoabundantum_appbienestar/presenation/widgets/widgets.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../config/helpers/videosHelper.dart';
import '../../config/router/rutas.dart';
import '../../domain/entities/videos.dart';

class VideosYoutubeWidget extends StatefulWidget {
  const VideosYoutubeWidget({Key? key}) : super(key: key);

  @override
  _VideosYoutubeWidgetState createState() => _VideosYoutubeWidgetState();
}

class _VideosYoutubeWidgetState extends State<VideosYoutubeWidget> {
  String _selectedGenre = 'General'; // Default genre
  Future<List<Video>>? _videosFuture;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  void _loadVideos() {
    if (_selectedGenre == 'General') {
      _videosFuture = VideoHelper.getAllVideos();
    } else {
      _videosFuture = VideoHelper.getVideosByGenre(_selectedGenre);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF2F8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Vídeos',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: BotonFlechaIzquierda(
                    onPressed: () {
                      context.read<CubitRutas>().goPantalla1Menu();
                    },
                  ),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => _showFilterPopup(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.orangeAccent, // Color del texto
                  elevation: 3,
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Bordes redondeados
                  ),
                  shadowColor: Colors.orangeAccent.withOpacity(0.5), // Sombra ligera
                ),
                child: Text(
                  'Filtrar',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FutureBuilder<List<Video>>(
              future: _videosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final videos = snapshot.data!;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 80), // Aumenta el padding inferior para evitar superposición
                      child: GridView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 16 / 9,
                        ),
                        itemCount: videos.length,
                        itemBuilder: (context, index) {
                          final video = videos[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => PLayerScreen(
                                    video: video,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.05),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  YoutubePlayer.getThumbnail(videoId: YoutubePlayer.convertUrlToId(video.url)!),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return _thumbnailPlaceholder();
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterPopup(BuildContext context) async {
    final selectedCategory = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return FilterPopup();
      },
    );

    if (selectedCategory != null && selectedCategory != _selectedGenre) {
      setState(() {
        _selectedGenre = selectedCategory;
        _loadVideos();
      });
    }
  }

  Widget _thumbnailPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Center(
        child: Text(
          "Abundantum.org",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
