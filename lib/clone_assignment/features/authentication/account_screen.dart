import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:tiktok_clone/clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone/clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone/clone_assignment/features/authentication/confirmation_code_screen.dart';
import 'package:tiktok_clone/clone_assignment/features/authentication/experience_screen.dart';
import 'package:tiktok_clone/clone_assignment/widgets/auth_boutton.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = "";
  String _email = "";
  DateTime? _selectedDate;
  bool _isSwitchOn = false;

  void _onExperinceTap(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ExperienceScreen(),
      ),
    );

    if (result != null && result["switchValue"] == true) {
      setState(() {
        _isSwitchOn = result["switchValue"];
      });
    }
  }

  //메서드 앞에 언더바를 하면 private 접근자가 된다 플러터는 따로 접근자 변수가 없다 .
  void _onSignUpTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OtpScreen(
          name: _name,
          email: _email,
          birthday: _selectedDate.toString(),
        ),
      ),
    ); // MaterialPageRoute
  }

  String? isEmailValid(String email) {
    if (email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email)) {
      return "Email not valid";
    }
    return null;
  }

  bool isFormValid() {
    return _name.length >= 4 &&
        _email.isNotEmpty &&
        isEmailValid(_email) == null &&
        _selectedDate != null;
  }

  void onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onScaffoldTap,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const FaIcon(
                FontAwesomeIcons.twitter,
                color: Colors.blue,
                size: Sizes.size32,
              ),
            ],
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
                child: Column(
                  children: [
                    Gaps.v10,
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: Sizes.size40),
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            autocorrect: false,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              hintText: 'Name',
                              suffix: (_name.length >= 4)
                                  ? const FaIcon(
                                      FontAwesomeIcons.circleCheck,
                                      color: Colors.green,
                                      size: Sizes.size28,
                                    )
                                  : null,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _name = value; // 이름 상태 업데이트
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),
                          Gaps.v16,
                          TextFormField(
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              hintText: 'Phone number or email address',
                              suffix: (isEmailValid(_email) == null &&
                                      _email.isNotEmpty)
                                  ? const FaIcon(
                                      FontAwesomeIcons.circleCheck,
                                      color: Colors.green,
                                      size: Sizes.size28,
                                    )
                                  : null,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _email = value; // 이메일 상태 업데이트
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              return isEmailValid(value);
                            },
                          ),
                          Gaps.v16,
                          TextFormField(
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'Date of birth',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              suffix: (_selectedDate != null)
                                  ? const FaIcon(
                                      FontAwesomeIcons.circleCheck,
                                      color: Colors.green,
                                      size: Sizes.size28,
                                    )
                                  : null,
                            ),
                            readOnly: true, // 텍스트 필드에서 입력을 막음
                            onTap: () {
                              // Date picker 활성화
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => SizedBox(
                                  height: 300,
                                  child: CupertinoDatePicker(
                                    maximumDate: DateTime.now(),
                                    initialDateTime:
                                        _selectedDate ?? DateTime(2000, 1, 1),
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (date) {
                                      setState(() {
                                        _selectedDate = date;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                            controller: TextEditingController(
                              text: _selectedDate != null
                                  ? "${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}"
                                  : '',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Date of birth is required';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (!_isSwitchOn)
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.size32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: isFormValid()
                              ? () => _onExperinceTap(context)
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isFormValid()
                                ? Colors.black
                                : Colors.grey.shade500,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            _isSwitchOn ? 'Sign up' : 'Next',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        bottomNavigationBar: (_isSwitchOn)
            ? Padding(
                padding: const EdgeInsets.all(Sizes.size40),
                child: GestureDetector(
                  onTap: () => _onSignUpTap(context),
                  child: const AuthBoutton(
                    text: "Sign up",
                    backGroudColor: Colors.blue,
                    textColor: Colors.white,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
