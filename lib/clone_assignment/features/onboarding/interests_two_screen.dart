import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/clone_assignment/constants/gaps.dart';
import 'package:tiktok_clone/clone_assignment/constants/sizes.dart';
import 'package:tiktok_clone/clone_assignment/features/onboarding/widgets/interest_detail_button.dart';

class InterestsTwoScreen extends StatefulWidget {
  final List<String> selectedInterests;

  const InterestsTwoScreen({
    super.key,
    required this.selectedInterests,
  });

  @override
  State<InterestsTwoScreen> createState() => _InterestsTwoScreenState();
}

class _InterestsTwoScreenState extends State<InterestsTwoScreen> {
  final List<String> selectedDetailInterests = [];

  void toggleInterest(String interest) {
    setState(() {
      if (selectedDetailInterests.contains(interest)) {
        selectedDetailInterests.remove(interest);
      } else {
        selectedDetailInterests.add(interest);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    print(widget.selectedInterests);
  }

  @override
  Widget build(BuildContext context) {
    const Map<String, List<String>> interestsDetailMap = {
      "Daily Life": [
        "Morning Routines",
        "Night Routines",
        "Productivity Tips",
        "Life Hacks",
        "Self-Care Practices",
        "Weekend Rituals",
        "Fitness Routines",
        "Minimalist Living",
        "Time-Management Skills",
        "Stress-Relief Techniques",
        "Personal Growth Activities"
      ],
      "Comedy": [
        "Stand-up Comedy",
        "Sketches",
        "Memes",
        "Funny Clips",
        "Parody Videos",
        "Improvised Comedy",
        "Comedy Podcasts",
        "Dark Humor",
        "Satirical News",
        "Slapstick Comedy",
        "Roast Sessions",
        "Wholesome Humor"
      ],
      "Entertainment": [
        "Movies",
        "TV Shows",
        "Celebrities",
        "Streaming Platforms",
        "Music Videos",
        "Award Shows",
        "Behind-the-Scenes Content",
        "Reality TV",
        "Animated Features",
        "Documentaries",
        "Classic Films",
        "Independent Cinema"
      ],
      "Animals": [
        "Dogs",
        "Cats",
        "Wildlife",
        "Exotic Pets",
        "Animal Rescue Stories",
        "Pet Training Tips",
        "Funny Animal Videos",
        "Rare Species",
        "Marine Life",
        "Bird Watching",
        "Insects and Bugs",
        "Farm Animals"
      ],
      "Food": [
        "Recipes",
        "Street Food",
        "Baking",
        "Healthy Eating",
        "International Cuisine",
        "Vegan and Vegetarian Options",
        "Comfort Food",
        "Gourmet Dishes",
        "Food Challenges",
        "Meal Prepping",
        "Budget-Friendly Meals",
        "Fermented Foods"
      ]
    };

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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.size28,
              vertical: Sizes.size20,
            ),
            child: Column(
              children: [
                Text(
                  "What do you want to see on Twitter?",
                  style: TextStyle(
                    fontSize: Sizes.size28 + Sizes.size2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Text(
                  "Interests are used to personalize your experience and will be visible on your profile.",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: 0.5, height: 0.3),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var selectedInterest in widget.selectedInterests) ...[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: Sizes.size20,
                        left: Sizes.size16,
                        bottom: Sizes.size20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedInterest,
                            style: const TextStyle(
                              fontSize: Sizes.size20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gaps.v10,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 2,
                              child: Wrap(
                                spacing: 10,
                                direction: Axis.horizontal,
                                runSpacing: 15,
                                children: interestsDetailMap[selectedInterest]!
                                    .map(
                                      (detail) => GestureDetector(
                                        onTap: () => toggleInterest(detail),
                                        child: InterestDetailButton(
                                          interest: detail,
                                          isSelected: selectedDetailInterests
                                              .contains(detail),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(thickness: 0.5, height: 0.3),
                  ],
                ],
              ),
            ),
          ),
          const Divider(thickness: 0.5, height: 0.3),
          BottomAppBar(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedDetailInterests.length >= 3
                          ? Colors.blue
                          : Colors.grey.shade500,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
