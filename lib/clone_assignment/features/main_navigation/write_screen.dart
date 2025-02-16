import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone/clone_assignment/features/videos/video_recording_screen.dart';
import 'package:tiktok_clone/clone_assignment/utils.dart'; // isDarkMode 함수가 정의되어 있다고 가정

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isSendEnabled = false;
  File? _selectedImage; // 선택한 이미지 저장

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

  Future<void> _onPostVideoButtonTap() async {
    final selectedImage = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const VideoRecordingScreen(),
      ),
    );

    if (selectedImage != null && selectedImage is File) {
      setState(() {
        _selectedImage = selectedImage;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 현재 다크모드 여부 판별 (isDarkMode 함수는 BuildContext 필요)
    final bool dark = isDarkMode(context);
    final Color backgroundColor = dark ? Colors.black : Colors.white;
    final Color textColor = dark ? Colors.white : Colors.black;
    final Color hintColor = dark ? Colors.grey.shade400 : Colors.grey;
    // BottomAppBar의 배경은 AppBar와 동일하게 설정
    final Color bottomBarColor = backgroundColor;

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: Scaffold(
        backgroundColor: backgroundColor,
        // AppBar: 좌측에 "Cancel" 텍스트 버튼을 배치
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: backgroundColor,
          leadingWidth: 80,
          elevation: 1,
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Center(
              child: GestureDetector(
                onTap: _onCancel,
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            "New thread",
            style: TextStyle(color: textColor),
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
                    Text(
                      "BakQ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                    // 텍스트 입력창 위에 선택한 이미지가 있으면 표시
                    if (_selectedImage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.file(
                                _selectedImage!,
                                height: 300,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: _removeImage,
                                child: const CircleAvatar(
                                  backgroundColor: Colors.black54,
                                  radius: 16,
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    TextField(
                      controller: _controller,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: "Start a thread...",
                        hintStyle: TextStyle(
                          color: hintColor,
                        ),
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                      style: TextStyle(color: textColor),
                    ),
                    Gaps.v10,
                    GestureDetector(
                      onTap: _onPostVideoButtonTap,
                      child: FaIcon(
                        FontAwesomeIcons.paperclip,
                        color: hintColor,
                      ),
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
            color: bottomBarColor,
            child: SizedBox(
              height: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Anyone can reply",
                    style: TextStyle(
                      fontSize: 18,
                      color: hintColor,
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
