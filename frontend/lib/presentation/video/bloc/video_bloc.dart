import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/domain/video.dart';
import 'package:frontend/core/ports/ports.dart';
import 'package:frontend/core/services/video-service.dart';
import 'package:grpc/grpc.dart';
import 'package:permission_handler/permission_handler.dart';

part 'video_event.dart';
part 'video_state.dart';

class VideoBloc extends Bloc<VideoEvent, VideoState> {
  late final VideoService service;

  VideoBloc() : super(VideoLoading()) {
    service = VideoServiceGrpc(
      channel: ClientChannel(
        "192.168.0.108",
        port: 8080,
        options: const ChannelOptions(
            idleTimeout: Duration(seconds: 10),
            credentials: ChannelCredentials.insecure()),
      ),
    );
    on<Load>(_onLoad);
  }

  void _onLoad(
    Load event,
    Emitter<VideoState> emit,
  ) async {
    try {
      var meta = await service.videoGet(event.videoId);
      emit(VideoReady(meta));
    } catch (e) {
      emit(VideoError());
    }
  }
}
