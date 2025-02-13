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

  // ✅ 카메라 컨트롤러 변수 (카메라를 조작하는 객체)
  late final CameraController _cameraController;

  // 📌 카메라 초기화 함수
  Future<void> initCamera() async {
    final cameras = await availableCameras(); // 사용 가능한 카메라 목록 가져오기
    if (cameras.isEmpty) {
      return; // 사용 가능한 카메라가 없으면 함수 종료
    }

    // ✅ 첫 번째 카메라를 사용하여 컨트롤러 생성
    _cameraController = CameraController(
      cameras[0], // 첫 번째 카메라 선택
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
            : // ✅ 카메라 미리보기 표시
            CameraPreview(_cameraController),
      ),
    );
  }
}
