import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../brickbreakergame.dart';
import 'bat.dart';
import 'brick.dart';
import 'game_area.dart';


class Ball extends CircleComponent 
  with HasGameReference<BrickBreaker>, CollisionCallbacks{
  // Add your properties and methods here
  Ball({
    required this.velocity,
    required super.position,
    required double radius,
    required this.difficultyModifier,
  }) :super(
    anchor: Anchor.center,
    radius: radius,
    paint: Paint()
    ..color = const Color.fromARGB(255, 255, 0, 0)
    ..style = PaintingStyle.fill,
    children: [CircleHitbox()],);
    

  final Vector2 velocity;
  final double difficultyModifier;
  
  @override
  void update(double dt) {
    // Add your update logic here
    super.update(dt);
    position += velocity * dt;
  }
  final _audioPlayer = AudioPlayer();

  // Function to play sound
  void _playBrickSound() async {
    await _audioPlayer.play(AssetSource('BallSound.mp3'));
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints, PositionComponent other) {
    // Add your collision logic here
    super.onCollisionStart(intersectionPoints, other);
    if(other is GameArea){// Check if the ball hits the game area
      if (intersectionPoints.first.y <= 0){
        velocity.y *= -1;
      } else if (intersectionPoints.first.x <= 0){
        velocity.x *= -1;
      } else if (intersectionPoints.first.x >= game.width){
        velocity.x *= -1;
      } else if (intersectionPoints.first.y >= game.height){
        add(RemoveEffect(
          delay: 0.35,
          onComplete: () {
            game.playState = PlayState.gameOver;
          },
        ));
      }
    } else if (other is Bat){// Check if the ball hits the bat
      velocity.y *= -1;
      velocity.x = velocity.x +
        (position.x - other.position.x) / other.size.x * game.width * 0.3;
      game.streak.value = 0; //reset streak

    }else if (other is Brick){// Check if the ball hits a brick
    _playBrickSound();
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
        game.streak.value += 1; // Increase the streak
    }
  }
}
