import 'package:flame/components.dart';
import 'package:game_app/game/game.dart';
import 'package:game_app/game/level/level.dart';
import 'package:game_app/game/hud/hud.dart';
import 'package:game_app/game/touch_controlls.dart';

class GameScreen extends Component with HasGameRef<SimplePlatformer> {


  GameScreen({required this.username});

  Level? _currentLevel;

  final hud = Hud(priority: 1);
  final String username;

  @override
  Future<void>? onLoad() {
    loadLevel('Level1.tmx');
    gameRef.add(hud);
    gameRef.touchControls = TouchControls(gameRef.arrows, position: Vector2.zero(), priority: 1);
    gameRef.add(gameRef.touchControls);
    gameRef.playerData.score.value = 0;
    gameRef.playerData.health.value = 3;
    gameRef.playerData.username = username;
    return super.onLoad();
  }

  @override
  void onRemove() {
    gameRef.remove(hud);
    super.onRemove();
  }

  void loadLevel(String levelName) {
    _currentLevel?.removeFromParent();
    _currentLevel = Level(levelName);
    add(_currentLevel!);
  }
}