import 'package:animations/animations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/presentation/loading/widgets/loading_view.dart';
import 'package:frontend/presentation/video/bloc/video_bloc.dart';

class VideoView extends StatelessWidget {
  const VideoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var videoId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) => VideoBloc()..add(Load(videoId)),
      child: _VideoView(),
    );
  }
}

class _VideoView extends StatelessWidget {
  _VideoView({Key? key}) : super(key: key);

  String selectedDirectory = "/storage/emulated/0/Download/Audio/";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoBloc, VideoState>(
      listener: (context, state) {
        if (state is VideoError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Can't access video or playlist, try later!",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
              duration: Duration(seconds: 10),
              backgroundColor: Theme.of(context).colorScheme.error,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pushNamed(context, "/");
        }
      },
      builder: (context, state) {
        if (state is VideoReady) {
          return _view(state, context);
        }
        return const LoadingView();
      },
    );
  }

  Widget _view(VideoReady state, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        title: Text(
          "Video",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              String? tempDir = await FilePicker.platform
                  .getDirectoryPath(initialDirectory: selectedDirectory);
              if (tempDir != null) {
                selectedDirectory = tempDir;
              }
            },
            icon: Icon(
              Icons.folder,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            color: Theme.of(context).colorScheme.secondary,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          Navigator.pushNamed(
            context,
            "/download",
            arguments: <String, dynamic>{
              "videos": [
                state.meta,
              ],
              "path": selectedDirectory,
            },
          );
        },
        child: const Icon(
          Icons.download,
          size: 28,
        ),
      ),
      body: Column(
        children: [
          _metaImg(state.meta.id, context),
          _metaRow(context, state.meta.title, "Title"),
          _metaRow(context, state.meta.author, "Author"),
          _metaRow(context, state.meta.duration, "Duration"),
        ],
      ),
    );
  }

  Widget _metaImg(String id, BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      width: MediaQuery.of(context).size.width,
      height: 220,
      margin: const EdgeInsets.only(bottom: 20),
      child: Image.network(
        "https://i.ytimg.com/vi/${id}/hqdefault.jpg",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _metaRow(BuildContext context, String title, subtitle) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onBackground
                    .withOpacity(0.75),
              ),
        ),
      ),
    );
  }
}
