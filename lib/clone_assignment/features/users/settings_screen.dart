import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/clone_assignment/features/users/privacy_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
            onPressed: () => Navigator.of(context).pop(),
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
    // 옵션 데이터를 List<Map<String, dynamic>> 형태로 분리
    final List<Map<String, dynamic>> options = [
      {
        'icon': FontAwesomeIcons.userLarge,
        'title': 'Follow and invite friends',
      },
      {
        'icon': FontAwesomeIcons.bell,
        'title': 'Notificatoins',
      },
      {
        'icon': FontAwesomeIcons.lock,
        'title': 'Privacy',
        'onTap': () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PrivacyScreen(),
              ),
            ),
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
      appBar: AppBar(
        leadingWidth: 94,
        leading: TextButton.icon(
          icon: const Icon(Icons.arrow_back_ios),
          label: const Text('Back'),
          onPressed: () => Navigator.of(context).pop(),
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
          ),
        ),
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const Divider(),
          // 옵션 리스트 생성 (toList()로 변환)
          ...options.map(
            (option) => ListTile(
              leading: FaIcon(option['icon'] as IconData),
              title: Text(option['title'] as String),
              onTap: option['onTap'] as void Function()? ?? () {},
            ),
          ),
          const Divider(),
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
