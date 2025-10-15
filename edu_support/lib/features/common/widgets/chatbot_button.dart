import 'package:flutter/material.dart';
import 'dart:async';

class ChatbotButton extends StatefulWidget {
  const ChatbotButton({super.key});

  @override
  State<ChatbotButton> createState() => _ChatbotButtonState();
}

class _ChatbotButtonState extends State<ChatbotButton>
    with SingleTickerProviderStateMixin {
  bool _isOpen = false;
  bool _hasNewMessage = true;
  final List<Map<String, String>> _messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<String> _quickReplies = [
    "Xem điểm của tôi",
    "Hướng dẫn học online",
    "Liên hệ giáo viên",
    "Xem lịch học",
    "Trợ giúp kỹ thuật"
  ];

  void _toggleChat() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) _hasNewMessage = false;
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "text": text});
      _controller.clear();
    });
    _scrollToBottom();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add({
          "sender": "bot",
          "text": _generateBotReply(text),
        });
        _hasNewMessage = !_isOpen;
      });
      _scrollToBottom();
    });
  }

  String _generateBotReply(String userInput) {
    userInput = userInput.toLowerCase();
    if (userInput.contains("điểm")) {
      return "📊 Bạn có thể xem điểm của mình tại trang *Kết quả học tập*.";
    } else if (userInput.contains("học online")) {
      return "💻 Đăng nhập → chọn môn → nhấn *Tham gia lớp học*.";
    } else if (userInput.contains("liên hệ")) {
      return "📞 Liên hệ giáo viên qua email hoặc mục *Liên hệ giáo viên*.";
    } else if (userInput.contains("lịch")) {
      return "🗓️ Xem trong phần *Thời khóa biểu* trên dashboard.";
    } else {
      return "🤖 Mình chưa hiểu rõ lắm, bạn nói cụ thể hơn nhé!";
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 🌫 Background mờ khi mở chat
        if (_isOpen)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleChat,
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),

        // 💬 Hộp chat popup
        if (_isOpen)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 90, right: 20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 330,
                height: 520,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "💬 Hỗ trợ Bright Signs",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: _toggleChat,
                        ),
                      ],
                    ),
                    const Divider(height: 1),

                    // Tin nhắn
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final msg = _messages[index];
                          final isUser = msg["sender"] == "user";
                          return Align(
                            alignment: isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              padding: const EdgeInsets.all(10),
                              constraints:
                                  const BoxConstraints(maxWidth: 230),
                              decoration: BoxDecoration(
                                color: isUser
                                    ? Colors.green[100]
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(12),
                                  topRight: const Radius.circular(12),
                                  bottomLeft:
                                      Radius.circular(isUser ? 12 : 0),
                                  bottomRight:
                                      Radius.circular(isUser ? 0 : 12),
                                ),
                              ),
                              child: Text(
                                msg["text"] ?? "",
                                style: const TextStyle(fontSize: 13.5),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // 💡 Gợi ý nhanh
                    SizedBox(
                      height: 38,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _quickReplies.map((text) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4),
                            child: ActionChip(
                              label: Text(
                                text,
                                style: const TextStyle(fontSize: 12),
                              ),
                              backgroundColor: Colors.blue.shade50,
                              onPressed: () => _sendMessage(text),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Nhập tin nhắn
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: "Nhập tin nhắn...",
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onSubmitted: _sendMessage,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send,
                              color: Colors.blueAccent),
                          onPressed: () => _sendMessage(_controller.text),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

        // 🔵 Nút chatbot tròn (nổi góc màn hình)
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, right: 20),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.blueAccent,
                  onPressed: _toggleChat,
                  child: Icon(
                    _isOpen
                        ? Icons.close
                        : Icons.chat_bubble_outline_rounded,
                    color: Colors.white,
                  ),
                ),
                if (_hasNewMessage)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        "!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
