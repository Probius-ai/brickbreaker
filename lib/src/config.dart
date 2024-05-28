import 'package:flutter/material.dart';

const brickColors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.purple,
];

const gameWidth = 800.0;
const gameHeight = 1600.0;
const ballRadius = gameWidth *0.02;
const batWidth = gameWidth * 0.2;
const batHeight = ballRadius * 2;
const batStep = gameWidth * 0.05;
const brickGutter = gameWidth * 0.015;
final brickWidth = 
  (gameWidth - (brickGutter * (brickColors.length + 1))) / brickColors.length;

const brickHeight = gameHeight * 0.03;
const difficultyModifier = 1.05;