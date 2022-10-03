import 'dart:typed_data';

import 'package:frontend/core/domain/playlist.dart';
import 'package:frontend/core/domain/video.dart';
import 'package:frontend/core/ports/ports.dart';
import 'package:frontend/repositories/grpc/pb/pkg/proto/youtube-service.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class VideoServiceGrpc implements VideoService {
  final ClientChannel channel;

  VideoServiceGrpc({required this.channel});

  YoutubeGRPCServiceClient _createStub() => YoutubeGRPCServiceClient(
        channel,
        // options: CallOptions(timeout: Duration(seconds: 60)),
      );

  @override
  Future<VideoMeta> videoGet(String videoId) async {
    var stub = _createStub();
    final resp = await stub.videoGetMeta(VideoGetReq(videoId: videoId));

    return VideoMeta(
      id: resp.iD,
      title: resp.title,
      author: resp.author,
      duration: resp.duration,
    );
  }

  @override
  Stream<VideoStream> videoGetStream(String videoId) async* {
    var stub = _createStub();
    await for (var resp in stub.videoGetStream(VideoGetReq(videoId: videoId))) {
      yield VideoStream(
        total: resp.total.toInt(),
        ready: resp.ready.toInt(),
        data: resp.data,
      );
    }
  }

  @override
  Future<PlaylistMeta> playlistGet(String playlistId) async {
    var stub = _createStub();
    final resp =
        await stub.playlistGetMeta(PlaylistGetReq(playlistId: playlistId));
    var videos = <VideoMeta>[];

    for (var v in resp.videos) {
      videos.add(VideoMeta(
          id: v.iD, title: v.title, author: v.author, duration: v.duration));
    }

    return PlaylistMeta(
        id: resp.iD, title: resp.title, author: resp.author, videos: videos);
  }
}
