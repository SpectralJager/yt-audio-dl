part of 'download_bloc.dart';

@immutable
class DownloadState extends Equatable {
  final List<DownloadVideo> videos;

  const DownloadState(this.videos);

  factory DownloadState.videosFromMeta(List<VideoMeta> meta) {
    List<DownloadVideo> videos = [];
    for (var videoMeta in meta) {
      videos.add(DownloadVideo(meta: videoMeta));
    }
    return DownloadState(videos);
  }

  @override
  List<Object?> get props => [videos];
}

class OnError extends DownloadState {
  OnError() : super([]);
}

class DownloadVideo extends Equatable {
  final VideoMeta meta;
  final int total, ready;

  double get ratio => ready / total;
  bool get isReady => total == ready;

  DownloadVideo({required this.meta, this.total = 1, this.ready = 0});

  DownloadVideo copyWith(int? total, ready) {
    return DownloadVideo(
      meta: meta,
      total: total ?? this.total,
      ready: ready ?? this.ready,
    );
  }

  @override
  List<Object?> get props => [meta, total, ready];
}
