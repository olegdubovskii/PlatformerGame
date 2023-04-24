import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/image_composition.dart';
import 'package:game_app/game/actors/player.dart';
import 'package:game_app/game/game.dart';

class Enemy1 extends SpriteComponent with CollisionCallbacks, HasGameRef<SimplePlatformer> {
  Enemy1(
    Image image, {
    Vector2? position,
    Vector2? targetPointPosition,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority}) : super.fromImage(
      image,
      srcPosition: Vector2(1*32, 1*32),
      srcSize: Vector2.all(32),
      position: position,
      size: size,
      scale: scale,
      angle: angle,
      anchor: anchor,
      priority: priority,
      ) {
        if (targetPointPosition != null && position != null) {
          add(SequenceEffect(
            [
              MoveToEffect(targetPointPosition, EffectController(
                speed: 50,
              ))..onComplete = () => flipHorizontallyAroundCenter(),
              MoveToEffect(position + Vector2(32, 0), EffectController(
                speed: 50,
              ))..onComplete = () => flipHorizontallyAroundCenter(),
            ],
            infinite: true,
          ));
        }
      }

      @override
  Future<void>? onLoad() {
    add(CircleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {

      final playerDir = (other.absoluteCenter - absoluteCenter).normalized();

      if (playerDir.dot(Vector2(0, -1)) > 0.85) {
        add(OpacityEffect.fadeOut(LinearEffectController(0.2),)..onComplete = () {
          removeFromParent();
        });
        other.jump();
      } else {
        other.hit();
        if (gameRef.playerData.health.value > 0) { 
          gameRef.playerData.health.value -= 1;
        }
      }
    }
    super.onCollisionStart(intersectionPoints, other);
  }

}