import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'objects/obj.dart';
import 'config.dart';


class BrickBreaker extends FlameGame with HasCollisionDetection {
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
      radius: ballRadius,
      position: size / 2,
      velocity: Vector2((rand.nextDouble() -0.5)*width,height * 0.2) // Random velocity
        .normalized()
        ..scale(height/4)));

    debugMode = true;
  }

}