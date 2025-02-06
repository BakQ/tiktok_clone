import 'package:flutter/material.dart';

import 'package:tiktok_clone/clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone/clone_assignment/features/main_navigation/widgets/drag_handle.dart';
import 'package:tiktok_clone/clone_assignment/features/main_navigation/widgets/report_bottom_sheet.dart';
import 'package:tiktok_clone/constants/gaps.dart';

class OptionsBottomSheet extends StatelessWidget {
  const OptionsBottomSheet({super.key});

  void _onReportTap(BuildContext context) {
    Navigator.pop(context); // 현재 BottomSheet 닫기
    showModalBottomSheet(
      context: context,
      builder: (context) => const ReportBottomSheet(),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.73,
      ),
      isScrollControlled: true,
    );
  }

  /// 동일한 스타일의 컨테이너 섹션을 만들어주는 헬퍼 메서드
  Widget _buildSection({required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade300,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //const DragHandle(),
        _buildSection(
          children: const [
            ListTile(
              title: Text(
                'Unfollow',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            ListTile(
              title: Text(
                'Mute',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        _buildSection(
          children: [
            const ListTile(
              title: Text(
                'Hide',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () => _onReportTap(context),
              title: const Text(
                'Report',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Gaps.v20,
      ],
    );
  }
}
