import 'package:edu_support/features/common/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StudentGrades extends StatefulWidget {
  const StudentGrades({super.key});

  @override
  State<StudentGrades> createState() => _StudentGradesState();
}

class _StudentGradesState extends State<StudentGrades> {
  int _selectedTab = 0;

  // Data giả lập
  final Map<String, double> subjectAverages = {
    "Toán": 8.5,
    "Văn": 7.2,
    "Anh": 8.0,
    "Sử": 9.0,
    "Điạ": 8.0,
    "Lý": 6.5,
    "Hóa": 7.8,
  };

  final List<Map<String, dynamic>> assignments = [
    {"title": "Bài tập Toán 1", "score": 9.0, "date": "12/08/2025"},
    {"title": "Bài kiểm tra Văn", "score": 7.0, "date": "15/08/2025"},
    {"title": "Bài tập Sử", "score": 8.0, "date": "16/08/2025"},
    {"title": "Bài tập Địa", "score": 9.5, "date": "17/08/2025"},
    {"title": "Bài tập Anh", "score": 8.5, "date": "18/08/2025"},
    {"title": "Bài kiểm tra Lý", "score": 6.0, "date": "20/08/2025"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: const CustomAppBar(
        title: "Thành tích học tập",
        titleStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 40, 184, 223),
        showBackButton: false,
        shadow: 0.1,
       
      ),
      body: Column(
        children: [
          // Tab chọn chế độ xem
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ToggleButtons(
              isSelected: [
                _selectedTab == 0,
                _selectedTab == 1,
                _selectedTab == 2
              ],
              onPressed: (index) {
                setState(() {
                  _selectedTab = index;
                });
              },
              borderRadius: BorderRadius.circular(12),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Theo môn"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Chi tiết"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Biểu đồ"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Nội dung theo tab
          Expanded(
            child: IndexedStack(
              index: _selectedTab,
              children: [
                _buildSubjectGrades(),
                _buildAssignments(),
                _buildProgressChart(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Tab 1: Bảng điểm theo môn
  Widget _buildSubjectGrades() {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: subjectAverages.entries.map((entry) {
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              child: Text(entry.key[0]),
            ),
            title: Text(entry.key),
            subtitle: Text("Điểm trung bình: ${entry.value}"),
            trailing: Icon(
              entry.value >= 8
                  ? Icons.emoji_events
                  : entry.value >= 7
                      ? Icons.star
                      : Icons.warning,
              color: entry.value >= 8
                  ? Colors.green
                  : entry.value >= 7
                      ? Colors.orange
                      : Colors.red,
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Tab 2: Chi tiết từng bài tập / bài kiểm tra
  Widget _buildAssignments() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: assignments.length,
      itemBuilder: (context, index) {
        final item = assignments[index];
        return Card(
          child: ListTile(
            title: Text(item["title"]),
            subtitle: Text("Ngày: ${item["date"]}"),
            trailing: Text(
              item["score"].toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: item["score"] >= 8
                    ? Colors.green
                    : item["score"] >= 6
                        ? Colors.orange
                        : Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }

  /// Tab 3: Biểu đồ tiến bộ (BarChart)
  Widget _buildProgressChart() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 10,
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 28),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final subjects = subjectAverages.keys.toList();
                  if (value.toInt() >= 0 && value.toInt() < subjects.length) {
                    return Text(subjects[value.toInt()]);
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: subjectAverages.entries
              .toList()
              .asMap()
              .entries
              .map((entry) {
            final index = entry.key;
            // final subject = entry.value.key;
            final score = entry.value.value;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: score,
                  color: score >= 8
                      ? Colors.green
                      : score >= 6
                          ? Colors.orange
                          : Colors.red,
                  width: 20,
                  borderRadius: BorderRadius.circular(6),
                ),
              ],
              showingTooltipIndicators: [0],
            );
          }).toList(),
        ),
      ),
    );
  }
}
