import 'package:flutter/material.dart';
import 'package:tiktok_clone/clone_assignment/features/users/lepos/setting_config_repo.dart';
import 'package:tiktok_clone/clone_assignment/features/users/models/setting_config_model.dart';

/// ✅ `PlaybackConfigViewl`: 설정을 관리하는 ViewModel
/// - `ChangeNotifier`를 상속하여 상태 변경 시 UI 업데이트 가능Mode
class SettingConfigViewModel extends ChangeNotifier {
  /// ✅ 로컬 저장소 (SharedPreferences)와 연결된 `Repository`
  final SettingConfigRepository _repository;

  /// ✅ 앱의 재생 설정 데이터를 관리하는 `Model`
  late final SettingConfigModel _model = SettingConfigModel(
    darkMode: _repository.isDarkMode(), // 로컬 저장소에서 음소거 상태 불러오기소에서 자동 재생 상태 불러오기
  );

  /// 📌 생성자 (`Repository`를 주입받아 사용)
  SettingConfigViewModel(this._repository);

  /// 🔈 `muted` Getter (현재 음소거 상태 조회)
  bool get darkMode => _model.darkMode;

  /// 🔈 다크모드
  void setDarkMode(bool value) {
    _repository.setDarkMode(value); // 로컬 저장소에 값 저장
    _model.darkMode = value; // `Model` 데이터 업데이트
    notifyListeners(); // 📢 UI 업데이트
  }
}
