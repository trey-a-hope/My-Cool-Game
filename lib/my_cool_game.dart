import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:my_cool_game/globals.dart';
import 'package:my_cool_game/npcs/alchemist.dart';
import 'package:my_cool_game/npcs/blacksmith.dart';
import 'package:my_cool_game/player/dwarf_warrior.dart';

class MyCoolGame extends StatefulWidget {
  const MyCoolGame({super.key});

  @override
  State<MyCoolGame> createState() => _MyCoolGameState();
}

class _MyCoolGameState extends State<MyCoolGame> {
  final _cameraConfig = CameraConfig(
    initialMapZoomFit: InitialMapZoomFitEnum.fitHeight,
    moveOnlyMapArea: true,
    startFollowPlayer: true,
  );

  final _keyboard = Keyboard(
    config: KeyboardConfig(
      enable: true,
    ),
  );

  @override
  Widget build(BuildContext context) => BonfireWidget(
        // debugMode: true,
        // showCollisionArea: true,
        onReady: (value) {
          debugPrint('"My Cool Game" is now ready.👍');
        },
        playerControllers: [_keyboard],
        cameraConfig: _cameraConfig,
        player: DwarfWarrior(
          position: Vector2.all(20),
        ),
        map: WorldMapBySpritefusion(
          WorldMapReader.fromAsset(Globals.map),
          objectsBuilder: {
            'Alchemist': (properties) => Alchemist(
                  position: properties,
                ),
            'Black Smith': (properties) => Blacksmith(
                  position: properties,
                ),
          },
        ),
      );
}
