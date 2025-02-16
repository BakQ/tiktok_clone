import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone/clone_assignment/constants/sizes.dart';

class NavTap extends StatelessWidget {
  const NavTap({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.onTap,
  });

  final bool isSelected;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).bottomAppBarTheme.color ??
        (isDark ? Colors.grey.shade900 : Colors.white);
    final selectedIconColor = isDark ? Colors.white : Colors.black;
    final unselectedIconColor = isDark ? Colors.grey.shade700 : Colors.grey;

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: backgroundColor,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isSelected ? 1 : 0.6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  icon,
                  color: isSelected ? selectedIconColor : unselectedIconColor,
                  size: Sizes.size28,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
