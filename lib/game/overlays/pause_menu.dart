import 'package:flutter/material.dart';
import 'package:game_app/game/game.dart';
import 'package:game_app/game/overlays/main_menu.dart';
import 'package:game_app/game/overlays/name_enter.dart';

class PauseMenuScreen extends StatelessWidget {
  
  static const id = 'PauseMenu';
  final SimplePlatformer gameRef;

  const PauseMenuScreen({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove(id);
                  gameRef.resumeEngine();
                }, 
                child: const Text(
                  'Resume',
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(30)),
            SizedBox(
              width: 200,
              height: 100,
              child: ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove(id);
                  gameRef.resumeEngine();
                  gameRef.overlays.add(MainMenuScreen.id);
                }, 
                child: const Text(
                  'Main menu',
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}