import 'package:flutter/material.dart';
import '../models/subject.dart';

final List<Subject> subjects = [
  Subject(
    name: 'Toán',
    icon: Icons.calculate,
    chapters: [
      Chapter(
        title: 'Chương 1: Số học',
        lectures: [
          Lecture(
            title: 'Tập hợp',
            videoId: 'vWh41JLvOTM',
            thumbnail: 'https://img.youtube.com/vi/vWh41JLvOTM/0.jpg',
            signVideoId: 'RBnMJKW9PnQ',
          ),
        ],
      ),
      Chapter(
        title: 'Chương 2: Đại số',
        lectures: [
          Lecture(
            title: 'Phương trình bậc nhất',
            videoId: 'abcd1234', // thay bằng id thực
            thumbnail: 'https://via.placeholder.com/150',
          ),
        ],
      ),
    ],
  ),
  Subject(
    name: 'Lịch sử',
    icon: Icons.history_edu,
    chapters: [
      Chapter(
        title: 'Chương 2: Thời kỳ nguyên thủy',
        lectures: [
          Lecture(
            title: 'Nguồn gốc của loài người',
            videoId: 'Te84FwokGUk',
            thumbnail:
                'https://phatphapungdung.com/wp-content/uploads/2019/03/nguon-goc-loai-nguoi.jpg',
            signVideoId: '5qap5aO4i9A',
          ),
        ],
      ),
    ],
  ),
  Subject(
    name: 'Địa lý',
    icon: Icons.public,
    chapters: [
      Chapter(
        title: 'Chương 1: Bản đồ & tọa độ',
        lectures: [
          Lecture(
            title: 'Hệ thống kinh tuyến, vĩ tuyến',
            videoId: '2RbVBFWcAIU',
            thumbnail:
                'https://vietjack.com/dia-li-6-ket-noi/images/ly-thuyet-bai-1-he-thong-kinh-vi-tuyen-toa-do-dia-li-1.png',
          ),
        ],
      ),
    ],
  ),
  // Thêm môn khác: Văn, Lý, Hóa, Sinh, Tin học, Công nghệ, Thể dục, Nghệ thuật...
];
