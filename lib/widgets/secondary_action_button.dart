import 'package:flutter/cupertino.dart';

import '../resources/fight_club_colors.dart';

class SecondaryActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const SecondaryActionButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: FightClubColors.darkGreyText, width: 2),
        ),
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: FightClubColors.darkGreyText,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
