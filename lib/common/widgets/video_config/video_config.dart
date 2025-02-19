import 'package:flutter/widgets.dart';

// /// ✅ `VideoConfig`는 `ChangeNotifier`를 상속받아
// /// `autoMute` 상태를 관리하고 변경될 때 UI를 자동으로 업데이트하는 역할을 한다.
// class VideoConfig extends ChangeNotifier {
//   /// 📌 자동 음소거 상태 (기본값: `false`)
//   bool autoMute = false;

//   /// 📌 `toggleAutoMute` 함수는 `autoMute` 상태를 변경하고
//   /// `notifyListeners()`를 호출하여 UI를 업데이트한다.
//   void toggleAutoMute() {
//     autoMute = !autoMute; // 🔄 true ↔ false 전환
//     notifyListeners(); // 📢 상태 변경 알림 (UI 업데이트)
//   }
// }

// /// ✅ `videoConfig`는 `VideoConfig` 클래스의 싱글턴 인스턴스이다.
// /// 앱 어디에서든 `videoConfig.autoMute`를 가져오거나 `toggleAutoMute()`를 호출할 수 있음.
// final videoConfig = VideoConfig();

final videoConfig =
    ValueNotifier(false);// 단일 값(value)만 관리할 때 사용되는 간단한 상태 관리 클래스