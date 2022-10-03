import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/core/domain/video.dart';
import 'package:frontend/core/ports/ports.dart';
import 'package:frontend/core/services/video-service.dart';
import 'package:grpc/grpc.dart';

import 'package:path/path.dart' as p;
import 'package:permission_handler/permission_handler.dart';

part 'download_event.dart';
part 'download_state.dart';

class DownloadBloc extends Bloc<DownloadEvent, DownloadState> {
  late final VideoService service;

  DownloadBloc(List<VideoMeta> videos)
      : super(DownloadState.videosFromMeta(videos)) {
    service = VideoServiceGrpc(
      channel: ClientChannel(
        "192.168.0.108",
        port: 8080,
        options: const ChannelOptions(
          idleTimeout: const Duration(seconds: 10),
          credentials: ChannelCredentials.insecure(),
        ),
      ),
    );

    on<Start>(_onStart);
  }

  void _onStart(
    Start event,
    Emitter<DownloadState> emit,
  ) async {
    if (!await Permission.storage.request().isGranted) {
      emit(OnError());
    }
    var dir = Directory(event.path);
    await dir.create(recursive: true);
    for (var i = 0; i < state.videos.length; i++) {
      var video = state.videos[i];
      List<int> bytes = [];

      try {
        await emit.forEach<VideoStream>(
          service.videoGetStream(video.meta.id),
          onData: (resp) {
            bytes.addAll(resp.data);
            var newVideos = [...state.videos];
            video = video.copyWith(resp.total, resp.ready);
            newVideos[i] = video;
            return DownloadState(newVideos);
          },
        );

        var fullPath = p.join(dir.path,
            "${video.meta.title.replaceAll(RegExp(r'[^\p{Alphabetic}\p{Mark}\p{Decimal_Number}\p{Connector_Punctuation}\p{Join_Control}\s]+', unicode: true), " ")}.mp3");
        var file = File(fullPath);
        file.writeAsBytesSync(bytes);
      } catch (e) {
        continue;
      }
    }
  }

  @override
  Future<void> close() async {
    await super.close();
  }
}
