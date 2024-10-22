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
        LogicalKeyboardKey.keyF,
      ],
      directionalKeys: [
        KeyboardDirectionalKeys.arrows(),
      ],
    ),
  );

  void _onReady(BonfireGameInterface i) =>
      debugPrint('"My Cool Game" is now ready. 👍🏾');

  @override
  Widget build(BuildContext context) => Scaffold(
        body: BonfireWidget(
          playerControllers: [
            _keyboard,
            Joystick(
              directional: JoystickDirectional(
                // TODO: Get icons for these buttons...
                color: Colors.black, size: 100,
                margin: const EdgeInsets.only(bottom: 64, left: 64),
              ),
              actions: [
                // TODO: Get icons for these buttons...
                JoystickAction(
                  actionId: JoystickActions.blue,
                  enableDirection: false,
                  color: Colors.blue,
                  size: 50,
                  margin: const EdgeInsets.only(bottom: 64, right: 64),
                ),
                JoystickAction(
                  actionId: JoystickActions.green,
                  enableDirection: false,
                  color: Colors.green,
                  size: 50,
                  margin: const EdgeInsets.only(bottom: 64, right: 64 * 2),
                ),
                JoystickAction(
                  actionId: JoystickActions.red,
                  enableDirection: false,
                  color: Colors.red,
                  size: 50,
                  margin: const EdgeInsets.only(bottom: 64, right: 64 * 3),
                )
              ],
            ),
          ],
          cameraConfig: _cameraConfig,
          player: DwarfWarrior(
            position: Vector2.all(20),
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
