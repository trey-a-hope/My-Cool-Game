import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_cool_game/globals.dart';
import 'package:my_cool_game/sprite_animations.dart';
import 'package:my_cool_game/screen_boundary_checker.dart';

enum JoystickActions {
  red,
  blue,
  green,
}

class DwarfWarrior extends PlatformPlayer
    with HandleForces, ScreenBoundaryChecker, TapGesture, MouseEventListener {
  static const _size = Globals.tileSize * 1.5;
  static const _speed = 100.0;
  static const _jumpSpeed = 100.0;

  DwarfWarrior({required super.position})
      : super(
          size: Vector2.all(_size),
          countJumps: 2,
          speed: _speed,
          animation: PlatformAnimations(
            idleRight: SpriteAnimations.dwarfWarriorIdle,
            runRight: SpriteAnimations.dwarfWarriorWalk,
          ),
        ) {
    addForce(Globals.forces.gravity);
  }

  @override
  void update(double dt) {
    checkScreenBoundaries();
    super.update(dt);
  }

  @override
  void onJoystickAction(JoystickActionEvent event) {
    if (event.event == ActionEvent.DOWN &&
        (event.id == LogicalKeyboardKey.space || event.id == 1)) {
      jump();
    }

    if (event.event == ActionEvent.DOWN) {
      switch (event.id) {
        case 1:
          debugPrint('hurt');
          _onJoystickAction(JoystickActions.blue);
          break;
        case 2:
          debugPrint('die');
          _onJoystickAction(JoystickActions.green);
          break;
        case 3:
          debugPrint('attack');
          _onJoystickAction(JoystickActions.red);
          break;
      }
    }

    super.onJoystickAction(event);
  }

  @override
  Future<void> onLoad() {
    add(Globals.simpleHitBox(width: _size));
    return super.onLoad();
  }

  @override
  void onTap() => _showMapProgress();

  @override
  void onMouseTap(MouseButton button) => _showMapProgress();

  void _onJoystickAction(JoystickActions action) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(action.name),
        content: const Text(
          'Some text can go here...',
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

  void _showMapProgress() {
    final mapWidth = gameRef.map.getMapSize().x;
    final curPoint = position.x;
    final percentComplete = ((curPoint / mapWidth) * 100).round();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Our hero is $percentComplete% complete.')),
    );
  }
}
