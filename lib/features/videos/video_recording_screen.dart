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

  // ✅ 전면/후면 카메라 상태 (기본값: 후면 카메라)
  bool _isSelfieMode = false;

  // ✅ 현재 플래시 모드 상태 저장
  late FlashMode _flashMode;

  // ✅ 카메라 컨트롤러 (카메라 조작 객체)
  late CameraController _cameraController;

  // 📌 카메라 초기화 함수 (전면/후면 카메라 선택 가능)
  Future<void> initCamera() async {
    final cameras = await availableCameras(); // 사용 가능한 카메라 목록 가져오기
    if (cameras.isEmpty) return; // 사용 가능한 카메라가 없으면 함수 종료

    // ✅ _isSelfieMode 값에 따라 전면/후면 카메라 선택
    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0], // true면 전면, false면 후면 카메라 사용
      ResolutionPreset.ultraHigh, // 카메라 해상도 설정 (초고화질)
    );

    await _cameraController.initialize(); // 카메라 초기화

    _flashMode = _cameraController.value.flashMode; // 현재 플래시 모드 저장
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

  // 📌 플래시 모드 변경 함수
  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode); // 새로운 플래시 모드 설정
    _flashMode = newFlashMode; // 상태 업데이트
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

                  // ✅ 전면/후면 카메라 전환 및 플래시 설정 버튼 그룹
                  Positioned(
                    top: Sizes.size32, // 화면 위쪽에 위치
                    right: Sizes.size20,
                    child: Column(
                      children: [
                        // 🔄 카메라 전환 버튼 (전면 ↔ 후면)
                        IconButton(
                          color: Colors.white,
                          onPressed: _toggleSelfieMode,
                          icon: const Icon(
                            Icons.cameraswitch,
                          ),
                        ),
                        Gaps.v10,

                        // 🔦 플래시 OFF 버튼
                        IconButton(
                          color: _flashMode == FlashMode.off
                              ? Colors.amber.shade200
                              : Colors.white,
                          onPressed: () => _setFlashMode(FlashMode.off),
                          icon: const Icon(
                            Icons.flash_off_rounded,
                          ),
                        ),
                        Gaps.v10,

                        // 🔥 플래시 ON (항상 켜기) 버튼
                        IconButton(
                          color: _flashMode == FlashMode.always
                              ? Colors.amber.shade200
                              : Colors.white,
                          onPressed: () => _setFlashMode(FlashMode.always),
                          icon: const Icon(
                            Icons.flash_on_rounded,
                          ),
                        ),
                        Gaps.v10,

                        // 🤖 플래시 AUTO 버튼
                        IconButton(
                          color: _flashMode == FlashMode.auto
                              ? Colors.amber.shade200
                              : Colors.white,
                          onPressed: () => _setFlashMode(FlashMode.auto),
                          icon: const Icon(
                            Icons.flash_auto_rounded,
                          ),
                        ),
                        Gaps.v10,

                        // 🔦 플래시 TORCH 모드 (손전등처럼 사용)
                        IconButton(
                          color: _flashMode == FlashMode.torch
                              ? Colors.amber.shade200
                              : Colors.white,
                          onPressed: () => _setFlashMode(FlashMode.torch),
                          icon: const Icon(
                            Icons.flashlight_on_rounded,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
