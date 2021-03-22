// final nameRef = StateRef('Dash Punk');
// final levelRef = StateRef(1);
// final remainingRef = StateRef(8);
// final canLevelUpRef = Computed((watch) {
//   return watch(remainingRef) == 0;
// });

import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';

class Model extends ChangeNotifier {
  String name = 'Dash Punk';
  int remaining = 8;
  int level = 0;
  final statCommands = <Command<int, int>>[];
}

enum Stat {
  strength,
  agility,
  wisdom,
  charisma,
}
