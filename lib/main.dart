import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'src/brickbreakergame.dart';

void main() {
  final game = BrickBreaker();
  runApp(Gamewidget(game: game));
}
