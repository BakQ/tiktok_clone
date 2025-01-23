import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone/clone_assignment/constants/sizes.dart';

class InterestsScreen extends StatelessWidget {
  const InterestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const Padding(
        padding: EdgeInsets.all(
          Sizes.size20,
        ),
        child: Column(
          children: [
            Gaps.v20,
            Text(
              "What do you want to see on Twitter?",
              style: TextStyle(
                fontSize: Sizes.size28 + Sizes.size2,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.v10,
            Text(
              "Select at least 3 interests to  personalize your Twitter experience. They will be visible on your profile.",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
