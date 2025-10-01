import 'package:edu_support/features/common/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StudentLectures extends StatelessWidget {
  const StudentLectures({super.key});

  @override
  Widget build(BuildContext context) {
    // final lectures = [
    //   {
    //     "title": "Nguồn gốc của loài người",
    //     "subject": "Lịch sử",
    //     "titleChapter": "Thời kỳ nguyên thủy",
    //     "chapter": 2,
    //     "lesson": 3,
    //     "videoId": "Te84FwokGUk",
    //     "thumbnail":"https://phatphapungdung.com/wp-content/uploads/2019/03/nguon-goc-loai-nguoi.jpg",
    //     "signVideoId": "5qap5aO4i9A",
    //   },
    //   {
    //     "title": "Hệ thống kinh tuyến, vĩ tuyến và tọa độ địa lý",
    //     "subject": "Địa lý",
    //     "titleChapter": "Bản đồ - Phương tiện thể hiện bề mặt Trái Đất",
    //     "chapter": 1,
    //     "lesson": 1,
    //     "videoId": "2RbVBFWcAIU",
    //     "thumbnail":
    //         "https://vietjack.com/dia-li-6-ket-noi/images/ly-thuyet-bai-1-he-thong-kinh-vi-tuyen-toa-do-dia-li-1.png",
    //   },
    //   {
    //     "title": "Tập hợp",
    //     "subject": "Toán",
    //     "chapter": 1,
    //     "lesson": 1,
    //     "videoId": "vWh41JLvOTM",
    //     "thumbnail": "https://img.youtube.com/vi/vWh41JLvOTM/0.jpg",
    //     "signVideoId": "RBnMJKW9PnQ",
    //   },
    // ];

    return Scaffold(
      appBar: const CustomAppBar(title: "Bài giảng", showBackButton: false),


    );
  }
}

class LecturePlayerScreen extends StatefulWidget {
  final String title;
  final String videoId;
  final String signVideoId;

  const LecturePlayerScreen({
    super.key,
    required this.title,
    required this.videoId,
    this.signVideoId = "",
  });

  @override
  State<LecturePlayerScreen> createState() => _LecturePlayerScreenState();
}

class _LecturePlayerScreenState extends State<LecturePlayerScreen> {
  late YoutubePlayerController _controller;
  YoutubePlayerController? _signController;
  bool _showSignLanguage = true;
  int _currentSubtitleIndex = 0;

  final Map<String, List<Map<String, dynamic>>> videoSubtitles = {
    "vWh41JLvOTM": [
      {"time": 0, "text": "Xin chào các em."},
      {
        "time": 3,
        "text": "Hôm nay chúng ta sẽ cùng tìm hiểu về bài 'Tập hợp'.",
      },
      {"time": 10, "text": "Mục tiêu bài học hôm nay là..."},
      {
        "time": 15,
        "text": "Sau khi học xong, các em sẽ hiểu được khái niệm tập hợp.",
      },
      {
        "time": 22,
        "text": "Đầu tiên, chúng ta cùng đến với khái niệm tập hợp.",
      },
      {
        "time": 30,
        "text": "Ví dụ: Tập hợp các số tự nhiên nhỏ hơn 5 gồm 0,1,2,3,4.",
      },
      {
        "time": 40,
        "text": "Các em hãy luyện tập bằng cách làm các bài tập sau.",
      },
      {"time": 50, "text": "Cảm ơn các em đã theo dõi bài giảng!"},
    ],
    "dQw4w9WgXcQ": [
      {
        "time": 0,
        "text": "This is a placeholder subtitle for video dQw4w9WgXcQ.",
      },
    ],
    "9bZkp7q19f0": [
      {
        "time": 0,
        "text": "This is a placeholder subtitle for video 9bZkp7q19f0.",
      },
    ],
  };

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    )..addListener(_updateSubtitle);

    if (widget.signVideoId.isNotEmpty) {
      _signController = YoutubePlayerController(
        initialVideoId: widget.signVideoId,
        flags: const YoutubePlayerFlags(autoPlay: false, mute: true),
      );
    }

    _controller.addListener(_syncSignLanguageVideo);
  }

  void _updateSubtitle() {
    if (!_controller.value.isPlaying) return;
    final position = _controller.value.position.inSeconds;
    final subs = videoSubtitles[widget.videoId] ?? [];
    int newIndex = _currentSubtitleIndex;

    for (int i = 0; i < subs.length; i++) {
      if (i == subs.length - 1 || position < subs[i + 1]["time"]) {
        newIndex = i;
        break;
      }
    }

    if (newIndex != _currentSubtitleIndex) {
      setState(() {
        _currentSubtitleIndex = newIndex;
      });
    }
  }

  /// Đồng bộ video chính với video thủ ngữ
  void _syncSignLanguageVideo() {
    if (_signController == null) return;

    final mainValue = _controller.value;
    final signValue = _signController!.value;

    // Sync trạng thái play/pause
    if (mainValue.isPlaying && !signValue.isPlaying) {
      _signController!.play();
    } else if (!mainValue.isPlaying && signValue.isPlaying) {
      _signController!.pause();
    }

    // Sync khi seek (chênh lệch > 1s thì chỉnh lại)
    final diff = (mainValue.position.inSeconds - signValue.position.inSeconds)
        .abs();
    if (diff > 1) {
      _signController!.seekTo(mainValue.position);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_updateSubtitle);
    _controller.removeListener(_syncSignLanguageVideo);
    _controller.dispose();
    _signController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subs = videoSubtitles[widget.videoId] ?? [];
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            actions: [
              if (_signController != null)
                IconButton(
                  icon: Icon(
                    _showSignLanguage ? Icons.visibility : Icons.visibility_off,
                  ),
                  tooltip: "Bật/Tắt khung thủ ngữ",
                  onPressed: () {
                    setState(() {
                      _showSignLanguage = !_showSignLanguage;
                    });
                  },
                ),
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        player,
                        if (subs.isNotEmpty)
                          Container(
                            width: double.infinity,
                            color: Colors.black54,
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              subs[_currentSubtitleIndex]["text"],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 4,
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: subs.length,
                      itemBuilder: (context, index) {
                        final isActive = index == _currentSubtitleIndex;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Text(
                            subs[index]["text"],
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.6,
                              fontWeight: isActive
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isActive ? Colors.blue : Colors.black,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              // Khung thủ ngữ overlay
              if (_showSignLanguage && _signController != null)
                Positioned(
                  top: 100,
                  right: 10,
                  child: Container(
                    width: 120,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: YoutubePlayer(controller: _signController!),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
