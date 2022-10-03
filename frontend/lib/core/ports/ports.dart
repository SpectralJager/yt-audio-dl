import 'package:frontend/core/domain/playlist.dart';
import 'package:frontend/core/domain/video.dart';

abstract class VideoService {
  Future<VideoMeta> videoGet(String videoId);
  Stream<VideoStream> videoGetStream(String videoId); //List<int>
  Future<PlaylistMeta> playlistGet(String playlistId);
}
