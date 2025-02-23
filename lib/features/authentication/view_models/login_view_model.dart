import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/utils.dart';

/// ✅ Firebase Auth를 통한 로그인 관리
class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }

  /// ✅ 로그인 실행 (이메일 & 비밀번호 방식)
  Future<void> login(
    String email,
    String password,
    BuildContext context,
  ) async {
    state = const AsyncValue.loading(); // 🔄 로딩 상태 적용
    state = await AsyncValue.guard(
      () async => await _repository.signIn(email, password),
    );

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error); // ❌ Firebase 오류 메시지 표시
    } else {
      context.go("/home"); // ✅ 로그인 성공 시 홈 화면으로 이동
    }
  }
}

/// ✅ 로그인 기능을 관리하는 Provider
final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () => LoginViewModel(),
);
