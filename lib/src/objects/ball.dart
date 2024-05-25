import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../brickbreakergame.dart';
import 'bat.dart';
import 'game_area.dart';

class Ball extends CircleComponent 
  with HasGameReference<BrickBreaker>, CollisionCallbacks{
  // Add your properties and methods here
  Ball({
    required this.velocity,
    required super.position,
    required double radius,
  }) :super(
    anchor: Anchor.center,
    radius: radius,
    paint: Paint()
    ..color = const Color(0xFFFFFFFF)
    ..style = PaintingStyle.fill,
    children: [CircleHitbox()],);


  final Vector2 velocity;
  
  @override
  void update(double dt) {
    // Add your update logic here
    super.update(dt);
    position += velocity * dt;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints, PositionComponent other) {
    // Add your collision logic here
    super.onCollisionStart(intersectionPoints, other);
    if(other is GameArea){
      if (intersectionPoints.first.y <= 0){
        velocity.y *= -1;
      } else if (intersectionPoints.first.x <= 0){
        velocity.x *= -1;
      } else if (intersectionPoints.first.x >= game.width){
        velocity.x *= -1;
      } else if (intersectionPoints.first.y >= game.height){
        add(RemoveEffect(
          delay: 0.35
        ));
      }
    } else if (other is Bat){
      velocity.y *= -1;
      velocity.x = velocity.x +
        (position.x - other.position.x) / other.size.x * game.width * 0.3;

    }else {
      debugPrint('Collision with $other');      
    }
  }
  
  @override
  void render(Canvas canvas) {
    // Add your rendering logic here
  }
}