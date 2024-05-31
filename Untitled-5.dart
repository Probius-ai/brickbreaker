dependencies:
  flutter:
    sdk: flutter
  flame: ^1.0.0
flutter pub get
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: BrickBreakerGame()));
}

class BrickBreakerGame extends FlameGame with HasDraggableComponents, HasCollisionDetection {
  late Ball _ball;
  late Paddle _paddle;
  final List<Brick> _bricks = [];

  @override
  Future<void> onLoad() async {
    _ball = Ball();
    _paddle = Paddle();
    add(_ball);
    add(_paddle);

    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 3; j++) {
        Brick brick = Brick(Vector2(60 + i * 60, 100 + j * 30));
        _bricks.add(brick);
        add(brick);
      }
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void onDragUpdate(int pointerId, DragUpdateInfo event) {
    super.onDragUpdate(pointerId, event);
    _paddle.position.x += event.delta.global.x;
  }
}

class Ball extends PositionComponent with HasGameRef, Hitbox, Collidable {
  Vector2 velocity = Vector2(200, 200);

  Ball() : super(size: Vector2.all(20));

  @override
  Future<void> onLoad() async {
    addHitbox(HitboxRectangle());
  }

  @override
  void update(double dt) {
    position += velocity * dt;

    // 화면 경계에 충돌 처리
    if (position.x <= 0 || position.x + size.x >= gameRef.size.x) {
      velocity.x = -velocity.x;
    }
    if (position.y <= 0 || position.y + size.y >= gameRef.size.y) {
      velocity.y = -velocity.y;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Paddle || other is Brick) {
      velocity.y = -velocity.y;
      if (other is Brick) {
        other.removeFromParent();
      }
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.white;
    canvas.drawRect(toRect(), paint);
  }
}

class Paddle extends PositionComponent with HasGameRef, Hitbox, Collidable {
  Paddle() : super(size: Vector2(100, 20));

  @override
  Future<void> onLoad() async {
    addHitbox(HitboxRectangle());
    position = Vector2((gameRef.size.x - size.x) / 2, gameRef.size.y - size.y - 10);
  }

  @override
  void update(double dt) {
    // 패들 이동 로직 추가
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.blue;
    canvas.drawRect(toRect(), paint);
  }
}

class Brick extends PositionComponent with HasGameRef, Hitbox, Collidable {
  Brick(Vector2 position) : super(position: position, size: Vector2(50, 20));

  @override
  Future<void> onLoad() async {
    addHitbox(HitboxRectangle());
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.red;
    canvas.drawRect(toRect(), paint);
  }
}
