import 'package:flutter/widgets.dart';

/// ✅ `VideoConfigData`는 InheritedWidget을 상속받아
/// `autoMute` 상태와 `toggleMuted` 함수를 전역에서 공유할 수 있도록 한다.
class VideoConfigData extends InheritedWidget {
  /// 📌 자동 음소거 여부 (true: 음소거, false: 해제)
  final bool autoMute;

  /// 📌 자동 음소거 설정을 변경하는 함수 (true <-> false 전환)
  final void Function() toggleMuted;

  /// 📌 생성자에서 상태 및 상태 변경 함수를 받음
  const VideoConfigData({
    super.key,
    required this.toggleMuted,
    required this.autoMute,
    required super.child, // 상속받은 child를 받아야 InheritedWidget이 정상 동작
  });

  /// 📌 `of(context)` 메서드를 통해 가장 가까운 `VideoConfigData` 인스턴스를 찾아 반환
  static VideoConfigData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
  }

  /// 📌 `updateShouldNotify`는 위젯이 업데이트될지 여부를 결정하는 메서드
  /// - 항상 `true`를 반환하여 상태가 변경될 때마다 UI를 업데이트하도록 설정
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

/// ✅ `VideoConfig`는 StatefulWidget으로 `autoMute` 상태를 관리하고
/// `VideoConfigData`를 통해 하위 위젯에 상태를 전달한다.
class VideoConfig extends StatefulWidget {
  /// 📌 앱의 나머지 부분을 감싸는 역할을 하는 child 위젯
  final Widget child;

  const VideoConfig({
    super.key,
    required this.child,
  });

  @override
  State<VideoConfig> createState() => _VideoConfigState();
}

/// ✅ `_VideoConfigState`는 `autoMute` 상태를 관리하는 역할을 한다.
class _VideoConfigState extends State<VideoConfig> {
  /// 📌 자동 음소거 상태 (기본값: false)
  bool autoMute = false;

  /// 📌 `toggleMuted` 함수는 `autoMute` 값을 반대로 변경하는 역할을 한다.
  void toggleMuted() {
    setState(() {
      autoMute = !autoMute; // 🔄 true ↔ false 전환
    });
  }

  /// ✅ `VideoConfigData`를 사용하여 상태를 하위 위젯에 제공한다.
  @override
  Widget build(BuildContext context) {
    return VideoConfigData(
      toggleMuted: toggleMuted, // 상태 변경 함수 전달
      autoMute: autoMute, // 현재 상태 전달
      child: widget.child, // 앱 전체를 감싸는 child 위젯
    );
  }
}
