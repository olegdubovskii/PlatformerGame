import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/image_composition.dart';
import 'package:game_app/game/game.dart';
import 'package:game_app/game/actors/paltform.dart';
import 'package:flutter/src/services/raw_keyboard.dart';

class Player extends SpriteComponent 
  with CollisionCallbacks, KeyboardHandler, HasGameRef<SimplePlatformer> {
  
  final Vector2 _up = Vector2(0, -1);
  final Vector2 _velocity = Vector2.zero();
  int hAxisInput = 0;
  bool jumpInput = false;
  bool isOnGround = false;
  final double _moveSpeed = 200;
  final double _gravity = 15;
  final double _jumpHeight = 380;

  Player(
    Image image, {
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority}) : super.fromImage(
      image,
      srcPosition: Vector2(0, 1*32),
      srcSize: Vector2.all(32),
      position: position,
      size: size,
      scale: scale,
      angle: angle,
      anchor: anchor,
      priority: priority,
      );

  @override
  Future<void>? onLoad() {
    debugMode = true;
    add(CircleHitbox());
    return super.onLoad();
  }

  @override
  void onMount() {
    gameRef.touchControls.connectPlayer(this);
    super.onMount();
  }

  @override
  void update(double dt) {
    _velocity.x = hAxisInput * _moveSpeed;
    _velocity.y += _gravity;

    if (jumpInput) {
      if (isOnGround) {
        _velocity.y = -_jumpHeight;
        isOnGround = false;
      }
      jumpInput = false;
    }

    _velocity.y = _velocity.y.clamp(-_jumpHeight, 250);

    position += _velocity * dt;

    if (hAxisInput < 0 && scale.x > 0) {
      flipHorizontallyAroundCenter();
    } else if (hAxisInput > 0 && scale.x < 0) {
      flipHorizontallyAroundCenter();
    }
    super.update(dt);
  }

  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    hAxisInput= 0;

    hAxisInput += keysPressed.contains(LogicalKeyboardKey.keyA) ? -1 : 0;
    hAxisInput += keysPressed.contains(LogicalKeyboardKey.keyD) ? 1: 0;

    jumpInput = keysPressed.contains(LogicalKeyboardKey.space);
    return true;
  }
  
  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Platform) {
      if (intersectionPoints.length == 2) {
        final mid = (intersectionPoints.elementAt(0) +
                intersectionPoints.elementAt(1)) /
            2;
        final collisionNormal = absoluteCenter - mid;
        final separateDistance = (size.x / 2) - collisionNormal.length;

        collisionNormal.normalize();

        if (_up.dot(collisionNormal) > 0.9) {
          isOnGround = true;
        }

        position += collisionNormal.scaled(separateDistance);
      }
    }
    super.onCollision(intersectionPoints, other);
  }

  void hit() {
    add(OpacityEffect.fadeOut(
        EffectController(
          alternate: true,
          duration: 0.1,
          repeatCount: 3,
        ),
      ),
    );
  }

  void jump() {
    jumpInput = true;
    isOnGround = true;
  }

}