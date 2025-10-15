
import 'package:Bright_Signs/features/common/widgets/custom_appbar.dart';
import 'package:Bright_Signs/features/parent/layout/parent_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/base/base_layout.dart';
import '../providers/parent_nav_provider.dart';
import '../screens/parent_dashboard.dart';
import '../screens/parent_reports.dart';
import '../screens/parent_messages.dart';
import '../screens/parent_profile.dart';

class ParentLayout extends ConsumerWidget {
  const ParentLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(parentNavProvider);

    final screens = const [
      ParentDashboard(),
      ParentReports(),
      ParentMessages(),
      ParentProfile(),
    ];
    return BaseLayout(
      appBar: CustomAppBar  (title: "Ứng dụng dành cho phụ huynh"),
      body: screens[index],
      bottomNav: const ParentBottomNav(),
    
    );
  }
}
