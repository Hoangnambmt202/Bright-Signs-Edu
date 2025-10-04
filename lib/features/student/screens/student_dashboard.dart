import 'package:edu_support/features/common/widgets/custom_appbar.dart';
import 'package:edu_support/features/student/screens/student_profile.dart';
import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA), // màu nền xám trắng nhẹ
      appBar: CustomAppBar(
        backgroundColor: const Color.fromARGB(255, 40, 184, 223),
        showBackButton: false,
        widget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StudentProfile(),
                  ), 
                );
              },
              child: const CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfE8XWOVe86hLGi8m9mgPTsva_KWjTHbT9iQ&s",
                ),
                radius: 16,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              "Xin chào, học sinh!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        actions: const [
          IconButton(onPressed: null, icon: Icon(Icons.search)),
          IconButton(icon: Icon(Icons.notifications), onPressed: null),
          IconButton(onPressed: null, icon: Icon(Icons.message)),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Lịch học hôm nay"),
            _buildScheduleCard(
              icon: Icons.book,
              color: Colors.blue,
              title: "Toán - Đại số",
              subtitle: "08:00 - 09:30",
            ),
            _buildScheduleCard(
              icon: Icons.book,
              color: Colors.blue,
              title: "Lịch sử - Cận đại",
              subtitle: "08:00 - 09:30",
            ),
            _buildScheduleCard(
              icon: Icons.science,
              color: Colors.green,
              title: "Hóa học",
              subtitle: "10:00 - 11:30",
            ),

            sectionTitle("Bài tập gần hạn"),
            _buildTaskCard(),

            sectionTitle("Thông báo"),
            _buildNotificationCard(),

            sectionTitle("Truy cập nhanh"),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _QuickAction(icon: Icons.assignment, label: "Nộp bài"),
                _QuickAction(icon: Icons.grade, label: "Xem điểm"),
                _QuickAction(icon: Icons.star, label: "Chatbot"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildScheduleCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }

  Widget _buildTaskCard() {
    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFFFE0B2),
          child: Icon(Icons.assignment, color: Colors.orange),
        ),
        title: const Text(
          "Bài tập Lịch sử chương 2",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: const Text("Hạn: 25/10/2025"),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {},
          child: const Text("Nộp", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildNotificationCard() {
    return Card(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black12,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: const ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xFFFFCDD2),
          child: Icon(Icons.notifications, color: Colors.red),
        ),
        title: Text(
          "Kiểm tra Địa lý tuần sau",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text("Ngày 28/11/2025 - phòng 201"),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
   
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              radius: 28,
              child: Icon(icon, color: Colors.blue, size: 28),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
