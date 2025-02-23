import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/clone_assignment/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/utils.dart';

/// ✅ Firebase Auth를 통한 회원가입 관리
class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  /// ✅ 회원가입 기능 실행 (비동기 처리)
  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading(); // 🔄 로딩 상태 표시
    final form = ref.read(signUpForm); // 🔄 입력한 이메일 & 비밀번호 가져오기
    state = await AsyncValue.guard(
      () async => await _authRepo.emailSignUp(
        form["email"], // ✅ 사용자가 입력한 이메일
        form["password"], // ✅ 사용자가 입력한 비밀번호
      ),
    );
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.goNamed(LoginScreen.routeName);
    }
  }
}

/// ✅ 사용자 입력값을 저장하는 Provider (이메일, 비밀번호)
final signUpForm = StateProvider((ref) => {});

/// ✅ 회원가입을 관리하는 ViewModel Provider
final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
