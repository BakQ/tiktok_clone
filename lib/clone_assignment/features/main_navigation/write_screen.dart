import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/clone_assignment/constants/gaps.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isSendEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isSendEnabled = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onCancel() {
    Navigator.pop(context);
  }

  void _onSend() {
    if (_isSendEnabled) {
      // 작성한 내용을 처리하는 로직 추가 가능
      Navigator.pop(context, _controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Scaffold(
        // AppBar: 좌측에 "Cancel" 텍스트 버튼을 배치
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          leadingWidth: 80,
          elevation: 1,
          // leading에 충분한 패딩을 주어 Cancel 텍스트가 보이도록 함
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Center(
              child: GestureDetector(
                onTap: _onCancel,
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          title: const Text(
            "New thread",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        // 본문: 프로필 아바타 오른쪽에 사용자 아이디 "BakQ"와 텍스트 입력창 배치
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundImage:
                    NetworkImage("https://i.pravatar.cc/150?img=5"),
              ),
              Gaps.h10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 사용자 아이디 BakQ 표시
                    const Text(
                      "BakQ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    // 텍스트 입력창 (힌트 텍스트: Start a thread...)
                    TextField(
                      controller: _controller,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: "Start a thread...",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                    ),
                    Gaps.v10,
                    const FaIcon(
                      FontAwesomeIcons.paperclip,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // 하단 BottomAppBar: 키보드가 올라올 때 같이 움직임
        bottomNavigationBar: AnimatedPadding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          duration: const Duration(milliseconds: 200),
          child: BottomAppBar(
            color: Colors.white,
            child: SizedBox(
              height: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Anyone car reply",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  TextButton(
                    onPressed: _isSendEnabled ? _onSend : null,
                    child: Text(
                      "Post",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            _isSendEnabled ? Colors.blue : Colors.blue.shade200,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
