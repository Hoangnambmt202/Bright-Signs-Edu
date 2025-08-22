import 'package:flutter/material.dart';
import '../common/layout/base_layout.dart';
import './providers/parent_nav_provider.dart';
import 'screens/parent_dashboard.dart';
import 'screens/parent_reports.dart';
import 'screens/parent_messages.dart';
import 'screens/parent_profile.dart';

class ParentLayout extends StatelessWidget {
  const ParentLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      navProvider: parentNavProvider,
      pages: const [
        ParentDashboard(),
        ParentReports(),
        ParentMessages(),
        ParentProfile(),
      ],
      titles: const [
        "Trang chủ",
        "Báo cáo",
        "Tin nhắn",
        "Hồ sơ",
      ],
      icons: const [
        Icons.home,
        Icons.bar_chart,
        Icons.message,
        Icons.person,
      ],
    );
  }
}
