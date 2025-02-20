/// ✅ 앱의 설정 데이터를 저장하는 모델 (데이터 구조 정의)
class PlaybackConfigModel {
  /// 🔈 음소거 상태 (true: 음소거, false: 해제)
  bool muted;

  /// ▶ 자동 재생 여부 (true: 자동 재생 활성화, false: 비활성화)
  bool autoplay;

  /// 📌 생성자 (반드시 `muted`와 `autoplay` 값을 전달해야 함)
  PlaybackConfigModel({
    required this.muted,
    required this.autoplay,
  });
}
