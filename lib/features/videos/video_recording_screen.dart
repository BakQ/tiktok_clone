import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  // ✅ 카메라 및 마이크 권한 상태 저장 (기본값: false)
  bool _hasPermission = false;

  bool _isSelfieMode = false;
  late CameraController _cameraController;

  // 📌 카메라 초기화 함수 (전면/후면 카메라 선택 가능)
  Future<void> initCamera() async {
    final cameras = await availableCameras(); // 사용 가능한 카메라 목록 가져오기
    if (cameras.isEmpty) {
      return; // 사용 가능한 카메라가 없으면 함수 종료
    }

    // ✅ _isSelfieMode 값에 따라 전면/후면 카메라 선택
    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0], // true면 전면, false면 후면 카메라 사용
      ResolutionPreset.ultraHigh, // 카메라 해상도 설정 (초고화질)
    );

    await _cameraController.initialize(); // 카메라 초기화
  }

  // 📌 카메라 및 마이크 권한 요청 함수
  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request(); // 카메라 권한 요청
    final micPermission = await Permission.microphone.request(); // 마이크 권한 요청

    // ✅ 사용자가 권한을 거부했는지 확인
    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      // ✅ 모든 권한이 허용된 경우
      _hasPermission = true;
      await initCamera(); // 카메라 초기화
      setState(() {}); // 화면 갱신
    }
  }

  // 📌 위젯이 생성될 때 실행되는 함수 (초기화 작업 수행)
  @override
  void initState() {
    super.initState();
    initPermissions(); // 권한 요청 및 카메라 초기화
  }

  // 📌 전면/후면 카메라 전환 함수
  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode; // ✅ 상태 변경 (전면 ↔ 후면)
    await initCamera(); // 변경된 상태로 카메라 다시 초기화
    setState(() {}); // UI 갱신
  }

  // 📌 UI 렌더링
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 배경색 (검은색)

      // ✅ 화면 전체 크기로 설정
      body: SizedBox(
        width: MediaQuery.of(context).size.width, // 화면 너비를 전체로 설정
        child: !_hasPermission || !_cameraController.value.isInitialized
            ? // ✅ 카메라가 아직 준비되지 않았다면 로딩 UI 표시
            const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Initializing...", // 초기화 중 메시지
                    style:
                        TextStyle(color: Colors.white, fontSize: Sizes.size20),
                  ),
                  Gaps.v20, // 간격 추가
                  CircularProgressIndicator.adaptive() // 로딩 인디케이터
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  CameraPreview(_cameraController), // ✅ 카메라 미리보기

                  // ✅ 전면/후면 카메라 전환 버튼
                  Positioned(
                    top: Sizes.size32, // 화면 위쪽에 위치
                    left: Sizes.size20, // 왼쪽 정렬
                    child: IconButton(
                      color: Colors.white, // 버튼 색상 (흰색)
                      onPressed: _toggleSelfieMode, // 전환 함수 실행
                      icon: const Icon(
                        Icons.cameraswitch, // 카메라 전환 아이콘
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
