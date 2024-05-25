import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Ball extends CircleComponent {
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
    ..style = PaintingStyle.fill);


  final Vector2 velocity;
  
  @override
  void update(double dt) {
    // Add your update logic here
    super.update(double dt);
    position += velocity * dt;
  }
  
  @override
  void render(Canvas canvas) {
    // Add your rendering logic here
  }
}