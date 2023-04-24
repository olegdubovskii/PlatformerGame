import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import './player.dart';

class Exit extends SpriteComponent with CollisionCallbacks {
  Function? onPlayerEnter;
  Exit(
    Image image, {
    this.onPlayerEnter,
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority}) : super.fromImage(
      image,
      srcPosition: Vector2(6*32, 4*32),
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
    add(RectangleHitbox()..collisionType = CollisionType.passive);
    return super.onLoad();
  }
  
  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player) {
      onPlayerEnter?.call();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

}