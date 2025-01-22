import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/clone_assignment/features/authentication/account_screen.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../widgets/auth_boutton.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  //메서드 앞에 언더바를 하면 private 접근자가 된다 플러터는 따로 접근자 변수가 없다 .
  void _onAccountTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AccountScreen(),
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
              Gaps.v10,
              const FaIcon(
                FontAwesomeIcons.twitter,
                color: Colors.blue,
                size: Sizes.size32,
              ),
              Gaps.v60,
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Text(
                  "See what's happening\nin the world right now.",
                  style: TextStyle(
                    fontSize: Sizes.size32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Gaps.v60,
              const AuthBoutton(
                  icon: FaIcon(FontAwesomeIcons.google),
                  text: "Continue with Google"),
              Gaps.v16,
              const AuthBoutton(
                  icon: FaIcon(FontAwesomeIcons.apple),
                  text: "Continue with Apple"),
              Gaps.v10,
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300, // 선의 색상
                      thickness: 1, // 선의 두께
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0), // "or" 양옆의 여백
                    child: Text(
                      "or",
                      style: TextStyle(
                        color: Colors.grey, // 텍스트 색상
                        fontSize: 14, // 텍스트 크기
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),
                ],
              ),
              Gaps.v10,
              GestureDetector(
                onTap: () => _onAccountTap(context),
                child: const AuthBoutton(
                  text: "Continue with Apple",
                  backGroudColor: Colors.black,
                  textColor: Colors.white,
                ),
              ),
              Gaps.v20,
              Center(
                child: RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'By signing up, you agree to our ',
                    style: TextStyle(
                      color: Colors.grey.shade600, // 기본 텍스트 색상
                      fontSize: Sizes.size16, // 기본 텍스트 크기
                    ),
                    children: const [
                      TextSpan(
                        text: 'Terms',
                        style: TextStyle(
                          color: Colors.blue, // 하이라이트 텍스트 색상
                          decoration: TextDecoration.underline, // 밑줄 추가
                        ),
                      ),
                      TextSpan(
                        text: ', ',
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ', and ',
                      ),
                      TextSpan(
                        text: 'Cookie Use',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: '.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Have an account already?'),
                Gaps.h5,
                //제스쳐 위젯
                Text(
                  'Log in',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
