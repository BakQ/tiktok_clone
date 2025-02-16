import 'package:flutter/material.dart';
import 'package:tiktok_clone/clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone/clone_assignment/utils.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;
  PersistentTabBar()
      : _tabBar = const TabBar(
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          tabs: [
            Tab(text: "Threads"),
            Tab(text: "Replies"),
          ],
        );

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool dark = isDarkMode(context);
    return Container(
      color: dark ? Colors.black : Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant PersistentTabBar oldDelegate) => false;
}
