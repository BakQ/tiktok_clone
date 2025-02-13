import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:tiktok_clone/clone_assignment/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;
  File? _selectedImage;

  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  final int _selectedCameraIndex = 0;
  FlashMode _flashMode = FlashMode.off;

  @override
  void initState() {
    super.initState();
    initPermissions();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    if (cameraPermission.isGranted) {
      _hasPermission = true;
      await initCamera();
    }
    setState(() {});
  }

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    if (_cameras.isEmpty) return;

    _cameraController = CameraController(
      _cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.high,
    );
    await _cameraController.initialize();
    setState(() {});
  }

  void _toggleFlash() {
    setState(() {
      _flashMode =
          _flashMode == FlashMode.off ? FlashMode.torch : FlashMode.off;
      _cameraController.setFlashMode(_flashMode);
    });
  }

  Future<void> _switchCamera() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Navigator.pop(context, File(pickedFile.path)); // 이미지 선택 후 현재 화면 종료
    }
  }

  Future<void> _captureImage() async {
    if (!_cameraController.value.isInitialized) return;
    final imageFile = await _cameraController.takePicture();
    Navigator.pop(context, File(imageFile.path)); // 사진 촬영 후 현재 화면 종료
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          _hasPermission && _cameraController.value.isInitialized
              ? CameraPreview(_cameraController)
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          Positioned(
            bottom: Sizes.size24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    _flashMode == FlashMode.off
                        ? Icons.flash_off
                        : Icons.flash_on,
                    color: Colors.white,
                  ),
                  onPressed: _toggleFlash,
                ),
                const SizedBox(width: Sizes.size60),
                IconButton(
                  icon: const Icon(
                    Icons.circle,
                    size: Sizes.size80,
                    color: Colors.white,
                  ),
                  onPressed: _captureImage,
                ),
                const SizedBox(width: Sizes.size60),
                IconButton(
                  icon: const Icon(
                    Icons.cameraswitch,
                    color: Colors.white,
                  ),
                  onPressed: _switchCamera,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CameraBottom(onPickImage: _pickImage),
    );
  }
}

class CameraBottom extends StatelessWidget {
  final VoidCallback onPickImage;

  const CameraBottom({super.key, required this.onPickImage});
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size10),
          child: Row(
            children: [
              const Expanded(child: SizedBox()),
              const Expanded(
                child: Text(
                  'Camera',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onPickImage,
                  child: const Text(
                    'Library',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
