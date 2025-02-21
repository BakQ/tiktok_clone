import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repos/playback_config_repo.dart';

/// ✅ `PlaybackConfigViewModel`: 앱의 재생 설정을 관리하는 ViewModel
class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository; // 📌 로컬 저장소 연동

  /// 📌 생성자: `PlaybackConfigRepository`를 주입받아 사용
  PlaybackConfigViewModel(this._repository);

  /// 🔈 음소거 상태 변경 함수
  void setMuted(bool value) {
    _repository.setMuted(value); // ✅ 로컬 저장소에 값 저장
    state = PlaybackConfigModel(
      muted: value,
      autoplay: state.autoplay, // 기존 자동재생 값 유지
    );
  }

  /// ▶ 자동 재생 상태 변경 함수
  void setAutoplay(bool value) {
    _repository.setAutoplay(value); // ✅ 로컬 저장소에 값 저장
    state = PlaybackConfigModel(
      muted: state.muted, // 기존 음소거 값 유지
      autoplay: value,
    );
  }

  /// ✅ `build()` → `Notifier`의 초기 상태를 반환하는 함수
  /// - `NotifierProvider`가 실행될 때 자동으로 호출됨
  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      muted: _repository.isMuted(), // ✅ 로컬 저장소에서 값 불러오기
      autoplay: _repository.isAutoplay(),
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);
