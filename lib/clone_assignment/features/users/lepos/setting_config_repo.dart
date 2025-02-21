import 'package:shared_preferences/shared_preferences.dart';

/// ✅ `SharedPreferences`를 사용하여 설정 데이터를 저장하는 Repository 클래스
class SettingConfigRepository {
  /// 📌 SharedPreferences에서 사용할 키값 정의
  static const String _darkMode = "darkMode"; // 다크모드

  /// ✅ `SharedPreferences` 인스턴스
  final SharedPreferences _preferences;

  /// 📌 생성자 (SharedPreferences를 주입받음)
  SettingConfigRepository(this._preferences);

  /// ▶ 자동 재생 설정 저장 (비동기)
  Future<void> setDarkMode(bool value) async {
    _preferences.setBool(_darkMode, value);
  }

  /// 🔈 저장된 음소거 상태 불러오기 (기본값: `false`)
  bool isDarkMode() {
    return _preferences.getBool(_darkMode) ?? false;
  }
}
