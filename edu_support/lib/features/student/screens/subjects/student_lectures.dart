import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:Bright_Signs/features/common/widgets/custom_appbar.dart';

class LecturePlayerScreen extends StatefulWidget {
  final String title;
  final String videoId; // YouTube videoId chính
  final String signVideoId; // YouTube videoId của thủ ngữ

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
  late YoutubePlayerController _ytController;
  YoutubePlayerController? _signController;

  bool _showSignLanguage = true;
  int _currentSubtitleIndex = 0;

  final Map<String, List<Map<String, dynamic>>> videoSubtitles = {
    "vWh41JLvOTM": [
      {"time": 0, "text": "Xin chào các em."},
      {"time": 3, "text": "Hôm nay chúng ta sẽ cùng tìm hiểu về bài 'Tập hợp'."},
      {"time": 10, "text": "Mục tiêu bài học hôm nay là..."},
      {"time": 15, "text": "Sau khi học xong, các em sẽ hiểu được khái niệm tập hợp."},
      {"time": 22, "text": "Đầu tiên, chúng ta cùng đến với khái niệm tập hợp."},
      {"time": 30, "text": "Ví dụ: Tập hợp các số tự nhiên nhỏ hơn 5 gồm 0,1,2,3,4."},
      {"time": 40, "text": "Các em hãy luyện tập bằng cách làm các bài tập sau."},
      {"time": 50, "text": "Cảm ơn các em đã theo dõi bài giảng!"},
    ],
  };

  final String lectureContent = """
# Bài giảng: Tập hợp

## 1. Khái niệm tập hợp
Tập hợp là một nhóm các đối tượng xác định, phân biệt được với nhau.

## 2. Cách biểu diễn tập hợp
- Liệt kê các phần tử: A = {1, 2, 3, 4}
- Chỉ ra tính chất đặc trưng: B = {x | x là số tự nhiên nhỏ hơn 5}

## 3. Các ví dụ
- Tập hợp các số tự nhiên nhỏ hơn 5: {0, 1, 2, 3, 4}
- Tập hợp các nguyên âm: {a, e, i, o, u}

## 4. Bài tập
1. Viết tập hợp các số chẵn nhỏ hơn 10
2. Viết tập hợp các chữ cái trong từ "TOÁN HỌC"
""";

  @override
  void initState() {
    super.initState();

    _ytController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    )..addListener(_updateSubtitle);

    if (widget.signVideoId.isNotEmpty) {
      _signController = YoutubePlayerController(
        initialVideoId: widget.signVideoId,
        flags: const YoutubePlayerFlags(autoPlay: true, mute: true),
      );
      _ytController.addListener(_syncSignLanguageVideo);
    }
  }

  void _updateSubtitle() {
    if (!_ytController.value.isPlaying) return;
    final position = _ytController.value.position.inSeconds;
    final subs = videoSubtitles[widget.videoId] ?? [];
    int newIndex = _currentSubtitleIndex;

    for (int i = 0; i < subs.length; i++) {
      if (i == subs.length - 1 || position < subs[i + 1]["time"]) {
        newIndex = i;
        break;
      }
    }

    if (newIndex != _currentSubtitleIndex) {
      setState(() => _currentSubtitleIndex = newIndex);
    }
  }

  void _syncSignLanguageVideo() {
    if (_signController == null) return;
    final mainValue = _ytController.value;
    final signValue = _signController!.value;

    if (mainValue.isPlaying && !signValue.isPlaying) {
      _signController!.play();
    } else if (!mainValue.isPlaying && signValue.isPlaying) {
      _signController!.pause();
    }

    final diff = (mainValue.position.inSeconds - signValue.position.inSeconds).abs();
    if (diff > 1) {
      _signController!.seekTo(mainValue.position);
    }
  }

  @override
  void dispose() {
    _ytController.removeListener(_updateSubtitle);
    _ytController.removeListener(_syncSignLanguageVideo);
    _ytController.dispose();
    _signController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subs = videoSubtitles[widget.videoId] ?? [];

    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _ytController),
      builder: (context, player) {
        return Scaffold(
          appBar: CustomAppBar(
            title: widget.title,
            titleStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            showBackButton: true,
            backgroundColor: const Color.fromARGB(255, 40, 184, 223),
            shadow: 0.1,
            actions: _signController != null
                ? [
                    IconButton(
                      icon: Icon(
                        _showSignLanguage
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      tooltip: _showSignLanguage ? "Ẩn thủ ngữ" : "Hiện thủ ngữ",
                      onPressed: () {
                        setState(() => _showSignLanguage = !_showSignLanguage);
                      },
                    ),
                  ]
                : null,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main video + sign overlay
                Stack(
                  children: [
                    AspectRatio(aspectRatio: 16 / 9, child: player),
                    if (_signController != null && _showSignLanguage)
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          width: 120,
                          height: 90,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: YoutubePlayer(
                              controller: _signController!,
                              showVideoProgressIndicator: false,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

                // Subtitle
                if (subs.isNotEmpty)
                  Container(
                    width: double.infinity,
                    color: Colors.black87,
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      subs[_currentSubtitleIndex]["text"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Lecture content
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "NỘI DUNG BÀI GIẢNG",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        lectureContent,
                        style: const TextStyle(fontSize: 15, height: 1.6),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
