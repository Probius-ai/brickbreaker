import 'package:flutter/material.dart';

class StreakScreen extends StatelessWidget {
  const StreakScreen({
    super.key,
    required this.streak,
  });

  final ValueNotifier<int> streak;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: streak,
      builder: (context, streak, child) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(12,18,12,30),
          child: Text(
            'Streak: $streak'.toUpperCase(),
            style: Theme.of(context).textTheme.titleLarge!,
            ),
        );
      },
    );
  }
}