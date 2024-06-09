import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../brickbreakergame.dart';
import 'bat.dart';
import 'brick.dart';
import 'game_area.dart';

class Ball extends CircleComponent 
  with HasGameReference<BrickBreaker>, CollisionCallbacks {
  final Vector2 velocity;
  final double difficultyModifier;

  Ball({
    required this.velocity,
    required super.position,
    required double radius,
    required this.difficultyModifier,
  }) : super(
    anchor: Anchor.center,
    radius: radius,
    paint: Paint()
      ..color = Color.fromARGB(255, 255, 0, 0)
      ..style = PaintingStyle.fill,
    children: [CircleHitbox()],
  );

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    
    if (other is GameArea) {
      if (intersectionPoints.first.y <= 0) {
        velocity.y *= -1;
      } else if (intersectionPoints.first.x <= 0) {
        velocity.x *= -1;
      } else if (intersectionPoints.first.x >= game.width) {
        velocity.x *= -1;
      } else if (intersectionPoints.first.y >= game.height) {
        add(RemoveEffect(
          delay: 0.35,
          onComplete: () {
            game.playState = PlayState.gameOver;
          },
        ));
      }
    } else if (other is Bat) {
      velocity.y *= -1;
      velocity.x = velocity.x +
        (position.x - other.position.x) / other.size.x * game.width * 0.3;

    }else if (other is Brick){// Check if the ball hits a brick
        if ( position.y < other.position.y - other.size.y / 2 ){
          velocity.y *= -1;
        } else if (position.y > other.position.y + other.size.y / 2){
          velocity.y *= -1;
        } else if (position.x < other.position.x){
          velocity.x *= -1;
        } else if (position.x > other.position.x){
          velocity.x *= -1;
        }
        velocity.setFrom(velocity * difficultyModifier);// Increase the speed of the ball with difficultyModifier

        // Create and add a new ball
      final newBall = Ball(
        velocity: Vector2(velocity.x, -velocity.y),
        position: Vector2(position.x, position.y),
        radius: radius,
        difficultyModifier: difficultyModifier,
      );
      game.world.add(newBall); // Ensure new ball is added to the world
    }
  }
}