import 'package:edu_support/features/common/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:edu_support/features/student/screens/student_assignment_detail.dart';

class StudentAssignments extends StatefulWidget {
  const StudentAssignments({super.key});

  @override
  State<StudentAssignments> createState() => _StudentAssignmentsState();
}

class _StudentAssignmentsState extends State<StudentAssignments> {
  String _filter = "Tất cả";

  final List<Map<String, dynamic>> _assignments = [
    {
      "title": "Bài tập Toán chương 3",
      "subject": "Toán",
      "deadline": "25/08/2025",
      "status": "Chưa nộp"
    },
    {
      "title": "Thí nghiệm Hóa học tuần 2",
      "subject": "Hóa",
      "deadline": "26/08/2025",
      "status": "Đã nộp"
    },
    {
      "title": "Bài văn nghị luận",
      "subject": "Văn",
      "deadline": "22/08/2025",
      "status": "Quá hạn"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredAssignments = _filter == "Tất cả"
        ? _assignments
        : _assignments.where((a) => a["subject"] == _filter).toList();

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Bài tập",
        titleStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white), 
        showBackButton: false, 
        backgroundColor: Color.fromARGB(255, 40, 184, 223),
        shadow: 0.1,
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed: null),
          IconButton(icon: Icon(Icons.filter_list), onPressed: null),
          IconButton(icon: Icon(Icons.question_mark_sharp), onPressed: null),
  
        ],
        ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter
            Row(
              children: [
                const Text("Môn học: ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _filter,
                  items: ["Tất cả", "Toán", "Hóa", "Văn"]
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _filter = val);
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Danh sách bài tập
            Expanded(
              child: ListView.builder(
                itemCount: filteredAssignments.length,
                itemBuilder: (context, index) {
                  final item = filteredAssignments[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: const Icon(Icons.assignment, color: Colors.blue),
                      ),
                      title: Text(item["title"]),
                      subtitle: Text(
                          "${item["subject"]} • Hạn: ${item["deadline"]}"),
                      trailing: _buildStatusChip(item["status"]),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StudentAssignmentDetail(item: item),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case "Đã nộp":
        color = Colors.green;
        break;
      case "Quá hạn":
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }
    return Chip(
      label: Text(status, style: const TextStyle(color: Colors.white)),
      backgroundColor: color,
    );
  }
}
