part of 'video_bloc.dart';

@immutable
abstract class VideoState {}

class VideoLoading extends VideoState {}

class VideoReady extends VideoState {
  final VideoMeta meta;

  VideoReady(this.meta);
}

class VideoError extends VideoState {}
