import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyectoabundantum_appbienestar/config/router/rutas.dart';
import 'package:proyectoabundantum_appbienestar/presenation/widgets/playerScreenWidget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'botonesVideoMenuWidget.dart';
import 'widgets.dart';

final videoUrls = [
  'https://www.youtube.com/watch?v=RBiw9dwzAvY',
  'https://www.youtube.com/watch?v=ra0QjuGlk7Y',
  'https://www.youtube.com/watch?v=COgZyIeAIQ8',
  'https://www.youtube.com/watch?v=FfZH84UlFDM',
  'https://www.youtube.com/watch?v=cqVWsIvYfdw',
  'https://www.youtube.com/watch?v=nNOdDtwY1uM',
  'https://www.youtube.com/watch?v=rVPHZabCtCg',
  'https://www.youtube.com/watch?v=0P8RVaAuvyA',
  'https://www.youtube.com/watch?v=NUkLzN_Lxj0',
  'https://www.youtube.com/watch?v=9ohn7SJr5T8',
  'https://www.youtube.com/watch?v=z94QlTkcoiU',
  'https://www.youtube.com/watch?v=LCaazlwyUqE',
  'https://www.youtube.com/watch?v=tEZLOEJ6I8c'
];

class VideosYoutubeWidget extends StatelessWidget {
  const VideosYoutubeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF2F8),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            // Fila para el botón de flecha izquierda y el texto "Vídeos" centrado
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Text(
                      'Vídeos',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
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
            // Botón de menú centrado
            Center(
              child: MenuButtons(), // Reemplaza con tu widget de botón de menú
            ),
            SizedBox(height: 20.h),
            // Área de scroll con tamaño ajustado
            Container(
              height: MediaQuery.of(context).size.height * 0.62, // Ajusta este valor para cambiar el tamaño del scroll
              child: GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: 16 / 9,
                ),
                itemCount: videoUrls.length,
                itemBuilder: (context, index) {
                  final videoID = YoutubePlayer.convertUrlToId(videoUrls[index]);
                  return InkWell(
                    onTap: () {
                      if (videoID != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PLayerScreen(videoId: videoID),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: videoID != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          YoutubePlayer.getThumbnail(videoId: videoID),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _thumbnailPlaceholder();
                          },
                        ),
                      )
                          : _thumbnailPlaceholder(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
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
