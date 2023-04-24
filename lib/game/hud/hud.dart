import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:game_app/game/game.dart';

class Hud extends Component with HasGameRef<SimplePlatformer> {

  List<SpriteComponent> sprites = [];
  late final TextComponent scoreIndicator;
  late final TextComponent healthIndicator;
  Hud({super.children, super.priority}) {
    positionType = PositionType.viewport;
  }

  @override
  Future<void>? onLoad() {
    scoreIndicator = TextComponent(
      text: 'Score: 0',
      position: Vector2(5, 3),
    );
    add(scoreIndicator);

    healthIndicator = TextComponent(
      text: 'Health: ',
      position: Vector2(130, 3),
    );
    add(healthIndicator);

    sprites.addAll(createSprites());
    addAll(sprites);

    gameRef.playerData.score.addListener(onScoreChange);
    gameRef.playerData.health.addListener(onHealthChange);

    // final pauseButton = SpriteButtonComponent(
    //   button: Sprite(gameRef.)
    // )
    return super.onLoad();
  }

  @override
  void onRemove() {
    gameRef.playerData.score.removeListener(onScoreChange);
    gameRef.playerData.score.removeListener(onHealthChange);
    super.onRemove();
  }

  void onScoreChange() {
    scoreIndicator.text = "Score: ${gameRef.playerData.score.value}";
  }

  void onHealthChange() {
    removeAll(sprites);
    sprites = createSprites();
    addAll(sprites);
  }

  List<SpriteComponent> createSprites() {
    List<SpriteComponent> sprites = [];
    for (double i = 0; i<gameRef.playerData.health.value; i++) {
        final healthSprite = SpriteComponent.fromImage(
          gameRef.heartSheet,
          srcPosition: Vector2.zero(),
          srcSize: Vector2.all(32),
          anchor: Anchor.topRight,
          position: Vector2(237+(i*18), -5)
        );
        sprites.add(healthSprite);
    }
    return sprites;
  }
}