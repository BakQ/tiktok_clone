import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone/clone_assignment/constants/sizes.dart';

class NavTap extends StatelessWidget {
  const NavTap(
      {super.key,
      required this.isSelected,
      required this.icon,
      required this.onTap});

  final bool isSelected;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          color: Colors.white,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isSelected ? 1 : 0.6,
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // 강의때랑 다른거같다. 크기가 최대로 안잡힌다. 알아서 잡힌다.
              children: [
                FaIcon(
                  icon,
                  color: isSelected ? Colors.black : Colors.grey,
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
