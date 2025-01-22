import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone/clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone/clone_assignment/widgets/auth_boutton.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({super.key});

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: const FaIcon(
          FontAwesomeIcons.twitter,
          color: Colors.blue,
          size: Sizes.size32,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v20,
            const Text(
              'Customize your experience',
              style: TextStyle(
                fontSize: Sizes.size28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.v20,
            const Text(
              'Track where you see Twitter\ncontent across the web',
              style: TextStyle(
                  fontSize: Sizes.size20, fontWeight: FontWeight.bold),
            ),
            Gaps.v20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 텍스트
                const Expanded(
                  child: Text(
                    'Twitter uses this data to personalize your experience. This web browsing history will never be stored with your name, email, or phone number.',
                    style: TextStyle(
                      fontSize: Sizes.size16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),

                // 스위치
                Switch(
                  value: isCheck, // 기본값
                  onChanged: (bool value) {
                    isCheck = value;
                    setState(() {});
                  },
                ),
              ],
            ),
            Gaps.v20,
            RichText(
              text: const TextSpan(
                text: 'By signing up, you agree to our ',
                style: TextStyle(
                  fontSize: Sizes.size14,
                  color: Colors.black, // 기본 텍스트 색상
                ),
                children: [
                  TextSpan(
                    text: 'Terms',
                    style: TextStyle(
                      color: Colors.blue, // 파란색 텍스트
                      fontSize: Sizes.size14,
                    ),
                  ),
                  TextSpan(
                    text: ', ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Sizes.size14,
                    ),
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: Colors.blue, // 파란색 텍스트
                      fontSize: Sizes.size14,
                    ),
                  ),
                  TextSpan(
                    text: ', and',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Sizes.size14,
                    ),
                  ),
                  TextSpan(
                    text: ' Cookie Use',
                    style: TextStyle(
                      color: Colors.blue, // 파란색 텍스트
                      fontSize: Sizes.size14,
                    ),
                  ),
                  TextSpan(
                    text:
                        '. Twitter may use your contact information, including your email address and phone number for purposes outlined in our ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Sizes.size14,
                    ),
                  ),
                  TextSpan(
                    text: 'Privacy Policy .',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Sizes.size14,
                    ),
                  ),
                  TextSpan(
                    text: 'Learn more',
                    style: TextStyle(
                      color: Colors.blue, // 파란색 텍스트
                      fontSize: Sizes.size14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Sizes.size40),
        child: GestureDetector(
          onTap: isCheck
              ? () {
                  Navigator.of(context)
                      .pop({"isReturning": true, "switchValue": isCheck});
                }
              : null,
          child: AuthBoutton(
            text: "Next",
            backGroudColor: isCheck ? Colors.black : Colors.grey,
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
