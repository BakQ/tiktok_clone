import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _isPrivate = false;

  @override
  Widget build(BuildContext context) {
    // 옵션 항목들을 Map 형태로 정의합니다.
    final List<Map<String, dynamic>> privacyOptions = [
      {
        'icon': FontAwesomeIcons.at,
        'title': 'Mentions',
        'trailing': const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Everyone",
              style: TextStyle(fontSize: Sizes.size14),
            ),
            SizedBox(width: 4),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size20,
              color: Colors.grey,
            ),
          ],
        ),
      },
      {
        'icon': FontAwesomeIcons.volumeXmark,
        'title': 'Muted',
      },
      {
        'icon': FontAwesomeIcons.eyeSlash,
        'title': 'Hidden Words',
      },
      {
        'icon': FontAwesomeIcons.userGroup,
        'title': 'Profiles you follow',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 94,
        leading: TextButton.icon(
          icon: const FaIcon(Icons.arrow_back_ios),
          label: const Text('Back'),
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
          ),
        ),
        title: const Text('Privacy'),
      ),
      body: ListView(
        children: [
          const Divider(),
          SwitchListTile.adaptive(
            value: _isPrivate,
            onChanged: (value) {
              setState(() {
                _isPrivate = value;
              });
            },
            secondary: const FaIcon(FontAwesomeIcons.lock),
            title: const Text('Private Account'),
          ),
          // 옵션 항목들을 ListTile로 표시
          ...privacyOptions.map((option) {
            return ListTile(
              leading: FaIcon(option['icon'] as IconData),
              title: Text(option['title'] as String),
              trailing: option.containsKey('trailing')
                  ? option['trailing'] as Widget
                  : const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: Sizes.size20,
                      color: Colors.grey,
                    ),
            );
          }),
          const Divider(),
          const ListTile(
            title: Text('Other privacy settings'),
            subtitle: Text(
              "Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.",
            ),
            trailing: FaIcon(FontAwesomeIcons.arrowUpRightFromSquare),
          ),
          const ListTile(
            leading: FaIcon(FontAwesomeIcons.ban),
            title: Text('Blocked Accounts'),
            trailing: FaIcon(FontAwesomeIcons.arrowUpRightFromSquare),
          ),
          const ListTile(
            leading: FaIcon(FontAwesomeIcons.heartCrack),
            title: Text('Hide likes'),
            trailing: FaIcon(FontAwesomeIcons.arrowUpRightFromSquare),
          ),
        ],
      ),
    );
  }
}
