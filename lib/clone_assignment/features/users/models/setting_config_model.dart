/// ✅ 앱의 설정 데이터를 저장하는 모델 (데이터 구조 정의)
class SettingConfigModel {
  bool darkMode;

  /// 📌 생성자 (반드시 `muted`와 `autoplay` 값을 전달해야 함)
  SettingConfigModel({
    required this.darkMode,
  });
}
