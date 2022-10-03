import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/presentation/download/bloc/download_bloc.dart';

class DownloadView extends StatelessWidget {
  const DownloadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return BlocProvider(
      create: (context) =>
          DownloadBloc(args["videos"])..add(Start(args["path"])),
      child: _DownloadView(),
    );
  }
}

class _DownloadView extends StatelessWidget {
  const _DownloadView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Downloading query"),
        leading: IconButton(
          onPressed: (() => Navigator.pop(context)),
          icon: Icon(Icons.cancel),
        ),
      ),
      body: ListView.builder(
        itemCount: context.read<DownloadBloc>().state.videos.length,
        itemBuilder: (ctx, index) {
          return _downloadItem(index);
        },
      ),
    );
  }

  BlocBuilder<DownloadBloc, DownloadState> _downloadItem(int index) {
    return BlocBuilder<DownloadBloc, DownloadState>(
      builder: (context, state) {
        var video = state.videos[index];
        return ListTile(
          title: Text(video.meta.title),
          subtitle: Text(video.meta.author),
          trailing: SizedBox(
            width: 40,
            height: 40,
            child: PageTransitionSwitcher(
              duration: Duration(seconds: 2),
              transitionBuilder: (
                Widget child,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
              ) {
                return SharedAxisTransition(
                  animation: animation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                  transitionType: SharedAxisTransitionType.scaled,
                );
              },
              child: video.isReady
                  ? Icon(Icons.done, size: 28)
                  : CircularProgressIndicator(
                      value: video.ready / video.total,
                      color: Theme.of(context).colorScheme.primary,
                    ),
            ),
          ),
        );
      },
    );
  }
}
