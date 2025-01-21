import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  //TextEditingController는 TextField 위젯에 입력을 감지해서 가져오는 컨트롤러
  final TextEditingController _passwordcontroller = TextEditingController();

  String _password = "";

  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    //
    _passwordcontroller.addListener(() {
      _password = _passwordcontroller.text;
      setState(() {});
    });
  }

  //dispose 할때 usernamecontroller의 위젯을 삭제해주야 한다
  // 삭제안하면 앱이 메모리 풀로 박살나고 말거다.
  //그리고 super.dispose()를 밑에 두는게 깔끔하게 제거되는거다. initState는 위에
  @override
  void dispose() {
    _passwordcontroller.dispose();
    super.dispose();
  }

  //정규식으로 이메일 체크
  bool _isPasswordValid() {
    return _password.isEmpty || _password.length < 8;
  }

  void _onScaffoldTap() {
    //FocusScope는 Flutter에서 **입력 포커스(focus)**를 관리하는 클래스
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_isPasswordValid()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
  }

  void _onClearTap() {
    _passwordcontroller.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Sign up",
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v16,
              TextField(
                //글자입력 정보 받아가는컨트롤러
                controller: _passwordcontroller,
                //자동완성기능도 넣고 뺄수있네 !!!
                autocorrect: false,
                //키보드의 "완료"(Enter) 버튼을 누를 때 실행되는 옵션
                onEditingComplete: _onSubmit,
                //패스워드 타입처럼 만들어줌
                obscureText: _obscureText,
                decoration: InputDecoration(
                  //suffix: 텍스트 필드의 오른쪽 끝에 표시되는 위젯.
                  //prefix: 텍스트 필드의 왼쪽 시작 부분에 표시되는 위젯
                  //suffixIcon 아이콘만 추가할 수 있으며, 기본적으로 패딩이 포함됩니다.
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: FaIcon(
                          FontAwesomeIcons.circleXmark,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          color: Colors.grey.shade500,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                  //input창에 글나오게하는거
                  hintText: "Make it strong!",

                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v10,
              const Text(
                'Your password must have:',
                style: TextStyle(
                    fontSize: Sizes.size14, fontWeight: FontWeight.w700),
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size20,
                    color: !_isPasswordValid()
                        ? Colors.green
                        : Colors.grey.shade400,
                  ),
                  const Text('8 to 20 characters'),
                ],
              ),
              Gaps.v28,
              GestureDetector(
                  onTap: _onSubmit,
                  //부모 전체크기만큼 사이즈박스 만든다.
                  child: FormButton(disabled: _isPasswordValid()))
            ],
          ),
        ),
      ),
    );
  }
}
