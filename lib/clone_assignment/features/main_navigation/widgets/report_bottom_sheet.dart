import 'package:flutter/material.dart';
import 'package:tiktok_clone/clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone/clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone/clone_assignment/features/main_navigation/widgets/drag_handle.dart';

class ReportBottomSheet extends StatelessWidget {
  const ReportBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const DragHandle(),
          Gaps.v12,
          const Text(
            'Report',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Sizes.size20,
            ),
          ),
          const Divider(),
          Gaps.v12,
          const ListTile(
            title: Text(
              "Why are you reporting this thread?",
            ),
            subtitle: Text(
              "Your report is anonymous, expect if you're reporting an intellectual property infringement, if someone is in immediate danger, call the local emergency services - dont't wait.",
            ),
          ),
          const Divider(),
          ...[
            "I Just don't like it",
            "It's unlawful content under NetzDG",
            "It's spam",
            "Hate speech or symbols",
            "Nudity or sexual activity",
            "Encouraging harmful behavior",
            "Plagiarism or copyright violation",
          ].map(
            (title) => Column(
              children: [
                ListTile(
                  title: Text(title),
                  trailing: const Icon(Icons.chevron_right),
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
