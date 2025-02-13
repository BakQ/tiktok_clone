import 'dart:io'; // 파일 시스템을 사용하기 위한 패키지
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart'; // 비디오 플레이어 패키지

class VideoPreviewScreen extends StatefulWidget {
  // ✅ 촬영된 비디오 파일을 전달받는 변수
  final XFile video;
  const VideoPreviewScreen({
    super.key,
    required this.video, // 필수 파라미터
  });

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  // ✅ 비디오 플레이어 컨트롤러
  late final VideoPlayerController _videoPlayerController;

  // 📌 비디오 초기화 함수
  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(
      File(widget.video.path), // 전달받은 비디오 파일 경로
    );

    await _videoPlayerController.initialize(); // 비디오 로드
    await _videoPlayerController.setLooping(true); // 반복 재생 설정
    await _videoPlayerController.play(); // 자동 재생

    setState(() {}); // UI 갱신
  }

  // 📌 위젯이 처음 생성될 때 실행
  @override
  void initState() {
    super.initState();
    _initVideo(); // 비디오 초기화
  }

  // 📌 UI 렌더링
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 배경색 (검은색)
      appBar: AppBar(
        title: const Text('Preview video'), // 상단 앱바 타이틀
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController) // ✅ 비디오 재생
          : const Center(child: CircularProgressIndicator()), // 로딩 화면
    );
  }
}
