import 'package:flutter/material.dart';

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final List<Map<String, String>> _messages = [
    {
      "sender": "user",
      "text": "Tôi muốn hỏi về cách tra cứu tiến độ học tập của em A?",
    },
    {
      "sender": "bot",
      "text":
          "Chào bạn, đây là khung chat hỗ trợ tự động của BRIGHT SIGNS. Chúng tôi rất vui lòng được hỗ trợ bạn.",
    },
  ];

  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add({"sender": "user", "text": _controller.text.trim()});
      _controller.clear();
      // Bot trả lời demo
      _messages.add({
        "sender": "bot",
        "text": "Cảm ơn bạn đã liên hệ, chúng tôi sẽ phản hồi sớm."
      });
    });
  }

  // Widget _buildMessage(Map<String, String> message) {
  //   bool isUser = message["sender"] == "user";
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisAlignment:
  //           isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
  //       children: [
  //         if (!isUser)
  //           const CircleAvatar(
  //             backgroundColor: Colors.blueAccent,
  //             ,
  //           ),
  //         if (!isUser) const SizedBox(width: 8),
  //         Flexible(
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
  //             decoration: BoxDecoration(
  //               color: isUser ? Colors.blueAccent : Colors.grey.shade200,
  //               borderRadius: BorderRadius.only(
  //                 topLeft: const Radius.circular(16),
  //                 topRight: const Radius.circular(16),
  //                 bottomLeft:
  //                     isUser ? const Radius.circular(16) : Radius.zero,
  //                 bottomRight:
  //                     isUser ? Radius.zero : const Radius.circular(16),
  //               ),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black.withOpacity(0.05),
  //                   blurRadius: 4,
  //                   offset: const Offset(2, 2),
  //                 ),
  //               ],
  //             ),
  //             child: Text(
  //               message["text"]!,
  //               style: TextStyle(
  //                 color: isUser ? Colors.white : Colors.black87,
  //                 fontSize: 16,
  //               ),
  //             ),
  //           ),
  //         ),
  //         if (isUser) const SizedBox(width: 8),
  //         if (isUser)
  //           const CircleAvatar(
  //             backgroundColor: Colors.green,
  //             child: Icon(Icons.person, color: Colors.white),
  //           ),
  //       ],
  //     ),
  //   );
  // }
  Widget _buildMessage(Map<String, String> message) {
  bool isUser = message["sender"] == "user";
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isUser)
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/images/Bright_signs_logo.jpg"),
          ),
        if (!isUser) const SizedBox(width: 8),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isUser ? Colors.blueAccent : Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: isUser ? const Radius.circular(16) : Radius.zero,
                bottomRight: isUser ? Radius.zero : const Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(2, 2),
                ),
              ],
            ),
            child: Text(
              message["text"]!,
              style: TextStyle(
                color: isUser ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
        ),
        if (isUser) const SizedBox(width: 8),
        if (isUser)
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage("assets/images/user-avatar-default.jpg"),
          ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hỗ trợ khách hàng"),
        backgroundColor: Colors.blueAccent,
        elevation: 2,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              itemCount: _messages.length,
              itemBuilder: (context, index) =>
                  _buildMessage(_messages[index]),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, -2),
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Nhập tin nhắn...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blueAccent),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
