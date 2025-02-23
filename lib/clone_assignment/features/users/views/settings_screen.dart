import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/clone_assignment/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/clone_assignment/features/users/view_models/setting_config_vm.dart';
import 'package:tiktok_clone/clone_assignment/features/users/views/privacy_screen.dart';
import 'package:tiktok_clone/clone_assignment/utils.dart';
import 'package:tiktok_clone/router.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  static const String routeURL = '/settings';
  static const String routeName = 'settings';
  const SettingsScreen({super.key});

  @override
  ConsumerState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _loggingOut = false;

  // 로그아웃 다이얼로그를 비동기 함수로 분리
  Future<void> _showLogoutDialog() async {
    setState(() {
      _loggingOut = true;
    });
    await showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Are you sure?"),
        content: const Text("Plx dont go"),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("No"),
          ),
          CupertinoDialogAction(
            onPressed: () async {
              // 다이얼로그를 닫은 후
              Navigator.of(context).pop();
              // 로그아웃 완료될 때까지 기다린 후
              await ref.read(authRepo).signOut();
              // 로그인 화면으로 이동
              context.go("/login");
            },
            isDestructiveAction: true,
            child: const Text("Yes"),
          ),
        ],
      ),
    );
    setState(() {
      _loggingOut = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = ref.read(settingConfigProvider).darkMode;
    // 다크 모드 여부에 따른 색상 설정
    final Color textColor = dark ? Colors.white : Colors.black;
    final Color bgColor = dark ? Colors.black : Colors.white;
    final Color dividerColor = Theme.of(context).dividerColor;

    // 옵션 데이터를 List<Map<String, dynamic>> 형태로 분리
    final List<Map<String, dynamic>> options = [
      {
        'icon': FontAwesomeIcons.userLarge,
        'title': 'Follow and invite friends',
      },
      {
        'icon': FontAwesomeIcons.bell,
        'title': 'Notifications',
      },
      {
        'icon': FontAwesomeIcons.lock,
        'title': 'Privacy',
        'onTap': () => context.goNamed(PrivacyScreen.routeName)
      },
      {
        'icon': FontAwesomeIcons.universalAccess,
        'title': 'Account',
      },
      {
        'icon': FontAwesomeIcons.circleQuestion,
        'title': 'Help',
      },
      {
        'icon': FontAwesomeIcons.addressCard,
        'title': 'About',
      },
    ];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leadingWidth: 94,
        leading: TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
          ),
          icon: Icon(
            Icons.arrow_back_ios,
            color: textColor,
          ),
          label: Text(
            'Back',
            style: TextStyle(color: textColor),
          ),
        ),
        title: Text(
          'Settings',
          style: TextStyle(color: textColor),
        ),
      ),
      body: ListView(
        children: [
          Divider(color: dividerColor),
          // 옵션 리스트 생성 (toList()로 변환)
          ...options.map(
            (option) => ListTile(
              leading: FaIcon(
                option['icon'] as IconData,
                color: textColor,
              ),
              title: Text(
                option['title'] as String,
                style: TextStyle(color: textColor),
              ),
              onTap: option['onTap'] as void Function()? ?? () {},
            ),
          ),
          Divider(color: dividerColor),
          ListTile(
            title: const Text(
              'Log out',
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
            onTap: _showLogoutDialog,
            trailing: _loggingOut
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator.adaptive(),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
