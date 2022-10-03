part of 'playlist_bloc.dart';

@immutable
abstract class PlaylistState {
  final PlaylistMeta meta;
  final bool createSubDirectory;

  PlaylistState(this.meta, this.createSubDirectory);
}

class PlaylistLoading extends PlaylistState {
  PlaylistLoading()
      : super(PlaylistMeta(id: "", title: "", author: "", videos: []), false);
}

class PlaylistReady extends PlaylistState {
  PlaylistReady(super.meta, super.createSubDirectory);
}

class PlaylistError extends PlaylistState {
  PlaylistError()
      : super(PlaylistMeta(id: "", title: "", author: "", videos: []), false);
}
