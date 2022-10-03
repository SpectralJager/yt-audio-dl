import 'package:frontend/core/domain/video.dart';

class PlaylistMeta {
  final String id, title, author;
  final List<VideoMeta> videos;

  PlaylistMeta({
    required this.id,
    required this.title,
    required this.author,
    required this.videos,
  });
}
