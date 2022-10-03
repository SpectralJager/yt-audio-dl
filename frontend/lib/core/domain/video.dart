import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class VideoMeta extends Equatable {
  final String id;
  final String title;
  final String author;
  final String duration;

  VideoMeta({
    required this.id,
    required this.title,
    required this.author,
    required this.duration,
  });

  Map<String, String> toMap() {
    return <String, String>{
      "ID": id,
      "Title": title,
      "Author": author,
      "Duration": duration,
    };
  }

  @override
  List<Object> get props => [id, title, author, duration];
}

class VideoStream extends Equatable {
  final int total, ready;
  final List<int> data;

  VideoStream({
    required this.total,
    required this.ready,
    required this.data,
  });

  @override
  List<Object> get props => [total, ready, data];
}
