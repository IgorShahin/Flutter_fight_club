import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fight_club/fight_club_colors.dart';
import 'package:flutter_fight_club/fight_club_icons.dart';
import 'package:flutter_fight_club/fight_club_images.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme:
            GoogleFonts.pressStart2pTextTheme(Theme.of(context).textTheme),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const int maxLives = 5;

  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  BodyPart whatEnemyAttack = BodyPart.random();
  BodyPart whatEnemyDefends = BodyPart.random();

  int yourLives = maxLives;
  int enemysLives = maxLives;

  String textTurnResults = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FightClubColors.background,
      body: SafeArea(
        child: Column(
          children: [
            FightersInfo(
              maxLivesCount: maxLives,
              yourLivesCount: yourLives,
              enemysLivesCount: enemysLives,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              child: ColoredBox(
                  color: FightClubColors.darkPurple,
                  child: SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Center(
                            child: Text(textTurnResults,
                                textAlign: TextAlign.center,
                                style:
                                    const TextStyle(height: 2, fontSize: 10))),
                      ))),
            )),
            ControlsWidget(
              defendingBodyPart: defendingBodyPart,
              selectedDefendingBodyPart: _selectedDefendingBodyPart,
              attackingBodyPart: attackingBodyPart,
              selectedAttackingBodyPart: _selectedAttackingBodyPart,
            ),
            const SizedBox(height: 14),
            GoButton(
                text: yourLives == 0 || enemysLives == 0
                    ? "Start new game"
                    : "Go",
                onTap: _getSelectedButtonGo,
                color: _getGoButtonColor()),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }

  Color _getGoButtonColor() {
    if (yourLives == 0 || enemysLives == 0) {
      return FightClubColors.blackButton;
    } else if (attackingBodyPart == null || defendingBodyPart == null) {
      return FightClubColors.greyButton;
    } else {
      return FightClubColors.blackButton;
    }
  }

  String _TurnResults() {
    if (yourLives == 0 && enemysLives == 0) {
      return "Draw";
    } else if (enemysLives == 0) {
      return "You won";
    } else if (yourLives == 0) {
      return "You lost";
    } else {
      return "";
    }
  }

  void _getSelectedButtonGo() {
    if (yourLives == 0 || enemysLives == 0) {
      setState(() {
        yourLives = maxLives;
        enemysLives = maxLives;
        textTurnResults = "";
      });
    } else if (attackingBodyPart != null && defendingBodyPart != null) {
      setState(() {
        final bool enemyLoseLive = attackingBodyPart != whatEnemyDefends;
        final bool youLoseLive = defendingBodyPart != whatEnemyAttack;

        if (enemyLoseLive) {
          enemysLives -= 1;
          textTurnResults =
              "You hit enemy’s ${attackingBodyPart!.name.toLowerCase()}.";
        } else {
          textTurnResults = "Your attack was blocked.";
        }
        if (youLoseLive) {
          yourLives -= 1;
          textTurnResults +=
              "\nEnemy hit your ${whatEnemyAttack.name.toLowerCase()}.";
        } else {
          textTurnResults += "\nEnemy’s attack was blocked.";
        }

        if (yourLives == 0 && enemysLives == 0) {
          textTurnResults = "Draw";
        } else if (enemysLives == 0) {
          textTurnResults = "You won";
        } else if (yourLives == 0) {
          textTurnResults = "You lost";
        }

        whatEnemyDefends = BodyPart.random();
        whatEnemyAttack = BodyPart.random();

        attackingBodyPart = null;
        defendingBodyPart = null;
      });
    }
  }

  void _selectedDefendingBodyPart(final BodyPart value) {
    if (yourLives == 0 || enemysLives == 0) {
      return;
    }
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectedAttackingBodyPart(final BodyPart value) {
    if (yourLives == 0 || enemysLives == 0) {
      return;
    }
    setState(() {
      attackingBodyPart = value;
    });
  }
}

class GoButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;

  const GoButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
            height: 40,
            child: ColoredBox(
              color: color,
              child: Center(
                child: Text(
                  text.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: FightClubColors.whiteText),
                ),
              ),
            )),
      ),
    );
  }
}

class ControlsWidget extends StatelessWidget {
  final BodyPart? defendingBodyPart;
  final ValueSetter<BodyPart> selectedDefendingBodyPart;

  final BodyPart? attackingBodyPart;
  final ValueSetter<BodyPart> selectedAttackingBodyPart;

