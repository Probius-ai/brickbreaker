import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'objects/obj.dart';
import 'config.dart';

enum PlayState { welcome, playing, gameOver, gameWon } // play states

class BrickBreaker extends FlameGame 
  with HasCollisionDetection, KeyboardEvents, TapDetector {
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

  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState){
    _playState = playState;
    switch (playState){
      case PlayState.welcome:
        break;
      case PlayState.playing:
        break;
      case PlayState.gameOver:
        break;
      case PlayState.gameWon:
        overlays.add(playState.name);
        break;
    }
  }

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
    await world.addAll([
      for (var i = 0; i < brickColors.length; i++)
        for (var j = 0; j < 5; j++)
          Brick(
            position: Vector2(
              (i+0.5 ) * brickWidth + (i+1) * brickGutter,
              (j+2.0 ) * brickHeight + j*brickGutter,
            ),
            color: brickColors[i],
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