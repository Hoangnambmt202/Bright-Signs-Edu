import 'package:edu_support/features/common/widgets/custom_appbar.dart';
import 'package:edu_support/features/student/screens/student_profile.dart';
import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CustomAppBar(
        backgroundColor: const Color(0xFF29B6F6),
        showBackButton: false,
        widget: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const StudentProfile()),
              ),
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfE8XWOVe86hLGi8m9mgPTsva_KWjTHbT9iQ&s",
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "Xin chào, Bạn!",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ],
        ),
        shadow: 0.1,
        actions: const [
          Icon(Icons.notifications_none, color: Colors.white),
          SizedBox(width: 16),
          Icon(Icons.message_outlined, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Tổng quan hôm nay",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),

              // 🔹 Grid tổng quan nhanh
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: [
                  _DashboardCard(
                    title: "Lịch học",
                    icon: Icons.calendar_today,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF42A5F5), Color(0xFF64B5F6)],
                    ),
                    onTap: () {},
                  ),
                  _DashboardCard(
                    title: "Bài tập",
                    icon: Icons.assignment,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFB74D), Color(0xFFFFCC80)],
                    ),
                    onTap: () {},
                  ),
                  _DashboardCard(
                    title: "Thông báo",
                    icon: Icons.notifications,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEF5350), Color(0xFFEF9A9A)],
                    ),
                    onTap: () {},
                  ),
                  _DashboardCard(
                    title: "Điểm số",
                    icon: Icons.grade,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF66BB6A), Color(0xFFA5D6A7)],
                    ),
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Text(
                "Truy cập nhanh",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // 🔹 Grid truy cập nhanh
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.9,
                children: const [
                  _QuickAction(icon: Icons.upload_file, label: "Nộp bài"),
                  _QuickAction(icon: Icons.star, label: "Chatbot"),
                  _QuickAction(icon: Icons.school, label: "Lịch thi"),
                  _QuickAction(icon: Icons.person, label: "Giáo viên"),
                  _QuickAction(icon: Icons.event_note, label: "Sự kiện"),
                  _QuickAction(icon: Icons.help, label: "Hỗ trợ"),
                ],
              ),
              const SizedBox(height: 24,)
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.title,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
            mainAxisSize: MainAxisSize.min, // 👈 thêm dòng này
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, size: 36, color: Colors.white),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
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
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min, // 👈 thêm dòng này
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.blueAccent),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
