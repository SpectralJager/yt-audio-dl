part of 'playlist_bloc.dart';

@immutable
abstract class PlaylistEvent {}

class Load extends PlaylistEvent {
  final String playlistId;

  Load(this.playlistId);
}

class ToggleSubDir extends PlaylistEvent {}
