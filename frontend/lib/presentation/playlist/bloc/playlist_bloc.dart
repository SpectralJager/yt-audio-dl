import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/domain/playlist.dart';
import 'package:frontend/core/domain/video.dart';
import 'package:frontend/core/ports/ports.dart';
import 'package:frontend/core/services/video-service.dart';
import 'package:grpc/grpc.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, PlaylistState> {
  late final VideoService service;

  PlaylistBloc() : super(PlaylistLoading()) {
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
    on<ToggleSubDir>(_onToggleSubDir);
  }

  void _onLoad(
    Load event,
    Emitter<PlaylistState> emit,
  ) async {
    try {
      var meta = await service.playlistGet(event.playlistId);
      emit(PlaylistReady(meta, false));
    } catch (e) {
      emit(PlaylistError());
    }
  }

  void _onToggleSubDir(
    ToggleSubDir event,
    Emitter<PlaylistState> emit,
  ) async {
    emit(PlaylistReady(state.meta, !state.createSubDirectory));
  }
}
