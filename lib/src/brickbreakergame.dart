import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'objects/obj.dart';
import 'config.dart';


class BrickBreaker extends FlameGame 
  with HasCollisionDetection, KeyboardEvents {
  // Add your class members and methods here
  BrickBreaker()
    : super(
      camera: CameraComponent.withFixedResolution(
        width: gameWidth, 
        height: gameHeight,
        ),
    );

  final rand = math.Random();
  double get width => size.x;
  double get height => size.y;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(GameArea());

    // Add the ball to the game
    world.add(Ball(
      difficultyModifier: difficultyModifier,
      radius: ballRadius,
      position: size / 2,
      velocity: Vector2((rand.nextDouble() -0.5)*width,height * 0.2) // Random velocity
        .normalized()
        ..scale(height/4)));
        
    // Add the bat to the game
    world.add(Bat(
      cornerRadius: const Radius.circular(ballRadius / 2),
      position: Vector2(width / 2, height *0.95),
      size: Vector2(batWidth, batHeight),
    ));

    // Add the bricks to the game
    await world.add([
      for (var i = 0; i < brickRows; i++)
        for (var j = 0; j < brickColumns; j++)
          Brick(
            position: Vector2(
              j * (brickWidth + brickPadding) + brickMargin,
              i * (brickHeight + brickPadding) + brickMargin,
            ),
            color: Color((0xFFFFFF00 * rand.nextDouble()).toInt() << 0),
          ),
    ]);
    debugMode = true;
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    // Add your key event handling logic here
    super.onKeyEvent(event, keysPressed);
    switch (event.logicalKey){
      case LogicalKeyboardKey.arrowLeft:
        world.children.query<Bat>().first.moveBy(-batStep);
      case LogicalKeyboardKey.arrowRight:
        world.children.query<Bat>().first.moveBy(batStep);
    }

    return KeyEventResult.handled;
  }

}