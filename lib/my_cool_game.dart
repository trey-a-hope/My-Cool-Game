import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:my_cool_game/globals.dart';
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
        playerControllers: [_keyboard],
        cameraConfig: _cameraConfig,
        // playerControllers: [
        //   Joystick(
        //     directional: JoystickDirectional(
        //       color: Colors.green,
        //     ),
        //     actions: [
        //       JoystickAction(
        //         actionId: 1,
        //         margin: const EdgeInsets.all(50),
        //         color: Colors.green,
        //       ),
        //     ],
        //   ),
        //   Keyboard(
        //     config: KeyboardConfig(
        //       acceptedKeys: [
        //         LogicalKeyboardKey.space,
        //       ],
        //     ),
        //   ),
        // ],
        // player: GreenNinjaPlayer(
        //   position: Vector2(40, 40),
        //   spriteSheet: GreenNinjaSpriteSheet.spriteSheet,
        // ),
        player: DwarfWarrior(
          position: Vector2.all(20),
        ),
        map: WorldMapBySpritefusion(
          WorldMapReader.fromAsset(Globals.map),
        ),
      );
}
