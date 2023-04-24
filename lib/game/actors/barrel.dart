import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/image_composition.dart';
import 'package:flutter/animation.dart';
import 'package:game_app/game/actors/player.dart';
import 'package:game_app/game/game.dart';

class Barrel extends SpriteComponent with CollisionCallbacks, HasGameRef<SimplePlatformer>  {
  Barrel(
    Image image, {
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority}) : super.fromImage(
      image,
      srcPosition: Vector2(6*32, 0),
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
    add(CircleHitbox()..collisionType = CollisionType.passive);
    add(MoveEffect.by(Vector2(0, -7),
     EffectController(
      alternate: true,
      infinite: true,
      duration: 1,
      curve: Curves.ease,
     )));
    return super.onLoad();
  }


  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      add(OpacityEffect.fadeOut(LinearEffectController(0.1),)..onComplete = () {
        add(RemoveEffect());
      });
      gameRef.playerData.score.value += 1;
    }
    super.onCollisionStart(intersectionPoints, other);
  } 
  
}