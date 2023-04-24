import 'package:flame/components.dart';
import 'package:flutter/material.dart';
//import 'package:platformer/game/model/storage.dart';


import 'package:game_app/game/game.dart';
import 'package:game_app/game/game_play.dart';
import 'package:game_app/game/model/user.dart';
import 'package:game_app/game/overlays/main_menu.dart';

class NameScreen extends StatefulWidget{
  static const id = 'NameScreen';
  final SimplePlatformer gameRef;
  const NameScreen({super.key, required this.gameRef});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {

  final usernameController = TextEditingController();


  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body:  Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Username...',
                hintStyle: TextStyle(
                  color: Colors.amberAccent,
                )
              ),
              style: const TextStyle(
                color: Colors.amberAccent,
              ),
              controller: usernameController,
            ),
            const Padding(padding: EdgeInsets.all(30)),
            SizedBox(
              width: 200,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  if (name(usernameController.text)) {
                      widget.gameRef.overlays.remove(NameScreen.id);
                      widget.gameRef.add(GameScreen(username: usernameController.text));
                    }
                }, 
                child: const Text(
                  'Start',
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
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  widget.gameRef.overlays.remove(NameScreen.id);
                  widget.gameRef.overlays.add(MainMenuScreen.id);
                }, 
                child: const Text(
                  'Back',
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        )
      )
    );
  }

  bool name(String username) {
    if (username == '') {
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: createAlertDialog,
      );
      return false;
    }
    return true;
  }

  Widget createAlertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: const Text('Invalid username'),
      actions: [
        TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          }
        )
      ],
    );
  }
}