import 'package:flutter/material.dart';
import 'package:frontend/constants/routes.dart';
import 'package:frontend/constants/theme.dart';

class AudioDownloader extends StatelessWidget {
  const AudioDownloader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: "/",
      routes: routes,
    );
  }
}
