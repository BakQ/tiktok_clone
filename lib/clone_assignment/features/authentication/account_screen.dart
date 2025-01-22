import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone/clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone/clone_assignment/widgets/auth_boutton.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
              const Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Cancle',
                      style: TextStyle(
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.twitter,
                    color: Colors.blue,
                    size: Sizes.size32,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Text(
                  "Create your account",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: Sizes.size32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Gaps.v40,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
                //속성을 통해 입력된 값이 유효한지 확인하는 간단한 검증 로직을 포함합니다.
                validator: (value) {
                  //return 'i dont like your email';
                  //return null 을 주면 이상없는게 된다.?
                  //validator에서 null을 반환하면 입력 값이 유효하다고 간주되며, 폼 검증이 성공하면 onSaved 함수가 호출되어 데이터를 저장할 수 있습니다.
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {}
                },
              ),
              Gaps.v16,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Phone number or email address',
                ),
                validator: (value) {
                  return 'wrong password';
                },
              ),
              Gaps.v16,
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Date of birth',
                ),
                validator: (value) {
                  return 'wrong password';
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          SizedBox(
            width: 80, // 버튼의 가로 크기
            height: 40, // 버튼의 세로 크기
            child: ElevatedButton(
              onPressed: () {
                // Next 버튼 동작
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // 버튼 색상
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // 둥근 모서리
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 14), // 텍스트 크기
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
