import 'package:flutter/material.dart';

class Lecture {
  final String title;
  final String videoId;       // YouTube videoId, có thì dùng
  final String? mp4Url;       // Nếu videoId rỗng thì lấy mp4Url
  final String? signVideoId;
  final String thumbnail;

  Lecture({
    required this.title,
    required this.videoId,
    required this.thumbnail,
    this.signVideoId,
    this.mp4Url,
  });
}


class Chapter {
  final String title;
  final List<Lecture> lectures;

  Chapter({
    required this.title,
    required this.lectures,
  });
}

class Subject {
  final String name;
  final IconData icon;
  final List<Chapter> chapters;

  Subject({
    required this.name,
    required this.icon,
    required this.chapters,
  });
}
