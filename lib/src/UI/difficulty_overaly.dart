import 'package:flutter/material.dart';
import '../brickbreakergame.dart';

class DifficultyOverlay extends StatelessWidget {
  final BrickBreaker game;

  const DifficultyOverlay({required this.game, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Select Difficulty',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              game.startGame(difficulty: 1.0); // Easy
            },
            child: const Text('Easy'),
          ),
          ElevatedButton(
            onPressed: () {
              game.startGame(difficulty: 1.5); // Medium
            },
            child: const Text('Medium'),
          ),
          ElevatedButton(
            onPressed: () {
              game.startGame(difficulty: 2.0); // Hard
            },
            child: const Text('Hard'),
          ),
        ],
      ),
    );
  }
}
