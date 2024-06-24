import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/router/rutas.dart';
import '../../domain/entities/videos.dart';

class VideoPopup extends StatefulWidget {
  final Video video;

  const VideoPopup({Key? key, required this.video}) : super(key: key);

  @override
  _VideoPopupState createState() => _VideoPopupState();
}

class _VideoPopupState extends State<VideoPopup> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.video.url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
        isLive: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Text(
                "Veo que tu estado de ánimo está un poco mal, te recomiendo este video que te puede ayudar",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
            ),
            YoutubePlayer(controller: _controller),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0.h),
              child: Text(
                widget.video.nombre,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<CubitRutas>().goPantalla1Menu();
              },
              child: Text(
                'Cerrar',
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
