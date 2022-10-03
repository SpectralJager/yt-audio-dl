import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/presentation/loading/widgets/loading_view.dart';
import 'package:frontend/presentation/playlist/bloc/playlist_bloc.dart';
import 'package:path/path.dart' as p;

class PlaylistView extends StatelessWidget {
  const PlaylistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var playlistId = ModalRoute.of(context)!.settings.arguments as String;
    return BlocProvider(
      create: (context) => PlaylistBloc()..add(Load(playlistId)),
      child: _PlaylistView(),
    );
  }
}

class _PlaylistView extends StatelessWidget {
  _PlaylistView({Key? key}) : super(key: key);

  String selectedDirectory = "/storage/emulated/0/Download/Audio/";
  bool creatSubDirectory = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlaylistBloc, PlaylistState>(
      listener: (context, state) {
        if (state is PlaylistError) {
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
        if (state is PlaylistReady) {
          return _view(state, context);
        }
        return const LoadingView();
      },
    );
  }

  Widget _view(PlaylistReady state, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        title: const Text("Playlist"),
        actions: [
          IconButton(
            onPressed: () async {
              String? tempDir = await FilePicker.platform
                  .getDirectoryPath(initialDirectory: selectedDirectory);
              if (tempDir != null) {
                selectedDirectory = tempDir;
              }
              print(selectedDirectory);
            },
            icon: const Icon(Icons.folder),
            color: Theme.of(context).colorScheme.secondary,
          ),
          SizedBox(
            width: 10,
          ),
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
                ...state.meta.videos,
              ],
              "path": p.join(
                selectedDirectory,
                state.createSubDirectory ? state.meta.title : null,
              ),
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
          _createSubDir(),
          _metaRow(state.meta.title, "Title"),
          _metaRow(state.meta.author, "Author"),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: state.meta.videos.length,
                itemBuilder: (ctx, index) {
                  var video = state.meta.videos[index];
                  return ListTile(
                    leading: Text("${index + 1}"),
                    minLeadingWidth: 22,
                    title: Text(video.title),
                    subtitle: Text(video.author),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  BlocBuilder<PlaylistBloc, PlaylistState> _createSubDir() {
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
        return CheckboxListTile(
          tileColor: Theme.of(context).colorScheme.secondaryContainer,
          title: Text("Create subdirectory with playlist title name ?"),
          value: state.createSubDirectory,
          onChanged: (value) {
            context.read<PlaylistBloc>().add(ToggleSubDir());
          },
        );
      },
    );
  }

  ListTile _metaRow(String title, subtitle) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }
}
