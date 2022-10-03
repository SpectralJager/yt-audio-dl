part of 'download_bloc.dart';

@immutable
abstract class DownloadEvent {}

class Start extends DownloadEvent {
  final String path;

  Start(this.path);
}