  const ControlsWidget(
      {Key? key,
      required this.defendingBodyPart,
      required this.selectedDefendingBodyPart,
      required this.attackingBodyPart,
      required this.selectedAttackingBodyPart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const SizedBox(width: 16),
      Expanded(
        child: Column(
          children: [
            Text('Defend'.toUpperCase(),
                style: const TextStyle(color: FightClubColors.darkGreyText)),
            const SizedBox(height: 13),
            BodyPartButton(
                bodyPart: BodyPart.head,
                selected: defendingBodyPart == BodyPart.head,
                bodyPartSetter: selectedDefendingBodyPart),
            const SizedBox(height: 14),
            BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: defendingBodyPart == BodyPart.torso,
                bodyPartSetter: selectedDefendingBodyPart),
            const SizedBox(height: 14),
            BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: defendingBodyPart == BodyPart.legs,
                bodyPartSetter: selectedDefendingBodyPart),
          ],
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          children: [
            Text('Attack'.toUpperCase(),
                style: const TextStyle(color: FightClubColors.darkGreyText)),
            const SizedBox(height: 13),
            BodyPartButton(
                bodyPart: BodyPart.head,
                selected: attackingBodyPart == BodyPart.head,
                bodyPartSetter: selectedAttackingBodyPart),
            const SizedBox(height: 14),
            BodyPartButton(
                bodyPart: BodyPart.torso,
                selected: attackingBodyPart == BodyPart.torso,
                bodyPartSetter: selectedAttackingBodyPart),
            const SizedBox(height: 14),
            BodyPartButton(
                bodyPart: BodyPart.legs,
                selected: attackingBodyPart == BodyPart.legs,
                bodyPartSetter: selectedAttackingBodyPart),
          ],
        ),
      ),
      const SizedBox(width: 16),
    ]);
  }
}

class FightersInfo extends StatelessWidget {
  final int maxLivesCount;
  final int yourLivesCount;
  final int enemysLivesCount;

  const FightersInfo({
    Key? key,
    required this.maxLivesCount,
    required this.yourLivesCount,
    required this.enemysLivesCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Expanded(child: ColoredBox(color: Colors.white)),
              Expanded(child: ColoredBox(color: FightClubColors.darkPurple))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LivesWidget(
                  overallLivesCount: maxLivesCount,
                  currentLivesCount: yourLivesCount),
              Column(
                children: [
                  const SizedBox(height: 16),
                  const Text("You",
                      style: TextStyle(color: FightClubColors.darkGreyText)),
                  const SizedBox(height: 12),
                  Image.asset(FightClubImages.youAvatar, width: 92, height: 92)
                ],
              ),
              const ColoredBox(
                  color: Colors.green, child: SizedBox(height: 44, width: 44)),
              Column(
                children: [
                  const SizedBox(height: 16),
                  const Text("Enemy",
                      style: TextStyle(color: FightClubColors.darkGreyText)),
                  const SizedBox(height: 12),
                  Image.asset(FightClubImages.enemyAvatar,
                      width: 92, height: 92)
                ],
              ),
              LivesWidget(
                  overallLivesCount: maxLivesCount,
                  currentLivesCount: enemysLivesCount)
            ],
          ),
        ],
      ),
    );
  }
}

class LivesWidget extends StatelessWidget {
  final int overallLivesCount;
  final int currentLivesCount;

  const LivesWidget(
      {Key? key,
      required this.overallLivesCount,
      required this.currentLivesCount})
      : assert(overallLivesCount >= 1),
        assert(currentLivesCount >= 0),
        assert(currentLivesCount <= overallLivesCount),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(overallLivesCount, (index) {
        if (index < currentLivesCount) {
          return Padding(
            padding:
                EdgeInsets.only(bottom: index < overallLivesCount - 1 ? 4 : 0),
            child: Image.asset(FightClubIcons.heartFull, width: 18, height: 18),
          );
        } else {
          return Padding(
            padding:
                EdgeInsets.only(bottom: index < overallLivesCount - 1 ? 4 : 0),
            child:
                Image.asset(FightClubIcons.heartEmpty, width: 18, height: 18),
          );
        }
      }),
    );
  }
}

class BodyPart {
  final String name;

  const BodyPart._(this.name);

  static const head = BodyPart._("Head");
  static const torso = BodyPart._("Torso");
  static const legs = BodyPart._("Legs");

  @override
  String toString() {
    return 'BodyPart{name: $name}';
  }

  static const List<BodyPart> _values = [head, torso, legs];

  static BodyPart random() {
    return _values[Random().nextInt(_values.length)];
  }
}

class BodyPartButton extends StatelessWidget {
  final BodyPart bodyPart;
  final bool selected;
  final ValueSetter<BodyPart> bodyPartSetter;

  const BodyPartButton(
      {Key? key,
      required this.bodyPart,
      required this.selected,
      required this.bodyPartSetter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bodyPartSetter(bodyPart),
      child: SizedBox(
        height: 40,
        child: ColoredBox(
          color: selected
              ? FightClubColors.blueButton
              : FightClubColors.greyButton,
          child: Center(
              child: Text(
            bodyPart.name.toUpperCase(),
            style: TextStyle(
                color: selected
                    ? FightClubColors.whiteText
                    : FightClubColors.darkGreyText),
          )),
        ),
      ),
    );
  }
}
