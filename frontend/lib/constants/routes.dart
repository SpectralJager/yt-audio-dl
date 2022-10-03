import 'package:flutter/material.dart';
import 'package:frontend/presentation/download/widgets/download_view.dart';
import 'package:frontend/presentation/home/widgets/home_view.dart';
import 'package:frontend/presentation/playlist/widgets/playlist_videw.dart';
import 'package:frontend/presentation/video/widgets/video_videw.dart';

var routes = <String, Widget Function(BuildContext)>{
  "/": (ctx) => const HomeView(),
  "/video": (ctx) => const VideoView(),
  "/playlist": (ctx) => const PlaylistView(),
  "/download": (ctx) => const DownloadView(),
};
