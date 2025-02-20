import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/playback_config_repo.dart';

/// ✅ `PlaybackConfigViewModel`: 설정을 관리하는 ViewModel
/// - `ChangeNotifier`를 상속하여 상태 변경 시 UI 업데이트 가능
class PlaybackConfigViewModel extends ChangeNotifier {
  /// ✅ 로컬 저장소 (SharedPreferences)와 연결된 `Repository`
  final PlaybackConfigRepository _repository;

  /// ✅ 앱의 재생 설정 데이터를 관리하는 `Model`
  late final PlaybackConfigModel _model = PlaybackConfigModel(
    muted: _repository.isMuted(), // 로컬 저장소에서 음소거 상태 불러오기
    autoplay: _repository.isAutoplay(), // 로컬 저장소에서 자동 재생 상태 불러오기
  );

  /// 📌 생성자 (`Repository`를 주입받아 사용)
  PlaybackConfigViewModel(this._repository);

  /// 🔈 `muted` Getter (현재 음소거 상태 조회)
  bool get muted => _model.muted;

  /// ▶ `autoplay` Getter (현재 자동 재생 상태 조회)
  bool get autoplay => _model.autoplay;

  /// 🔈 음소거 상태 변경 함수
  void setMuted(bool value) {
    _repository.setMuted(value); // 로컬 저장소에 값 저장
    _model.muted = value; // `Model` 데이터 업데이트
    notifyListeners(); // 📢 UI 업데이트
  }

  /// ▶ 자동 재생 상태 변경 함수
  void setAutoplay(bool value) {
    _repository.setAutoplay(value); // 로컬 저장소에 값 저장
    _model.autoplay = value; // `Model` 데이터 업데이트
    notifyListeners(); // 📢 UI 업데이트
  }
}
