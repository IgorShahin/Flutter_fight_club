import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BodyPart? defendingBodyPart;
  BodyPart? attackingBodyPart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD5DEF0),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(width: 16),
              Expanded(child: Center(
                child: Column(
                  children: const [
                    Text("You"),
                    SizedBox(height: 12),
                    Text("1"),
                    SizedBox(height: 4),
                    Text("1"),
                    SizedBox(height: 4),
                    Text("1"),
                    SizedBox(height: 4),
                    Text("1"),
                    SizedBox(height: 4),
                    Text("1"),
                  ],
                ),
              )),
              const SizedBox(width: 12),
              Expanded(child: Center(
                child: Column(
                  children: const [
                    Text("Enemy"),
                    SizedBox(height: 12),
                    Text("1"),
                    SizedBox(height: 4),
                    Text("1"),
                    SizedBox(height: 4),
                    Text("1"),
                    SizedBox(height: 4),
                    Text("1"),
                    SizedBox(height: 4),
                    Text("1"),
                  ],
                ),
              )),
              const SizedBox(width: 16)
            ],
          ),
          const Expanded(child: SizedBox()),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Text('Defend'.toUpperCase()),
                  const SizedBox(height: 13),
                  BodyPartButton(
                      bodyPart: BodyPart.head,
                      selected: defendingBodyPart == BodyPart.head,
                      bodyPartSetter: _selectedDefendingBodyPart),
                  const SizedBox(height: 14),
                  BodyPartButton(
                      bodyPart: BodyPart.torso,
                      selected: defendingBodyPart == BodyPart.torso,
                      bodyPartSetter: _selectedDefendingBodyPart),
                  const SizedBox(height: 14),
                  BodyPartButton(
                      bodyPart: BodyPart.legs,
                      selected: defendingBodyPart == BodyPart.legs,
                      bodyPartSetter: _selectedDefendingBodyPart),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                children: [
                  Text('Attack'.toUpperCase()),
                  const SizedBox(height: 13),
                  BodyPartButton(
                      bodyPart: BodyPart.head,
                      selected: attackingBodyPart == BodyPart.head,
                      bodyPartSetter: _selectedAttackingBodyPart),
                  const SizedBox(height: 14),
                  BodyPartButton(
                      bodyPart: BodyPart.torso,
                      selected: attackingBodyPart == BodyPart.torso,
                      bodyPartSetter: _selectedAttackingBodyPart),
                  const SizedBox(height: 14),
                  BodyPartButton(
                      bodyPart: BodyPart.legs,
                      selected: attackingBodyPart == BodyPart.legs,
                      bodyPartSetter: _selectedAttackingBodyPart),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ]),
          const SizedBox(height: 14),
          Row(children: [
            const SizedBox(width: 16),
            Expanded(
              child: GestureDetector(
                onTap: _getSelectedButtonGo,
                child: SizedBox(
                    height: 40,
                    child: ColoredBox(
                      color:
                      attackingBodyPart != null && defendingBodyPart != null
                          ? const Color.fromRGBO(0, 0, 0, 0.87)
                          : const Color.fromRGBO(0, 0, 0, 0.38),
                      child: Center(
                        child: Text(
                          "Go".toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    )),
              ),
            ),
            const SizedBox(width: 16)
          ]),
          const SizedBox(height: 40)
        ],
      ),
    );
  }

  void _getSelectedButtonGo() {
    if (attackingBodyPart != null && defendingBodyPart != null) {
      setState(() {
        attackingBodyPart = null;
        defendingBodyPart = null;
      });
    }
  }

  void _selectedDefendingBodyPart(final BodyPart value) {
    setState(() {
      defendingBodyPart = value;
    });
  }

  void _selectedAttackingBodyPart(final BodyPart value) {
    setState(() {
      attackingBodyPart = value;
    });
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
              ? const Color.fromRGBO(28, 121, 206, 1)
              : const Color.fromRGBO(0, 0, 0, 0.38),
          child: Center(
              child: Text(
                bodyPart.name.toUpperCase(),
                style: TextStyle(
                    color: selected ? Colors.white : const Color(0xFF060d14)),
              )),
        ),
      ),
    );
  }
}
