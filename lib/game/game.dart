import 'package:flame/flame.dart';
import 'package:flame/game.dart';

import 'package:flame/image_composition.dart';
import 'package:flame/input.dart';
import 'package:game_app/game/game_play.dart';
import 'package:game_app/game/model/player_data.dart';
import './touch_controlls.dart';

class SimplePlatformer extends FlameGame 
  with HasTappables, HasCollisionDetection, HasKeyboardHandlerComponents {
  late Image playerSheet;
  late Image toolsSheet;
  late Image arrows;
  late Image enemy1Sheet;
  late Image heartSheet;
  late Image spikeSheet;
  late TouchControls touchControls;


  final playerData = PlayerData();

  @override
  Future<void>? onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    playerSheet = await images.load('Larry_No_Background.png');
    toolsSheet = await images.load('Full.png');
    arrows = await images.load('arrows.png');
    enemy1Sheet = await images.load('AnimationSheet_Character.png');
    heartSheet = await images.load('Pixel Heart Sprite Sheet 32x32.png');
    spikeSheet = await images.load('4 Conjoined Spikes.png');

    camera.viewport = FixedResolutionViewport(Vector2(768, 512));

    return super.onLoad();
  }
}