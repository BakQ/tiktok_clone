// 📌 AuthenticationRepository (Firebase 회원가입 기능 추가)
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthenticationRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// ✅ 현재 로그인 여부 확인
  bool get isLoggedIn => user != null;

  /// ✅ 현재 로그인된 사용자 정보 반환
  User? get user => _firebaseAuth.currentUser;

  /// ✅ 회원가입 (이메일 & 비밀번호 방식)
  Future<void> emailSignUp(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// ✅ 로그인 기능 (이메일 & 비밀번호 방식)
  Future<void> signIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  /// ✅ 로그아웃 기능 추가
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  /// ✅ 로그인 상태 변경 감지 (로그인/로그아웃 감지 가능)
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();
}

/// ✅ Riverpod Provider로 AuthenticationRepository 관리
final authRepo = Provider((ref) => AuthenticationRepository());

/// ✅ 로그인 상태를 감지하는 StreamProvider (로그인/로그아웃 실시간 감지 가능)
final authState = StreamProvider((ref) {
  final repo = ref.read(authRepo);
  return repo.authStateChanges();
});
