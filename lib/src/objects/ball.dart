import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../brickbreakergame.dart';
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
      }
      velocity.y *= -1;
    }
  }
  
  @override
  void render(Canvas canvas) {
    // Add your rendering logic here
  }
}