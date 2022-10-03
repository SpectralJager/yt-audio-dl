import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rive/rive.dart' as rive;

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Color(0xfff89b29),
            //     Color(0xffff0f7b),
            //   ],
            // ),
            image: DecorationImage(
              image: AssetImage("assets/bg.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: StaggeredGrid.count(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            crossAxisCount: 4,
            children: [
              _videoBtn(context),
              _appName(context),
              _appVersion(context),
              _playlistBtn(context),
              // _homeImg(context),
            ],
          ),
        ),
      ),
    );
  }

  StaggeredGridTile _playlistBtn(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 4,
      mainAxisCellCount: 2,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return HomeDialog(
                type: "playlist",
              );
            },
          );
        },
        child: Container(
          alignment: Alignment.center,
          color:
              Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.9),
          child: ListTile(
            title: Text(
              "Playlist",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
            ),
            subtitle: Icon(
              Icons.download_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ),
      ),
    );
  }

  StaggeredGridTile _videoBtn(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 3,
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return HomeDialog(
                type: "video",
              );
            },
          );
        },
        child: Container(
          alignment: Alignment.center,
          color:
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
          child: ListTile(
            title: Text(
              "Video",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
            ),
            subtitle: Icon(
              Icons.download_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }

  StaggeredGridTile _homeImg(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 4,
      mainAxisCellCount: 3.05,
      child: Container(
        // color: Theme.of(context).colorScheme.background.withOpacity(0.8),
        child: rive.RiveAnimation.asset(
          "assets/flowers.riv",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  StaggeredGridTile _appVersion(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 1,
      child: Container(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.9),
        alignment: Alignment.center,
        child: ListTile(
          title: Text(
            "ver. 1.0",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
          ),
        ),
      ),
    );
  }

  StaggeredGridTile _appName(BuildContext context) {
    return StaggeredGridTile.count(
      crossAxisCellCount: 2,
      mainAxisCellCount: 2,
      child: Container(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
        alignment: Alignment.center,
        child: ListTile(
          title: Text(
            "YoutubeAudio",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          subtitle: Text(
            "Downloader",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
      ),
    );
  }
}

class HomeDialog extends StatelessWidget {
  HomeDialog({
    required this.type,
    Key? key,
  }) : super(key: key);

  TextEditingController textEditingController = TextEditingController(text: "");

  String type;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 320,
        height: 220,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Enter ${type.toUpperCase()} ID or URL"),
            TextField(
              controller: textEditingController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                  label: Text("Close"),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/$type",
                        arguments: textEditingController.text);
                  },
                  icon: Icon(Icons.arrow_right_alt),
                  label: Text("Confirm"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
