import 'package:shared_preferences/shared_preferences.dart';

/// ✅ `SharedPreferences`를 사용하여 설정 데이터를 저장하는 Repository 클래스
class PlaybackConfigRepository {
  /// 📌 SharedPreferences에서 사용할 키값 정의
  static const String _autoplay = "autoplay"; // 자동 재생 키
  static const String _muted = "muted"; // 음소거 키

  /// ✅ `SharedPreferences` 인스턴스
  final SharedPreferences _preferences;

  /// 📌 생성자 (SharedPreferences를 주입받음)
  PlaybackConfigRepository(this._preferences);

  /// 🔈 음소거 설정 저장 (비동기)
  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  /// ▶ 자동 재생 설정 저장 (비동기)
  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoplay, value);
  }

  /// 🔈 저장된 음소거 상태 불러오기 (기본값: `false`)
  bool isMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  /// ▶ 저장된 자동 재생 상태 불러오기 (기본값: `false`)
  bool isAutoplay() {
    return _preferences.getBool(_autoplay) ?? false;
  }
}
