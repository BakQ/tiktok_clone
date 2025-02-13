import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin {
  // ✅ 카메라 및 마이크 권한 상태 저장
  bool _hasPermission = false;

  // ✅ 전면/후면 카메라 상태 (기본값: 후면 카메라)
  bool _isSelfieMode = false;

  // ✅ 플래시 모드 상태 저장
  late FlashMode _flashMode;

  // ✅ 카메라 컨트롤러 (카메라 조작 객체)
  late CameraController _cameraController;

  // ✅ 촬영 버튼 애니메이션 (크기 변화)
  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );

  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  // ✅ 녹화 진행 상태를 나타내는 애니메이션 (10초 타이머)
  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10), // 녹화 최대 10초
    lowerBound: 0.0,
    upperBound: 1.0,
  );

  // 📌 카메라 초기화 함수 (전면/후면 선택 가능)
  Future<void> initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0], // true면 전면, false면 후면 카메라 사용
      ResolutionPreset.ultraHigh, // 카메라 해상도 설정 (초고화질)
      enableAudio: false, // 오디오 녹음 비활성화
    );

    await _cameraController.initialize(); // 카메라 초기화
    await _cameraController.prepareForVideoRecording(); // 비디오 녹화 준비

    _flashMode = _cameraController.value.flashMode; // 현재 플래시 모드 저장
  }

  // 📌 카메라 및 마이크 권한 요청 함수
  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  // 📌 위젯이 생성될 때 실행되는 함수 (초기화 작업 수행)
  @override
  void initState() {
    super.initState();
    initPermissions();

    // ✅ 녹화 진행 애니메이션 리스너 추가 (UI 업데이트)
    _progressAnimationController.addListener(() {
      setState(() {});
    });

    // ✅ 녹화가 완료되면 자동으로 정지
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  // 📌 전면/후면 카메라 전환 함수
  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  // 📌 플래시 모드 변경 함수
  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  // 📌 녹화 시작 함수
  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward(); // 버튼 크기 커짐 (애니메이션 시작)
    _progressAnimationController.forward(); // 녹화 진행 애니메이션 시작
  }

  // 📌 녹화 정지 함수
  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _buttonAnimationController.reverse(); // 버튼 크기 원래대로
    _progressAnimationController.reset(); // 녹화 진행 상태 초기화

    final video = await _cameraController.stopVideoRecording();

    // ✅ 녹화된 비디오를 미리보기 화면으로 이동
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
        ),
      ),
    );
  }

  // 📌 리소스 정리 (메모리 누수 방지)
  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    _cameraController.dispose();
    super.dispose();
  }

  // 📌 UI 렌더링
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission || !_cameraController.value.isInitialized
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Initializing...",
                    style:
                        TextStyle(color: Colors.white, fontSize: Sizes.size20),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive()
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  CameraPreview(_cameraController), // ✅ 카메라 미리보기

                  // ✅ 전면/후면 카메라 전환 및 플래시 설정 버튼 그룹
                  Positioned(
                    top: Sizes.size20,
                    right: Sizes.size20,
                    child: Column(
                      children: [
                        IconButton(
                          color: Colors.white,
                          onPressed: _toggleSelfieMode,
                          icon: const Icon(Icons.cameraswitch),
                        ),
                        Gaps.v10,
                        IconButton(
                          color: _flashMode == FlashMode.off
                              ? Colors.amber.shade200
                              : Colors.white,
                          onPressed: () => _setFlashMode(FlashMode.off),
                          icon: const Icon(Icons.flash_off_rounded),
                        ),
                        Gaps.v10,
                        IconButton(
                          color: _flashMode == FlashMode.always
                              ? Colors.amber.shade200
                              : Colors.white,
                          onPressed: () => _setFlashMode(FlashMode.always),
                          icon: const Icon(Icons.flash_on_rounded),
                        ),
                        Gaps.v10,
                        IconButton(
                          color: _flashMode == FlashMode.auto
                              ? Colors.amber.shade200
                              : Colors.white,
                          onPressed: () => _setFlashMode(FlashMode.auto),
                          icon: const Icon(Icons.flash_auto_rounded),
                        ),
                      ],
                    ),
                  ),

                  // ✅ 녹화 버튼
                  Positioned(
                    bottom: Sizes.size40,
                    child: GestureDetector(
                      onTapDown: _startRecording,
                      onTapUp: (details) => _stopRecording(),
                      child: ScaleTransition(
                        scale: _buttonAnimation,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // ✅ 녹화 진행 표시 (원형 프로그레스 바)
                            SizedBox(
                              width: Sizes.size80 + Sizes.size14,
                              height: Sizes.size80 + Sizes.size14,
                              child: CircularProgressIndicator(
                                color: Colors.red.shade400,
                                strokeWidth: Sizes.size6,
                                value: _progressAnimationController.value,
                              ),
                            ),

                            // ✅ 녹화 버튼 (빨간색 원)
                            Container(
                              width: Sizes.size80,
                              height: Sizes.size80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
