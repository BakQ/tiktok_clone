import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/clone_assignment/features/users/models/setting_config_model.dart';
import 'package:tiktok_clone/clone_assignment/features/users/view_models/setting_config_vm.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart'; // isDarkMode 함수가 정의되어 있다고 가정

class PrivacyScreen extends ConsumerStatefulWidget {
  static const String routeURL = '/private';
  static const String routeName = 'private';
  const PrivacyScreen({super.key});

  @override
  ConsumerState<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends ConsumerState<PrivacyScreen> {
  bool _isPrivate = false;

  @override
  Widget build(BuildContext context) {
    // ref.watch를 사용하여 provider를 구독합니다.
    final bool dark = ref.watch(settingConfigProvider).darkMode;
    final Color textColor = dark ? Colors.white : Colors.black;
    final Color bgColor = dark ? Colors.black : Colors.white;
    final Color dividerColor =
        dark ? Colors.grey.shade700 : Colors.grey.shade300;

    // 옵션 항목들을 Map 형태로 정의 (trailing 위젯을 동적으로 생성)
    final List<Map<String, dynamic>> privacyOptions = [
      {
        'icon': FontAwesomeIcons.at,
        'title': 'Mentions',
        'trailing': Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Everyone",
              style: TextStyle(fontSize: Sizes.size14, color: textColor),
            ),
            const SizedBox(width: 4),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size20,
              color: dark ? Colors.grey.shade400 : Colors.grey,
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
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        leadingWidth: 94,
        leading: TextButton.icon(
          icon: FaIcon(Icons.arrow_back_ios, color: textColor),
          label: Text('Back', style: TextStyle(color: textColor)),
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: textColor,
          ),
        ),
        title: Text('Privacy', style: TextStyle(color: textColor)),
        elevation: 0,
      ),
      body: ListTileTheme(
        textColor: textColor,
        iconColor: textColor,
        child: ListView(
          children: [
            Divider(color: dividerColor),
            SwitchListTile.adaptive(
              value: _isPrivate,
              onChanged: (value) {
                setState(() {
                  _isPrivate = value;
                });
              },
              secondary: FaIcon(FontAwesomeIcons.lock, color: textColor),
              title:
                  Text('Private Account', style: TextStyle(color: textColor)),
            ),
            SwitchListTile.adaptive(
              value: dark,
              onChanged: (value) {
                // provider의 notifier를 통해 darkMode를 변경합니다.
                ref.read(settingConfigProvider.notifier).setDarkMode(value);
              },
              secondary: FaIcon(FontAwesomeIcons.moon, color: textColor),
              title: Text('Dark Mode', style: TextStyle(color: textColor)),
            ),
            // 옵션 항목들을 ListTile로 표시
            ...privacyOptions.map((option) {
              return ListTile(
                leading: FaIcon(option['icon'] as IconData, color: textColor),
                title: Text(option['title'] as String,
                    style: TextStyle(color: textColor)),
                trailing: option.containsKey('trailing')
                    ? option['trailing'] as Widget
                    : FaIcon(
                        FontAwesomeIcons.chevronRight,
                        size: Sizes.size20,
                        color: dark ? Colors.grey.shade400 : Colors.grey,
                      ),
                onTap: () {},
              );
            }),
            Divider(color: dividerColor),
            ListTile(
              title: Text(
                'Other privacy settings',
                style: TextStyle(color: textColor),
              ),
              subtitle: Text(
                "Some settings, like restrict, apply to both Threads and Instagram and can be managed on Instagram.",
                style: TextStyle(color: textColor),
              ),
              trailing: FaIcon(FontAwesomeIcons.arrowUpRightFromSquare,
                  color: textColor),
              onTap: () {},
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.ban, color: textColor),
              title:
                  Text('Blocked Accounts', style: TextStyle(color: textColor)),
              trailing: FaIcon(FontAwesomeIcons.arrowUpRightFromSquare,
                  color: textColor),
              onTap: () {},
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.heartCrack, color: textColor),
              title: Text('Hide likes', style: TextStyle(color: textColor)),
              trailing: FaIcon(FontAwesomeIcons.arrowUpRightFromSquare,
                  color: textColor),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
