import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/clone_assignment/features/users/lepos/setting_config_repo.dart';
import 'package:tiktok_clone/clone_assignment/features/users/models/setting_config_model.dart';

/// ✅ `PlaybackConfigViewl`: 설정을 관리하는 ViewModel
/// - `ChangeNotifier`를 상속하여 상태 변경 시 UI 업데이트 가능Mode
class SettingConfigViewModel extends Notifier<SettingConfigModel> {
  /// ✅ 로컬 저장소 (SharedPreferences)와 연결된 `Repository`
  final SettingConfigRepository _repository;

  /// 📌 생성자 (`Repository`를 주입받아 사용)
  SettingConfigViewModel(this._repository);

  /// 🔈 다크모드
  void setDarkMode(bool value) {
    _repository.setDarkMode(value); // 로컬 저장소에 값 저장
    state = SettingConfigModel(
      darkMode: value,
    );
  }

  @override
  SettingConfigModel build() {
    return SettingConfigModel(
      darkMode: _repository.isDarkMode(), // ✅ 로컬 저장소에서 값 불러오기
    );
  }
}

final settingConfigProvider =
    NotifierProvider<SettingConfigViewModel, SettingConfigModel>(
  () => throw UnimplementedError(),
);
