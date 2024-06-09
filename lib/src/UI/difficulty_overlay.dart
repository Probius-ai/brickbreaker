import 'package:flutter/material.dart';
import '../brickbreakergame.dart';

class DifficultyOverlay extends StatelessWidget {
  final BrickBreaker game;

  const DifficultyOverlay({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0), // 패딩을 추가하여 전체 여백 설정
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Select Difficulty',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            const SizedBox(height: 20), // 간격 설정
            SizedBox(
              width: 200, // 버튼의 너비 설정
              child: ElevatedButton(
                onPressed: () {
                  game.startGame(difficulty: 1.0); // Easy
                },
                child: const Text('Easy'),
              ),
            ),
            const SizedBox(height: 20), // 간격 설정
            SizedBox(
              width: 200, // 버튼의 너비 설정
              child: ElevatedButton(
                onPressed: () {
                  game.startGame(difficulty: 1.5); // Medium
                },
                child: const Text('Medium'),
              ),
            ),
            const SizedBox(height: 20), // 간격 설정
            SizedBox(
              width: 200, // 버튼의 너비 설정
              child: ElevatedButton(
                onPressed: () {
                  game.startGame(difficulty: 2.0); // Hard
                },
                child: const Text('Hard'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

