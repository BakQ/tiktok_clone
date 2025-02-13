import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_boutton.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  //로그인 화면으로 보낸다 .
  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    ); // MaterialPageRoute
  }

  //메서드 앞에 언더바를 하면 private 접근자가 된다 플러터는 따로 접근자 변수가 없다 .
  void _onEmailTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const UsernameScreen(),
      ),
    ); // MaterialPageRoute
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //안전 영역 그려주는 위젯
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size40,
        ),
        child: Column(
          children: [
            Gaps.v80,
            const Text(
              'Sign up for TikTok',
              style: TextStyle(
                  fontSize: Sizes.size24, fontWeight: FontWeight.w700),
            ),
            Gaps.v20,
            const Text(
              'Create a profile, follow other accounts, make your own videos, and more.',
              style: TextStyle(
                fontSize: Sizes.size16,
                color: Colors.black45,
              ),
              textAlign: TextAlign.center,
            ),
            Gaps.v40,
            GestureDetector(
              onTap: () => _onEmailTap(context),
              child: const AuthBoutton(
                  icon: FaIcon(FontAwesomeIcons.user),
                  text: "Use email & password"),
            ),
            Gaps.v16,
            const AuthBoutton(
                icon: FaIcon(FontAwesomeIcons.apple),
                text: "Continue with Apple"),
          ],
        ),
      )),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade50,
        //경계선 제어
        elevation: 2,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size32,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account?'),
                Gaps.h5,
                //제스쳐 위젯
                GestureDetector(
                  onTap: () => _onLoginTap(context),
                  child: Text(
                    'Log in',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
