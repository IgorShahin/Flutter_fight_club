import 'package:flutter/material.dart';
import 'package:flutter_fight_club/resources/fight_club_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/secondary_action_button.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _StatisticsPageContent();
  }
}

class _StatisticsPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 24),
              alignment: Alignment.center,
              child: const Text(
                "Statistics",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  color: FightClubColors.darkGreyText,
                ),
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            FutureBuilder<SharedPreferences>(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const SizedBox();
                  }
                  final SharedPreferences sp = snapshot.data!;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Won: ${sp.getInt("stats_won") ?? 0}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: FightClubColors.darkGreyText,
                        ),
                      ),
                      Text(
                        "Lost: ${sp.getInt("stats_lost") ?? 0}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: FightClubColors.darkGreyText,
                        ),
                      ),
                      Text(
                        "Draw: ${sp.getInt("stats_draw") ?? 0}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: FightClubColors.darkGreyText,
                        ),
                      ),
                    ],
                  );
                  // Center(child: Text(snapshot.data!));
                }),
            const Expanded(child: SizedBox.shrink()),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SecondaryActionButton(
                text: "Back",
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
