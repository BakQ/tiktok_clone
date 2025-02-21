import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

/// ✅ `AsyncNotifier<List<VideoModel>>`을 상속하여 비동기 상태 관리
class TimelineViewModel extends AsyncNotifier<List<VideoModel>> {
  // 🔥 현재 저장된 비디오 리스트
  List<VideoModel> _list = [];

  /// 📌 새로운 비디오 업로드 함수
  Future<void> uploadVideo() async {
    state = const AsyncValue.loading(); // ✅ 상태를 `loading`으로 변경하여 UI에 로딩 표시

    await Future.delayed(const Duration(seconds: 2)); // ⏳ 2초 동안 대기 (네트워크 요청 가정)

    final newVideo = VideoModel(title: "${DateTime.now()}"); // 📌 새로운 비디오 생성
    _list = [..._list, newVideo]; // ✅ 기존 리스트에 새 비디오 추가

    state = AsyncValue.data(_list); // 🔥 상태를 업데이트하여 UI가 변경을 감지
  }

  /// 📌 `build()` 함수: ViewModel의 초기 상태 설정
  @override
  FutureOr<List<VideoModel>> build() async {
    await Future.delayed(const Duration(seconds: 5)); // ⏳ 5초 동안 대기 (초기 데이터 로딩)
    return _list; // ✅ 저장된 비디오 리스트 반환
  }
}

final timelineProvider =
    AsyncNotifierProvider<TimelineViewModel, List<VideoModel>>(
  () => TimelineViewModel(),
);
