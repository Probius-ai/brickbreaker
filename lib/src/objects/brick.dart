import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../brickbreakergame.dart';
import '../config.dart';
import 'ball.dart';
import 'bat.dart';

class Brick extends RectangleComponent 
  with HasGameRef<BrickBreaker>, CollisionCallbacks{
  // Add your custom properties and methods here
  Brick({
    required super.position,
    required Color color,
  }) : super(
    size: Vector2(brickWidth, brickHeight),
    anchor: Anchor.center,
    paint: Paint()
      ..color = color
      ..style = PaintingStyle.fill,
    children: [RectangleHitbox()],
    
    );

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints, PositionComponent other) {
    // Implement the collision logic for the brick
    super.onCollisionStart(intersectionPoints, other);
    removeFromParent();
    if (game.streak.value == 0) { // when streak is 0 add 1 to score
      game.score.value += 1;
    } else {
      game.score.value += game.streak.value;
    }

    if(game.world.children.query<Brick>().length == 1){
      game.playState = PlayState.gameWon;
      game.world.removeAll(game.world.children.query<Ball>());
      game.world.removeAll(game.world.children.query<Bat>());
    }
  }
}