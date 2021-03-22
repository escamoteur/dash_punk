import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';

import '../../theme/colors.dart';
import 'logic.dart';
import 'widgets/stat_counter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stats = GetIt.I<Model>().statCommands;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Gap(16),
              const Header(),
              const Gap(32),
              RemainingPoints(),
              const Gap(16),
              StatCounter(
                label: 'Strength',
                command: stats[Stat.strength.index],
              ),
              StatCounter(
                label: 'Agility',
                command: stats[Stat.agility.index],
              ),
              StatCounter(
                label: 'Wisdom',
                command: stats[Stat.wisdom.index],
              ),
              StatCounter(
                label: 'Charisma',
                command: stats[Stat.charisma.index],
              ),
              LevelUpButton(),
            ],
          ),
        ),
      ),
    );
  }
}

@visibleForTesting
class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Flexible(
          child: Dashatar(),
        ),
        const Gap(8),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashatarName(),
              Level(),
            ],
          ),
        )
      ],
    );
  }
}

@visibleForTesting
class Dashatar extends StatelessWidget {
  const Dashatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(20);
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            border: Border.all(
              color: FlutterColors.secondary,
              width: 4,
            ),
          ),
          position: DecorationPosition.foreground,
          child: Image.asset(
            'assets/dashatar.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

@visibleForTesting
class DashatarName extends StatelessWidget with GetItMixin {
  DashatarName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = watchOnly((Model x) => x.name);
    final textTheme = Theme.of(context).textTheme;
    return Text(
      name,
      style: textTheme.headline3!.copyWith(color: FlutterColors.blue),
    );
  }
}

@visibleForTesting
class Level extends StatelessWidget with GetItMixin {
  Level({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final level = watchX((Model x) => x.levelUpCommand);

    return Text(
      'Level $level',
      style: textTheme.headline6,
    );
  }
}

@visibleForTesting
class RemainingPoints extends StatelessWidget with GetItMixin {
  RemainingPoints({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remaining = watchOnly((Model x) => x.remaining);
    final textTheme = Theme.of(context).textTheme;
    return Text(
      '$remaining points remaining',
      style: textTheme.headline5,
    );
  }
}

@visibleForTesting
class LevelUpButton extends StatelessWidget with GetItMixin {
  LevelUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool enabled = watchX((Model x) => x.levelUpCommand.canExecute);

    return OutlinedButton(
      // that we have use `execute` and can't just use the plain command is
      // currently an ulgy limitition of Dart
      // https://github.com/dart-lang/language/issues/1333#issuecomment-780476573
      onPressed: enabled ? get<Model>().levelUpCommand.execute : null,
      child: const Text('Level up'),
    );
  }
}
