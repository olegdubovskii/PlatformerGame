import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:game_app/game/actors/player.dart';
import 'package:game_app/game/game.dart';

class Spike extends SpriteComponent with CollisionCallbacks, HasGameRef<SimplePlatformer> {
  
  Spike(
    Image image, {
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super.fromImage(
          image,
          srcPosition: Vector2.zero(),
          srcSize: Vector2(41, 9),
          position: position,
          size: size,
          scale: scale,
          angle: angle,
          anchor: anchor,
          priority: priority,
        );
  
  @override
  Future<void>? onLoad() {
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      other.hit();
      if (gameRef.playerData.health.value > 0) { 
          gameRef.playerData.health.value -= 1;
      }
      other.jump();
    }
    super.onCollisionStart(intersectionPoints, other);
  }
}

