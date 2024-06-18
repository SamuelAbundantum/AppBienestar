import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/entities/videos.dart';

class VideoHelper {
  static const String _apiUrl = 'https://changelog.abundantum.org/videos.json';

  static Future<List<Video>> getAllVideos() async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      final utf8DecodedBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(utf8DecodedBody)['areas'];

      List<Video> videos = [];
      for (final areaJson in jsonData) {
        for (final videoJson in areaJson['videos']) {
          videos.add(Video.fromJson(videoJson));
        }
      }
      return videos;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Video> getVideoById(int id) async {
    final List<Video> allVideos = await getAllVideos();
    for (final video in allVideos) {
      if (video.id == id) {
        return video;
      }
    }
    throw Exception('Video not found');
  }

  static Future<List<Video>> getVideosByGenre(String genre) async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      final utf8DecodedBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(utf8DecodedBody)['areas'];

      List<Video> genreVideos = [];
      for (final areaJson in jsonData) {
        if (areaJson['nombre'] == genre) {
          for (final videoJson in areaJson['videos']) {
            genreVideos.add(Video.fromJson(videoJson));
          }
          break;
        }
      }
      return genreVideos;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Video> getRandomVideoByArea(String area) async {
    final response = await http.get(Uri.parse(_apiUrl));

    if (response.statusCode == 200) {
      final utf8DecodedBody = utf8.decode(response.bodyBytes);
      final jsonData = json.decode(utf8DecodedBody)['areas'];

      List<Video> areaVideos = [];
      for (final areaJson in jsonData) {
        if (areaJson['nombre'] == area) {
          for (final videoJson in areaJson['videos']) {
            areaVideos.add(Video.fromJson(videoJson));
          }
          break;
        }
      }

      if (areaVideos.isEmpty) {
        areaVideos = await getAllVideos();
      }

      areaVideos.shuffle();
      return areaVideos.first;
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Video> getRandomVideoByGenre(String genre) async {
    final List<Video> videos = await getVideosByGenre(genre);
    if (videos.isNotEmpty) {
      videos.shuffle();
      return videos.first;
    } else {
      final allVideos = await getAllVideos();
      allVideos.shuffle();
      return allVideos.first;
    }
  }
}
