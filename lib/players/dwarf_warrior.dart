import 'package:bonfire/bonfire.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_cool_game/globals.dart';
import 'package:my_cool_game/services/modal_service.dart';
import 'package:my_cool_game/sprite_animations.dart';
import 'package:my_cool_game/screen_boundary_checker.dart';
import 'package:toastification/toastification.dart';

enum JoystickActions {
  potion,
  bow,
  axe,
  jump,
}

class DwarfWarrior extends PlatformPlayer
    with HandleForces, ScreenBoundaryChecker, TapGesture, MouseEventListener {
  static const _size = Globals.tileSize * 1.5;
  static const _speed = 100.0;
  static const _jumpSpeed = 100.0;

  void Function() toggleDevMode;

  DwarfWarrior({
    required super.position,
    required this.toggleDevMode,
  }) : super(
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
  void onTapDownScreen(GestureEvent event) {
    togglePause();
    super.onTapDownScreen(event);
  }

  @override
  void update(double dt) {
    checkScreenBoundaries();
    super.update(dt);
  }

  @override
  void onJoystickAction(JoystickActionEvent event) {
    // Jump.
    if (event.event == ActionEvent.DOWN) {
      if (event.id == LogicalKeyboardKey.space ||
          event.id == JoystickActions.jump) {
        jump();
      }

      // Potion.
      if (event.id == LogicalKeyboardKey.keyF ||
          event.id == JoystickActions.potion) {
        // TODO: Take potion...
      }

      // Axe.
      if (event.id == LogicalKeyboardKey.keyA ||
          event.id == JoystickActions.axe) {
        // TODO: Short range attack.
      }

      // Bow.
      if (event.id == LogicalKeyboardKey.keyB ||
          event.id == JoystickActions.bow) {
        // TODO: Long range attack.
      }

      // Pause.
      if (event.id == LogicalKeyboardKey.keyP) {
        togglePause();
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
  void onTap() {
    // TODO: Should I do something here...
  }

  @override
  void onMouseTap(MouseButton button) => toggleDevMode();
  // TODO: Get dev mode switch working.

  void togglePause() {
    final isPaused = gameRef.paused;

    isPaused ? gameRef.resumeEngine() : gameRef.pauseEngine();

    ModalService().showToast(
      title: isPaused ? 'Game resumed!' : 'Game paused...',
      icon: isPaused ? const Icon(Icons.play_arrow) : const Icon(Icons.pause),
      type: isPaused ? ToastificationType.success : ToastificationType.warning,
    );
  }

  void _showMapProgress() {
    final mapWidth = gameRef.map.getMapSize().x;
    final curPoint = position.x;
    final percentComplete = ((curPoint / mapWidth) * 100).round();

    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Our hero is $percentComplete% complete.'),
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
}
