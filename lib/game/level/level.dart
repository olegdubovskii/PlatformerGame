import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:game_app/game/game.dart';
import 'package:game_app/game/game_play.dart';
import 'package:tiled/tiled.dart';
import '../actors/player.dart';
import '../actors/barrel.dart';
import '../actors//chest.dart';
import '../actors/exit.dart';
import '../actors/paltform.dart';
import '../actors/enemy1.dart';
import '../actors/heart.dart';
import '../actors/spike.dart';
import '../actors/enemy2.dart';

class Level extends Component 
  with HasGameRef<SimplePlatformer>, ParentIsA<GameScreen> {
  final String levelName;
  

  Level(this.levelName) : super();

  @override
  Future<void>? onLoad() async {
    final level = await TiledComponent.load(
      levelName, Vector2.all(32));
    add(level);

    _spawnActors(level.tileMap);

    return super.onLoad();
  }

  void _spawnActors(RenderableTiledMap tileMap) {
    final platformsLayer = tileMap.getObjectGroupFromLayer('Platforms');

    for(final platformObj in platformsLayer.objects) {
      final platform = Platform(position: Vector2(platformObj.x, platformObj.y),
        size: Vector2(platformObj.width, platformObj.height),
      );
      add(platform); 
    }

    final spawnPointsLayer = tileMap.getObjectGroupFromLayer('SpawnPoints');
    
    for(final spawnPoint in spawnPointsLayer.objects) {
      final position = Vector2(spawnPoint
      .x, spawnPoint.y - spawnPoint.height);
      switch(spawnPoint.type) {
        case 'Player':
          final player = Player(
            gameRef.playerSheet,
            position: position,
            size: Vector2(spawnPoint.width, spawnPoint.height),
          );
          add(player);
          break;
        case 'Barrel':
          final barrel = Barrel(gameRef.toolsSheet,
            position: position,
            size: Vector2(spawnPoint.width, spawnPoint.height),
          );
          add(barrel);
          break;
        case 'Heart':
          final heart = Heart(gameRef.heartSheet,
            position: position,
            size: Vector2(spawnPoint.width, spawnPoint.height),
          );
          add(heart);
          break;
        case 'Chest':
          final chest = Chest(gameRef.toolsSheet,
            position: position,
            size: Vector2(spawnPoint.width, spawnPoint.height),
          );
          add(chest);
          break;
        case 'Exit':
          final exit = Exit(gameRef.toolsSheet,
            position: position,
            size: Vector2(spawnPoint.width, spawnPoint.height),
            onPlayerEnter: () {
              parent.loadLevel(spawnPoint.properties.first.value);
            },
          );
          add(exit);
          break;
        case 'Enemy1':
          final targetObjId = int.parse(spawnPoint.properties.first.value);
          final targetPoint = spawnPointsLayer.objects.firstWhere((element) => element.id == targetObjId);
          final enemy1 = Enemy1(gameRef.enemy1Sheet,
            position: position,
            targetPointPosition: Vector2(targetPoint.x, targetPoint.y),
            size: Vector2(spawnPoint.width, spawnPoint.height),
          );
          add(enemy1);
          break;
        case 'Spike':
          final spike = Spike(gameRef.spikeSheet,
            position: position,
            size: Vector2(spawnPoint.width, spawnPoint.height),
          );
          add(spike);
          break;
        case 'Enemy2':
          final targetObjId = int.parse(spawnPoint.properties.first.value);
          final targetPoint = spawnPointsLayer.objects.firstWhere((element) => element.id == targetObjId);
          final enemy2 = Enemy2(gameRef.enemy1Sheet,
            position: position,
            targetPointPosition: Vector2(targetPoint.x, targetPoint.y),
            size: Vector2(spawnPoint.width, spawnPoint.height),
          );
          add(enemy2);
          break;  
      }
    }
  }

}