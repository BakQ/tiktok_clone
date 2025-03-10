import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/clone_assignment/widgets/auth_boutton.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_form_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_boutton.dart';
import 'package:tiktok_clone/utils.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = "login";
  static String routeURL = "/login";
  const LoginScreen({super.key});

  //로그인 화면으로 보낸다 .
  void _onSignUpTap(BuildContext context) {
    //pusho 는 기존화면위에 올리는거고 pop는 제일 위에꺼 빼 먹는거다 .
    context.pop();
  }

  //메서드 앞에 언더바를 하면 private 접근자가 된다 플러터는 따로 접근자 변수가 없다 .
  void _onEmailLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
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
              "Log in to TikTok",
              style: TextStyle(
                fontSize: Sizes.size24,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            Gaps.v20,
            const Opacity(
              opacity: 0.7,
              child: Text(
                "Manage your account, check notifications, comment on videos, and more.",
                style: TextStyle(
                  fontSize: Sizes.size16,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Gaps.v40,
            GestureDetector(
              onTap: () => _onEmailLoginTap(context),
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
      bottomNavigationBar: Container(
        color: isDarkMode(context)
            ? Theme.of(context).appBarTheme.backgroundColor
            : Colors.grey.shade50,
        //경계선 제어

        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(
              top: Sizes.size32,
              bottom: Sizes.size64,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an"),
                Gaps.h5,
                GestureDetector(
                  onTap: () => _onSignUpTap(context),
                  child: Text(
                    'Sign up',
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
