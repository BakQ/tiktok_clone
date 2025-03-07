import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone/clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone/clone_assignment/features/authentication/password_screen.dart';
import 'package:tiktok_clone/clone_assignment/widgets/auth_boutton.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.name,
    required this.email,
    required this.birthday,
  });

  final String name, email, birthday;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String?> _otpValues =
      List.generate(6, (_) => null); // 각 필드의 값을 저장할 리스트

  // code 입력 완료 유무
  bool _isOtpCompleted = false;
  // 올바른 code 유무
  bool _isInvalidOtp = false;

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      // 각 TextFormField의 onSaved 호출
      _formKey.currentState!.save();
      // 리스트를 문자열로 합치기
      final String otpCode = _otpValues.join();
      // 전송된 코드값
      const String rightCode = '056022';

      if (otpCode == rightCode) {
        _isOtpCompleted = true;
        _isInvalidOtp = false;
      } else {
        _isOtpCompleted = false;
        _isInvalidOtp = true;

        _formKey.currentState!.reset();
      }
      setState(() {});
    }
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: Sizes.size44,
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        showCursor: false,
        style: const TextStyle(
          fontSize: Sizes.size28,
          fontWeight: FontWeight.w800,
        ),
        decoration: InputDecoration(
          // 하단의 글자 수 표시 제거
          counterText: "",
          // 입력값과 underline 간의 간격 설정
          contentPadding: const EdgeInsets.only(bottom: Sizes.size16),
          border: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 3,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
              width: 3,
            ),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty || value.length != 1) {
            return '';
          }
          return null;
        },
        onSaved: (value) {
          // 입력값 저장
          _otpValues[index] = value;
        },
        onChanged: (value) {
          // 모든 값 입력 완료
          if (value.isNotEmpty && index == 5) {
            FocusScope.of(context).unfocus();
            _handleSubmit();
            // 현재 필드에 값이 있고(즉, 값을 입력해서 onChanged 이벤트가 발생하였음), 아직 끝이 아니라면 다음칸으로 이동
          } else if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
            // 현재 필드에 값이 없고(즉, 값을 제거해서 onChanged 이벤트가 발생하였음), 시작위치가 아니라면 이전칸으로 이동
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).previousFocus(); // 이전 필드로 이동
            _isOtpCompleted = false;
            setState(() {});
          }
        },
      ),
    );
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onPasswordTap() {
    if (!_isOtpCompleted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const FaIcon(
            FontAwesomeIcons.twitter,
            color: Colors.blue,
            size: Sizes.size32,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size32,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gaps.v12,
                    const Text(
                      "We sent you a code",
                      style: TextStyle(
                        fontSize: Sizes.size28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Gaps.v20,
                    Text(
                      "Enter it below to verify",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      "${widget.email}.",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Gaps.v28,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        6,
                        (index) => _buildOtpField(index),
                      ),
                    ),
                    Gaps.v20,
                    if (_isInvalidOtp)
                      const Align(
                        alignment: Alignment.center,
                        child: Text("You entered wrong code! try again.",
                            style: TextStyle(
                              color: Colors.red,
                            )),
                      ),
                    if (_isOtpCompleted)
                      const Align(
                        alignment: Alignment.center,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: Colors.green,
                          size: Sizes.size32,
                        ),
                      ),
                    Gaps.v80,
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.only(
                  bottom: Sizes.size52,
                  top: Sizes.size16,
                  left: Sizes.size32,
                  right: Sizes.size32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Didn't receive email?",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Gaps.v14,
                    GestureDetector(
                      onTap: _onPasswordTap,
                      child: AuthBoutton(
                        text: "Next",
                        backGroudColor:
                            _isOtpCompleted ? Colors.black : Colors.grey,
                        textColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
