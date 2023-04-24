import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_app/game/overlays/main_menu.dart';
import 'package:game_app/game/overlays/name_enter.dart';

import 'game/game.dart';

void main() {
  runApp(const MyApp());
}

final _game = SimplePlatformer();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        body: GameWidget<SimplePlatformer>(
          game: kDebugMode? SimplePlatformer() : _game,
          overlayBuilderMap: {
            MainMenuScreen.id:(context, game) => MainMenuScreen(gameRef: game),
            NameScreen.id:(context, game) => NameScreen(gameRef: game)
          },
          initialActiveOverlays: const [MainMenuScreen.id],
   
        ),
      ),
    );
  }
}


