import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame/game.dart';

import 'objects/obj.dart';
import 'config.dart';


class BrickBreaker extends FlameGame{
  // Add your class members and methods here
  BrickBreaker()
    : super(
      camera: CameraComponent.withFixedResolution(
        width: gameWidth, 
        height: gameHeight,
        ),
    );
  
  double get width => size.x;
  double get height => size.y;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    camera.viewfinder.anchor = Anchor.topLeft;

    world.add(GameArea());

    world.add(Ball()
      ..position = Vector2(width / 2, height / 2)
      ..angle = math.pi / 4
    );

    debugMode = true;
  }

}