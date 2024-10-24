import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_cool_game/globals.dart';
import 'package:my_cool_game/npcs/alchemist.dart';
import 'package:my_cool_game/npcs/blacksmith.dart';
import 'package:my_cool_game/players/dwarf_warrior.dart';

class MyCoolGame extends StatefulWidget {
  const MyCoolGame({super.key});

  @override
  State<MyCoolGame> createState() => _MyCoolGameState();
}

class _MyCoolGameState extends State<MyCoolGame> {
  bool _devMode = false;

  Key _gameKey = GlobalKey();

  static const _buttonSize = 50.0;

  final _cameraConfig = CameraConfig(
    initialMapZoomFit: InitialMapZoomFitEnum.fitHeight,
    moveOnlyMapArea: true,
  );

  final _keyboard = Keyboard(
    config: KeyboardConfig(
      enable: true,
      acceptedKeys: [
        LogicalKeyboardKey.space,
        LogicalKeyboardKey.keyA,
        LogicalKeyboardKey.keyB,
        LogicalKeyboardKey.keyX,
        LogicalKeyboardKey.keyY,
      ],
      directionalKeys: [
        KeyboardDirectionalKeys.arrows(),
      ],
    ),
  );

  void _onReady(BonfireGameInterface i) {
    debugPrint('"My Cool Game" is now ready. 👍🏾');

    if (_devMode) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Dev Mode Activiated'),
          content: const Text(
            'Showing collision area and debug mode.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        key: _gameKey,
        body: BonfireWidget(
          debugMode: _devMode,
          showCollisionArea: _devMode,
          playerControllers: [
            _keyboard,
            Joystick(
              directional: JoystickDirectional(
                // TODO: Get icons for these buttons...
                color: Colors.white, size: 100,
                margin: const EdgeInsets.only(bottom: 64, left: 64),
              ),
              actions: [
                JoystickAction(
                  sprite: Sprite.load(
                    Globals.buttons.aUnpressed,
                  ),
                  spritePressed: Sprite.load(
                    Globals.buttons.aPressed,
                  ),
                  actionId: JoystickActions.buttonA,
                  enableDirection: false,
                  color: Colors.blue,
                  size: _buttonSize,
                  margin: const EdgeInsets.only(bottom: 64, right: 64),
                ),
              ],
            ),
          ],
          cameraConfig: _cameraConfig,
          player: DwarfWarrior(
            position: Vector2.all(20),
            toggleDevMode: () => setState(
              () {
                _gameKey = UniqueKey();
                _devMode = !_devMode;
              },
            ),
          ),
          onReady: _onReady,
          map: WorldMapBySpritefusion(
            WorldMapReader.fromAsset(Globals.map),
            objectsBuilder: {
              'Alchemist': (properties) => Alchemist(
                    position: properties,
                  ),
              'Blacksmith': (properties) => Blacksmith(
                    position: properties,
                  ),
            },
          ),
        ),
      );
}
