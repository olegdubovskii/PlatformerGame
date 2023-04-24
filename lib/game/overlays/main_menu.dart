import 'package:flutter/material.dart';
import 'package:game_app/game/game.dart';
import 'package:game_app/game/overlays/name_enter.dart';

class MainMenuScreen extends StatelessWidget {
  
  static const id = 'MainMenu';
  final SimplePlatformer gameRef;

  const MainMenuScreen({super.key, required this.gameRef});

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
                  gameRef.overlays.add(NameScreen.id);
                }, 
                child: const Text(
                  'Play',
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
                onPressed: () {}, 
                child: const Text(
                  'Records',
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