part of 'video_bloc.dart';

@immutable
abstract class VideoEvent {}

class Load extends VideoEvent {
  final String videoId;

  Load(this.videoId);
}
