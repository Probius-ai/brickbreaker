import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../brickbreakergame.dart';

class GameArea extends RectangleComponent with HasGameReference<BrickBreaker> {
  GameArea() 
    :super(
      paint: Paint()..color = const Color(0xFFFFFFFF),
    );

  @override
  FutureOr<void> onLoad() async{
    super.onLoad();
    size = Vector2(game.width, game.height);
  }
  
}